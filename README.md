# E-Nav 一键部署脚本

E-Nav 是一个简洁、美观的导航网站系统。支持一键部署，方便快捷。后台管理功能强大，可以轻松管理您的导航站点。

## 特性
- 🚀 一键部署/卸载
- 💻 简洁的后台管理界面
- 🔒 安全的权限控制
- 🎨 美观的界面设计

## 后台管理
- 访问地址：`http://您的域名:1239/admin`
- 默认密码：`admin`
- 请及时修改默认密码以确保安全

## 快速开始

### 方法一：一键脚本（推荐）

1. 安装
```bash
curl -fsSL https://raw.githubusercontent.com/ecouus/E-Nav/main/One-Click.sh -o One-Click.sh && chmod +x One-Click.sh && bash One-Click.sh install
```

2. 卸载
```bash
curl -fsSL https://raw.githubusercontent.com/ecouus/E-Nav/main/One-Click.sh -o One-Click.sh && chmod +x One-Click.sh && bash One-Click.sh uninstall
```

### 方法二：手动部署
1. 安装必要软件
```bash
apt update
apt install -y git
```

2. 安装 Go
```bash
wget https://go.dev/dl/go1.24.1.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.24.1.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> /root/.bashrc
source /root/.bashrc
```

3. 克隆项目
```bash
cd /root
git clone https://github.com/ecouus/E-Nav.git
cd E-Nav
```

4. 初始化和编译
```bash
go mod init E-Nav
go mod tidy
go build -o E-Nav
```

5. 创建系统服务
```bash
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
```

6. 启动服务
```bash
systemctl daemon-reload
systemctl enable E-Nav
systemctl start E-Nav
```

## 常用命令
```bash
# 查看服务状态
systemctl status E-Nav

# 启动服务
systemctl start E-Nav

# 停止服务
systemctl stop E-Nav

# 重启服务
systemctl restart E-Nav

# 查看日志
journalctl -u E-Nav
```

## 注意事项
- 请确保使用root用户执行脚本
- 本机部署需确保服务器1239端口未被占用
- 建议安装完成后及时修改后台密码
- 如遇问题，请查看服务日志排查

## 许可证
[GPL-3.0 license](https://github.com/ecouus/E-Nav/blob/main/LICENSE)
