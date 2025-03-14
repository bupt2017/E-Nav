# E-Nav 一键部署脚本

E-Nav 是一个简洁、美观的导航网站系统。支持一键部署，方便快捷。并支持后台管理，可以轻松管理您的导航站点。

## 特性
- 🚀 一键部署/卸载
- 💻 简洁的后台管理界面
- 🔒 安全的权限控制
- 🎨 美观的界面设计

## 后台管理
- 访问地址：`http://您的域名:1239/admin`
- 默认密码：`admin`
- 请及时修改默认密码以确保安全

## Demo
- 电脑端/手机端
![5998c96ea36eb0d5bd663938c0110bfa.png](https://i.miji.bid/2025/03/14/5998c96ea36eb0d5bd663938c0110bfa.png)
## 快速开始


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

## 特色功能
1. **智能图标处理**
   - 自动获取网站favicon
   - 支持自定义图标
   - 优雅的降级处理机制

2. **高级搜索功能**
   - 实时搜索和过滤
   - 支持搜索网站名称和描述
   - 集成百度搜索功能

3. **用户体验优化**
   - 平滑滚动效果
   - 点击波纹动画
   - 加载动画
   - 响应式设计

4. **安全特性**
   - bcrypt密码加密
   - 会话管理
   - 安全的认证机制

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
