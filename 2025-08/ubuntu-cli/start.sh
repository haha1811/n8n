#!/usr/bin/env bash
set -e

# === 可調參數區 ===
N8N_HOST="${N8N_HOST:-n8n}"
N8N_PORT="${N8N_PORT:-5678}"
TARGET_URL="${TARGET_URL:-http://$N8N_HOST:$N8N_PORT}"

# ngrok 內建 web UI (4040) 如果之後想查 Tunnel 資訊可以用
NGROK_API_URL="${NGROK_API_URL:-http://127.0.0.1:4040/api/tunnels}"

MAX_RETRIES="${MAX_RETRIES:-20}"   # 最多等幾次 n8n
SLEEP_SECONDS="${SLEEP_SECONDS:-3}"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] [my-ubuntu-cli] $*"
}

# 當容器被 stop 時，優雅關閉 ngrok
cleanup() {
  log "Received stop signal, shutting down ngrok..."
  pkill ngrok || true
  exit 0
}
trap cleanup SIGTERM SIGINT

log "Container started, waiting for $TARGET_URL ..."

# 1. 等 n8n 起來
retry=0
until curl -s "$TARGET_URL" >/dev/null 2>&1; do
  retry=$((retry+1))
  if [ "$retry" -ge "$MAX_RETRIES" ]; then
    log "ERROR: $TARGET_URL still not reachable after $MAX_RETRIES retries, exiting."
    exit 1
  fi
  log "n8n not ready yet (try $retry/$MAX_RETRIES), retry in ${SLEEP_SECONDS}s..."
  sleep "$SLEEP_SECONDS"
done

log "n8n is reachable at $TARGET_URL, curl OK."

# 2. 確認有 authtoken
if [ -z "$NGROK_AUTHTOKEN" ]; then
  log "ERROR: NGROK_AUTHTOKEN is empty, please set it in .env"
  exit 1
fi

# 3. 永遠覆蓋 ngrok authtoken（避免舊設定殘留）
log "Configure/overwrite ngrok authtoken..."
ngrok config add-authtoken "$NGROK_AUTHTOKEN"
log "Authtoken saved to /root/.config/ngrok/ngrok.yml"

# 4. 啟動 ngrok tunnel 指向 n8n
#log "Starting ngrok tunnel to $TARGET_URL ..."
#ngrok http "$TARGET_URL" &

## 啟動 ngrok 時掛上 policy + 固定 domain
log "Starting ngrok tunnel to $TARGET_URL with domain $NGROK_DOMAIN ..."
ngrok http "$TARGET_URL" \
  --url "$NGROK_DOMAIN" \
  --traffic-policy-file "$POLICY_FILE" &


# （選用）如果未來想顯示 ngrok 產生的 URL，就可以開下面這段
# sleep 5
# if curl -s "$NGROK_API_URL" >/dev/null 2>&1; then
#   PUBLIC_URL=$(curl -s "$NGROK_API_URL" | grep -o '"public_url":"[^"]*"' | head -n1 | cut -d'"' -f4)
#   log "Ngrok tunnel public URL: $PUBLIC_URL"
# else
#   log "Ngrok API not reachable yet, skip printing public URL."
# fi

# 5. 保持容器存活
log "All done, container is now running. Press Ctrl+C or docker stop to exit."
tail -f /dev/null
