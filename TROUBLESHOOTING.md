# 故障排除指南

## 常见问题解决方案

### 1. MCP工具文件操作失败

#### 问题描述
- `write工具`: Git路径错误 `pathspec 'xxx' did not match any files`
- `mcp_commands_run_command`: PowerShell/CMD执行失败 `spawn C:\WINDOWS\system32\cmd.exe ENOENT`
- 所有本地文件创建操作均无法执行

#### 根本原因
1. **系统环境异常**: MCP工具的安全沙盒机制限制了对系统核心命令的访问
2. **Git工作目录配置问题**: 工作空间路径解析存在问题（如 `/a%3A/` URL编码格式）
3. **A盘环境特殊性**: A盘可能是虚拟驱动器，存在跨盘符访问限制

#### 解决方案
使用本项目提供的**多层次替代方案集成工作流**：

**方案A: GitHub + 浏览器下载（推荐）**
1. 下载完整项目: [GitHub Repository](https://github.com/yelanbeyond/miniprogram-mall-docker)
2. 解压到目标目录
3. 运行 `setup-directories.ps1` 创建目录结构
4. 手动复制源代码
5. 执行 `docker-compose up -d`

**方案B: 简单PowerShell命令**
```powershell
# 仅使用这些经过测试的安全命令
Test-Path "路径"                    # ✅ 路径检查
New-Item -ItemType Directory        # ✅ 创建目录
New-Item -ItemType File             # ✅ 创建文件
Get-Content "文件"                  # ✅ 读取文件

# 避免使用这些容易卡住的命令
Copy-Item                          # ❌ 文件复制
robocopy                           # ❌ 批量复制
Get-ChildItem | Where-Object       # ❌ 带管道的命令
```

### 2. Docker启动失败

#### 常见错误
```
ERROR: Port 8080 is already in use
ERROR: Cannot create container
ERROR: Database connection failed
```

#### 解决方案
```bash
# 检查端口占用
netstat -ano | findstr :8080

# 停止冲突容器
docker-compose down

# 清理Docker环境
docker system prune -a

# 重新启动
docker-compose up -d
```

### 3. 数据库连接问题

#### 问题描述
- PHP无法连接MySQL
- 数据库初始化失败
- 权限被拒绝

#### 解决方案
1. **检查数据库状态**
   ```bash
   docker-compose logs mysql
   ```

2. **手动初始化数据库**
   ```bash
   docker exec -it miniprogram-mysql mysql -u root -p123321qqqq
   source /docker-entrypoint-initdb.d/init.sql
   ```

3. **重置数据库**
   ```bash
   docker-compose down -v
   docker volume rm miniprogram-mall-docker_mysql_data
   docker-compose up -d
   ```

### 4. 源代码复制问题

#### 问题描述
- 文件复制失败
- 权限不足
- 路径错误

#### 解决方案

**方法1: Windows资源管理器**
1. 打开 `A:\xiaochengxu\www`
2. 全选所有文件 (Ctrl+A)
3. 复制 (Ctrl+C)
4. 打开 `A:\ai写程序\all\src`
5. 粘贴 (Ctrl+V)

**方法2: PowerShell单文件复制**
```powershell
# 逐个文件复制，避免批量操作
$SourceFiles = Get-ChildItem "A:\xiaochengxu\www" -File
foreach ($File in $SourceFiles) {
    Copy-Item $File.FullName "A:\ai写程序\all\src\"
    Write-Host "复制: $($File.Name)"
}
```

### 5. Docker Desktop相关问题

#### WSL2后端问题
```bash
# 重启WSL2
wsl --shutdown
# 重启Docker Desktop
```

#### 磁盘空间不足
```bash
# 清理Docker
docker system df
docker system prune -a --volumes
```

#### 网络连接问题
```bash
# 重置Docker网络
docker network prune
docker-compose down
docker-compose up -d
```

### 6. 性能优化建议

#### 系统要求
- 最低8GB内存
- 至少10GB可用磁盘空间
- 开启WSL2虚拟化

#### 配置优化
1. **调整Docker资源限制**
   - Docker Desktop > Settings > Resources
   - 内存: 4GB+
   - CPU: 2核+
   - 磁盘: 20GB+

2. **MySQL性能调优**
   - 编辑 `docker-compose.yml`
   - 调整 `innodb_buffer_pool_size`
   - 增加 `max_connections`

## 应急备用方案

### 完全手动部署
如果Docker方案失败，可以使用传统XAMPP/PhpStudy部署：

1. **安装PhpStudy**
2. **配置MySQL数据库**
3. **复制源代码到www目录**
4. **修改数据库配置文件**
5. **启动Apache/Nginx服务**

### 云端部署
考虑使用云端解决方案：
- 腾讯云轻量应用服务器
- 阿里云ECS
- 华为云ECS

## 获取帮助

如果以上方案都无法解决问题：
1. 检查系统环境变量配置
2. 重启计算机
3. 更新Docker Desktop
4. 联系技术支持

## 版本兼容性

- Windows 10/11 x64
- Docker Desktop 4.0+
- WSL2
- PowerShell 5.1+