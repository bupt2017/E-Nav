# 使用官方Go镜像作为构建环境
FROM golang:1.24.1-alpine AS builder

# 安装 git
RUN apk add --no-cache git

# 设置工作目录
WORKDIR /app

# 从GitHub克隆代码
RUN git clone https://github.com/ecouus/E-Nav.git .

# 安装依赖并编译
RUN go mod init E-Nav && \
    go mod tidy && \
    go build -o E-Nav

# 使用轻量级alpine作为运行环境
FROM alpine:latest

# 设置工作目录
WORKDIR /app

# 从builder阶段复制编译好的程序和必要文件
COPY --from=builder /app/E-Nav .
COPY --from=builder /app/templates/ templates/
COPY --from=builder /app/data/ data/

# 声明数据卷
VOLUME ["/app/data"]

# 暴露端口
EXPOSE 1239

# 启动应用
CMD ["./E-Nav"]
