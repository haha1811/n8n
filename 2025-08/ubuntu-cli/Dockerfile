FROM ubuntu:24.04

# 非互動式安裝
ENV DEBIAN_FRONTEND=noninteractive

# 基本工具 + curl
RUN apt-get update && \
    apt-get install -y curl iputils-ping

# 安裝 ngrok（官方建議方式）
RUN curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
    | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
    && echo "deb https://ngrok-agent.s3.amazonaws.com bookworm main" \
    | tee /etc/apt/sources.list.d/ngrok.list \
    && apt-get update \
    && apt-get install -y ngrok \
    && rm -rf /var/lib/apt/lists/*

# 建立工作目錄
RUN mkdir -p /root/demo
WORKDIR /root/demo

# 啟動腳本
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# 預設執行啟動腳本
CMD ["/usr/local/bin/start.sh"]
