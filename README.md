# 小程序商城 Docker 部署方案

## 项目概述
这是一个完整的小程序商城 Docker 化部署方案，解决了本地文件系统权限限制问题。

## 环境要求
- Docker Desktop for Windows
- 8GB+ 可用磁盘空间
- 2GB+ 可用内存

## 快速部署指南

### 方法一：完整自动化部署（推荐）

1. **克隆项目**
   ```bash
   git clone https://github.com/yelanbeyond/miniprogram-mall-docker.git
   cd miniprogram-mall-docker
   ```

2. **执行一键部署脚本**
   ```bash
   .\deploy.bat
   ```

3. **访问服务**
   - 主站：http://localhost:8080
   - 数据库管理：http://localhost:8081
   - 用户名：123321qqqq
   - 密码：123321qqqq

### 方法二：手动部署（适用于特殊环境）

1. **下载项目文件**
   - 访问：https://github.com/yelanbeyond/miniprogram-mall-docker
   - 点击 "Code" > "Download ZIP"
   - 解压到 `A:\ai写程序\all\` 目录

2. **创建必要目录**
   ```powershell
   New-Item -ItemType Directory -Path "A:\ai写程序\all\src" -Force
   New-Item -ItemType Directory -Path "A:\ai写程序\all\uploads" -Force
   New-Item -ItemType Directory -Path "A:\ai写程序\all\logs\nginx" -Force
   New-Item -ItemType Directory -Path "A:\ai写程序\all\logs\php" -Force
   New-Item -ItemType Directory -Path "A:\ai写程序\all\logs\mysql" -Force
   New-Item -ItemType Directory -Path "A:\ai写程序\all\logs\redis" -Force
   New-Item -ItemType Directory -Path "A:\ai写程序\all\database\data" -Force
   New-Item -ItemType Directory -Path "A:\ai写程序\all\database\redis" -Force
   ```

3. **复制源代码**
   - 手动复制 `A:\xiaochengxu\www\*` 到 `A:\ai写程序\all\src\`

4. **启动 Docker 服务**
   ```bash
   docker-compose up -d
   ```

## 服务架构

- **Nginx**: Web服务器 (端口8080)
- **PHP-FPM**: PHP处理器
- **MySQL 5.7**: 数据库 (端口3306)
- **Redis**: 缓存服务 (端口6379)
- **phpMyAdmin**: 数据库管理 (端口8081)

## 故障排除

### 常见问题
1. **端口占用**: 修改 docker-compose.yml 中的端口映射
2. **权限问题**: 使用管理员权限运行命令
3. **内存不足**: 调整 MySQL 内存配置

### 日志查看
```bash
docker-compose logs -f [服务名]
```

### 重置服务
```bash
docker-compose down -v
docker-compose up -d
```

## 技术栈
- ThinkPHP 6.x
- MySQL 5.7
- Nginx 1.x
- Redis 6.x
- PHP 7.4+

## 开发团队
基于腾讯云原版项目改造的 Docker 化部署方案。

## 许可证
MIT License