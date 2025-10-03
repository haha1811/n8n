# n8n 實作練習

## 🛠️ 建置教學 Part 1：n8n 環境建立

### 直接在本地安裝 n8n（適合開發人員）

```bash
# 安裝 Docker（若未安裝）
sudo apt install docker docker-compose -y

# 建立 n8n 容器
mkdir n8n && cd n8n
edit docker-compose.yml
```

### 新增 `docker-compose.yml` File

```yaml
version: "3.1"

services:
  n8n:
    image: n8nio/n8n
    restart: always
    ports:
      - 5678:5678
    environment:
      - GENERIC_TIMEZONE=Asia/Taipei
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=DDev12876266
    volumes:
      - ./n8n_data:/home/node/.n8n
```

```bash
# 啟動服務
docker-compose up -d
```

> 然後開啟瀏覽器進入：http://localhost:5678
> （登入帳密為你在上面設定的）

![image](https://hackmd.io/_uploads/rkThT2n3le.png)

## 🛠️ 建置教學 Part 2：建立每日比價流程
