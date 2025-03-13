### 1. 卸载旧版本（如果已安装）

如果系统中已通过 `apt` 安装了旧版本的 Go，建议先卸载：

```bash
sudo apt remove --purge golang-go
sudo rm -rf /usr/local/go
```

### 2. 下载最新版本的 Go

访问 Go 的官方发布页面：[Go Downloads](https://go.dev/dl/) ，选择适合你的操作系统和架构的版本。

例如，如果你的架构是 `amd64`，可以使用以下命令下载最新版本的 Go（以 `go1.20.5` 为例，替换成你需要的最新版本号）：

```bash
wget https://go.dev/dl/go1.24.1.linux-amd64.tar.gz
```

### 3. 安装 Go

解压下载的 Go 压缩包到 `/usr/local` 目录：

```bash
sudo tar -C /usr/local -xzf go1.24.1.linux-amd64.tar.gz
```

### 4. 设置 Go 的环境变量

接下来，需要设置 Go 的环境变量。在 `~/.bashrc` 或 `~/.profile` 文件中添加以下内容：

```bash
export PATH=$PATH:/usr/local/go/bin
```

使环境变量配置生效：

```bash
source ~/.bashrc
```

或者：

```bash
source ~/.profile
```

### 5. 验证 Go 是否安装成功

通过以下命令确认 Go 是否正确安装：

```bash
go version
```

如果安装成功，你会看到类似如下的输出：

```bash
go version go1.24.1 linux/amd64
```

---

### 6. 更新系统（可选）

如果需要更新系统，可以运行以下命令：

```bash
sudo apt update
sudo apt upgrade -y
```

---

### 7. 安装 Git（如果尚未安装）

如果系统中尚未安装 Git，可以使用以下命令安装：

```bash
sudo apt install -y git
```

---

### 8. 创建项目目录

创建并进入项目目录：

```bash
mkdir -p ~/e-nav-go
cd ~/e-nav-go
```

创建项目的子目录：

```bash
mkdir -p static templates
```

---

### 9. 创建并编辑文件

创建和编辑 Go 主程序文件：

```bash
nano main.go
```

编辑模板文件：

```bash
nano templates/index.html
nano templates/admin_login.html
nano templates/admin_dashboard.html
```

创建静态资源目录和文件：

```bash
mkdir -p static/css static/js static/img
nano static/favicon.ico
```

---

### 10. 初始化 Go 模块

在项目根目录下初始化 Go 模块：

```bash
go mod init e-nav-go
```

安装依赖：

```bash
go get github.com/gorilla/mux
go get github.com/gorilla/sessions
go get golang.org/x/crypto/bcrypt
```

---

### 11. 编译项目

编译 Go 项目：

```bash
go build -o e-nav-go
```

---

### 12. 运行程序

运行编译后的程序并将其置于后台运行：

```bash
./e-nav-go &
```

服务器将运行在 `http://localhost:8080`。使用 `&` 将程序放到后台执行，这样你可以继续在终端执行其他命令。

---

### 13. 停止正在运行的程序

如果你想停止已经在后台运行的 Go 程序，可以使用 `pkill -f main` 来终止进程：

```bash
pkill -f main
```

这将根据进程命令行中的 `main` 字符串来找到并杀死相关的 Go 程序进程。

---

### 14. 设置为系统服务（可选）

创建并编辑 systemd 服务文件：

```bash
sudo nano /etc/systemd/system/e-nav-go.service
```

将以下内容粘贴到文件中（替换 `<您的用户名>` 为实际的用户名）：

```ini
[Unit]
Description=E-Nav Go Web Application
After=network.target

[Service]
Type=simple
User=<您的用户名>
WorkingDirectory=/home/<您的用户名>/e-nav-go
ExecStart=/home/<您的用户名>/e-nav-go/e-nav-go
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

重新加载 systemd 配置：

```bash
sudo systemctl daemon-reload
```

启用服务（设置为开机自启）：

```bash
sudo systemctl enable e-nav-go.service
```

启动服务：

```bash
sudo systemctl start e-nav-go.service
```

检查服务状态：

```bash
sudo systemctl status e-nav-go.service
```

---

通过这个更新后的教程，你不仅可以安装并运行最新版本的 Go，还能轻松启动和停止你的 Go 程序，甚至将其设置为后台服务。

sudo lsof -i :8080
sudo kill -9 2032348

sudo rm -f /etc/systemd/system/e-nav-go.service && sudo systemctl daemon-reload && rm -rf ~/e-nav-go && go clean -modcache && sudo rm -rf /usr/local/go && sudo apt remove --purge git && sudo apt autoremove && sed -i '/\/usr\/local\/go\/bin/d' ~/.bashrc && source ~/.bashrc && sudo apt autoremove && sudo apt clean
