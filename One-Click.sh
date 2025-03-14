#!/bin/bash

# 颜色定义
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
NC="\033[0m"

# 检查命令行参数
if [ $# -eq 0 ]; then
    echo -e "${RED}请指定操作: install 或 uninstall${NC}"
    echo -e "使用方法:"
    echo -e "  ${GREEN}./One-Click.sh install${NC}   - 安装 E-Nav"
    echo -e "  ${GREEN}./One-Click.sh uninstall${NC} - 卸载 E-Nav"
    exit 1
fi

# 检查是否为root用户
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}请使用root用户运行此脚本${NC}"
    exit 1
fi

# 安装函数
install() {
    echo -e "${GREEN}开始安装 E-Nav...${NC}"

    # 检查并安装必要的软件
    echo -e "${YELLOW}检查并安装必要的软件...${NC}"
    if ! command -v git &> /dev/null; then
        apt-get update
        apt-get install -y git
    fi

    # 检查并安装Go
    if ! command -v go &> /dev/null; then
        echo -e "${YELLOW}未检测到Go,开始安装...${NC}"
        wget https://golang.google.cn/dl/go1.24.1.linux-amd64.tar.gz
        tar -C /usr/local -xzf go1.24.1.linux-amd64.tar.gz
        echo 'export PATH=$PATH:/usr/local/go/bin' >> /root/.bashrc
        source /root/.bashrc
        rm go1.24.1.linux-amd64.tar.gz
    fi

    # 克隆项目
    echo -e "${GREEN}克隆项目...${NC}"
    cd /root
    git clone https://github.com/ecouus/E-Nav.git
    cd E-Nav

    # 初始化Go项目
    echo -e "${GREEN}初始化Go项目...${NC}"
    go mod init E-Nav
    go mod tidy

    # 编译项目
    echo -e "${GREEN}编译项目...${NC}"
    go build -o E-Nav

    # 创建系统服务
    echo -e "${GREEN}创建系统服务...${NC}"
    cat > /etc/systemd/system/E-Nav.service << EOF
[Unit]
Description=E-Nav Go Web Application
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/root/E-Nav
ExecStart=/root/E-Nav/E-Nav
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable E-Nav
    systemctl start E-Nav

    # 检查服务状态
    if systemctl is-active --quiet E-Nav; then
        echo -e "${GREEN}E-Nav 安装成功!${NC}"
        echo -e "${GREEN}您可以通过访问 http://服务器IP:1239 来使用导航站${NC}"
    else
        echo -e "${RED}E-Nav 安装失败,请检查日志${NC}"
        exit 1
    fi
}

# 卸载函数
uninstall() {
    echo -e "${YELLOW}开始彻底卸载 E-Nav...${NC}"
    
    # 停止并禁用服务
    if systemctl is-active --quiet E-Nav; then
        echo -e "${YELLOW}停止并禁用 E-Nav 服务...${NC}"
        systemctl stop E-Nav
        systemctl disable E-Nav
    fi
    
    # 删除服务文件
    echo -e "${YELLOW}删除服务文件...${NC}"
    rm -f /etc/systemd/system/E-Nav.service
    systemctl daemon-reload
    
    # 删除项目文件
    echo -e "${YELLOW}删除项目文件...${NC}"
    rm -rf /root/E-Nav
    
    # 清理Go相关
    echo -e "${YELLOW}清理Go环境...${NC}"
    go clean -modcache
    rm -rf /usr/local/go
    
    # 删除PATH中的Go路径
    echo -e "${YELLOW}清理环境变量...${NC}"
    sed -i '/\/usr\/local\/go\/bin/d' /root/.bashrc
    source /root/.bashrc
    
    # 卸载git
    echo -e "${YELLOW}卸载git...${NC}"
    apt remove --purge -y git
    
    # 清理无用依赖
    echo -e "${YELLOW}清理系统...${NC}"
    apt autoremove -y
    apt clean
    
    echo -e "${GREEN}E-Nav 已完全卸载${NC}"
    echo -e "${GREEN}系统已清理完毕${NC}"
}


# 根据参数执行相应操作
case "$1" in
    "install")
        install
        ;;
    "uninstall")
        uninstall
        ;;
    *)
        echo -e "${RED}无效的参数: $1${NC}"
        echo -e "使用方法:"
        echo -e "  ${GREEN}./One-Click.sh install${NC}   - 安装 E-Nav"
        echo -e "  ${GREEN}./One-Click.sh uninstall${NC} - 卸载 E-Nav"
        exit 1
        ;;
esac
