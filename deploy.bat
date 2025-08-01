@echo off
echo ========================================
echo 小程序商城 Docker 一键部署脚本
echo ========================================

echo 步骤1: 创建必要目录结构...
mkdir src 2>nul
mkdir uploads 2>nul
mkdir logs\nginx 2>nul
mkdir logs\php 2>nul
mkdir logs\mysql 2>nul
mkdir logs\redis 2>nul
mkdir database\data 2>nul
mkdir database\redis 2>nul
mkdir docker\nginx 2>nul
mkdir docker\php 2>nul

echo 步骤2: 检查Docker是否运行...
docker --version >nul 2>&1
if errorlevel 1 (
    echo 错误: Docker未安装或未启动！
    echo 请先安装并启动Docker Desktop
    pause
    exit /b 1
)

echo 步骤3: 构建Docker镜像...
docker-compose build

echo 步骤4: 启动所有服务...
docker-compose up -d

echo 步骤5: 等待服务启动完成...
timeout /t 30 >nul

echo 步骤6: 显示服务状态...
docker-compose ps

echo ========================================
echo 部署完成！
echo ========================================
echo 主站访问地址: http://localhost:8080
echo 数据库管理: http://localhost:8081
echo 用户名: 123321qqqq
echo 密码: 123321qqqq
echo ========================================

echo 按任意键退出...
pause >nul