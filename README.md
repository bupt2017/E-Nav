# 🚀 E-Nav 导航站
![Docker](https://img.shields.io/badge/Docker-支持-blue?logo=docker)
![License](https://img.shields.io/badge/License-MIT-green)
![Version](https://img.shields.io/badge/Version-1.0.0-orange)

一个优雅、现代的个人导航站解决方案，让您的网址管理更轻松、更智能！

## ✨ 特性

<table>
  <tr>
    <td width="50%">
      <h3>🎯 快速部署</h3>
      <ul>
        <li>⚡️ 一键安装/卸载</li>
        <li>🐳 Docker容器化部署</li>
        <li>🔄 自动更新功能</li>
      </ul>
    </td>
    <td width="50%">
      <h3>👨‍💻 简单管理</h3>
      <ul>
        <li>💼 简洁的后台界面</li>
        <li>🔒 安全的权限控制</li>
        <li>📱 响应式设计</li>
      </ul>
    </td>
  </tr>
</table>

## 🌟 特色功能

### 🎨 智能图标处理
- 🖼️ 自动获取网站favicon
- 🎯 支持自定义图标上传
- 📦 内置优雅的降级处理机制

### 🔍 强大搜索
- ⚡️ 实时搜索与过滤
- 📝 全文本搜索支持
- 🔄 集成百度搜索功能

### ✨ 用户体验
- 🌊 平滑滚动效果
- 💫 精美点击动画
- 🎬 优雅加载过渡
- 📱 完美适配多端

### 🛡️ 安全防护
- 🔐 bcrypt密码加密
- 👤 会话管理机制
- 🚫 防注入与XSS防护

## 后台管理
- 访问地址：`http://您的域名:1239/admin`
- 默认密码：`admin`
- 请及时修改默认密码以确保安全

## Demo
- 电脑端/手机端
![5998c96ea36eb0d5bd663938c0110bfa.png](https://i.miji.bid/2025/03/14/5998c96ea36eb0d5bd663938c0110bfa.png)
## 🚀 快速开始


### 方法一：Docker部署（推荐）
```
docker run -d \
  --name e-nav \
  -p 1239:1239 \
  --restart unless-stopped \
  ecouus/e-nav:latest
```
-  -p 1239:1239 \中第一个1239可更改为其他任意的端口

### 方法二：本机一键脚本部署（推荐）

1. 安装
```bash
curl -fsSL https://raw.githubusercontent.com/ecouus/E-Nav/main/One-Click.sh -o One-Click.sh && chmod +x One-Click.sh && bash One-Click.sh install
```

2. 卸载
```bash
curl -fsSL https://raw.githubusercontent.com/ecouus/E-Nav/main/One-Click.sh -o One-Click.sh && chmod +x One-Click.sh && bash One-Click.sh uninstall
```
### 方法二：本机手动部署
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
## 技术架构

### 后端技术栈
- **框架**: Go (Golang)
- **路由**: Gorilla Mux
- **会话管理**: Gorilla Sessions
- **密码加密**: bcrypt
- **数据存储**: JSON文件存储
- **API**: RESTful架构

### 前端技术栈
- **布局**: HTML5 + CSS3
- **交互**: 原生JavaScript (ES6+)
- **图标**: Font Awesome
- **样式特性**:
  - Flexbox/Grid布局
  - CSS变量
  - 响应式设计
  - 深色模式支持
  - CSS动画和过渡效果

## 核心功能

### 用户界面
- 响应式布局，支持移动端访问
- 实时搜索和过滤功能
- 深色/浅色主题切换
- 分类导航系统
- 自动获取网站favicon
- 平滑滚动和动画效果

### 管理功能
- 管理员认证系统
- 书签管理（增删改查）
- 分类管理
- 密码修改功能

### 数据管理
- JSON文件持久化存储
- 自动备份机制
- 配置文件管理

## 项目结构
```
e-nav-go/
├── main.go        # 主程序文件
├── static/        # 静态文件目录
│   ├── css/       # CSS文件
│   ├── js/        # JavaScript文件
│   └── favicon.ico # 网站图标
├── templates/     # HTML模板目录
│   ├── index.html         # 主页模板
│   ├── admin_login.html   # 管理员登录页面
│   └── admin_dashboard.html # 管理员控制面板
├── bookmarks.json # 书签数据文件
└── config.json    # 配置文件
```

## 部署要求
- Go 1.16+
- 现代浏览器支持
- 建议使用HTTPS
## 注意事项
- 请确保使用root用户执行脚本
- 本机部署需确保服务器1239端口未被占用
- 建议安装完成后及时修改后台密码
- 如遇问题，请查看服务日志排查


## 许可证
[MIT License](https://github.com/ecouus/E-Nav/blob/main/LICENSE)
