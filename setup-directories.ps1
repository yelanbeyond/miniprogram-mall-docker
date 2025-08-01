# 小程序商城目录结构创建脚本
# PowerShell版本 - 适配MCP工具限制

Write-Host "===========================================" -ForegroundColor Green
Write-Host "小程序商城 Docker 目录结构创建" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Green

# 定义基础路径
$BasePath = "A:\ai写程序\all"
Write-Host "基础路径: $BasePath" -ForegroundColor Yellow

# 需要创建的目录列表
$Directories = @(
    "src",
    "uploads", 
    "logs\nginx",
    "logs\php", 
    "logs\mysql",
    "logs\redis",
    "database\data",
    "database\redis",
    "docker\nginx",
    "docker\php"
)

Write-Host "`n步骤1: 创建目录结构..." -ForegroundColor Cyan

foreach ($Dir in $Directories) {
    $FullPath = Join-Path $BasePath $Dir
    try {
        New-Item -ItemType Directory -Path $FullPath -Force | Out-Null
        Write-Host "✓ 创建: $Dir" -ForegroundColor Green
    }
    catch {
        Write-Host "✗ 失败: $Dir - $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n步骤2: 验证目录结构..." -ForegroundColor Cyan

$SuccessCount = 0
foreach ($Dir in $Directories) {
    $FullPath = Join-Path $BasePath $Dir
    if (Test-Path $FullPath) {
        Write-Host "✓ 存在: $Dir" -ForegroundColor Green
        $SuccessCount++
    } else {
        Write-Host "✗ 缺失: $Dir" -ForegroundColor Red
    }
}

Write-Host "`n===========================================" -ForegroundColor Green
Write-Host "创建完成: $SuccessCount/$($Directories.Count) 个目录" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Green

if ($SuccessCount -eq $Directories.Count) {
    Write-Host "✓ 所有目录创建成功！" -ForegroundColor Green
    Write-Host "下一步: 复制源代码到 src 目录" -ForegroundColor Yellow
    Write-Host "然后运行: docker-compose up -d" -ForegroundColor Yellow
} else {
    Write-Host "⚠ 部分目录创建失败，请检查权限" -ForegroundColor Yellow
}

Write-Host "`n按任意键继续..." -ForegroundColor Gray
Read-Host