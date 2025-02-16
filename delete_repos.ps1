# 读取 GitHub Token 文件
$tokenFile = "github-delete-token.txt"
if (-Not (Test-Path -Path $tokenFile)) {
    Write-Host "Token file not found: $tokenFile"
    exit
}
$token = Get-Content -Path $tokenFile -Raw | ForEach-Object { $_.Trim() }

# 读取仓库列表文件并清理内容
$repoFile = "repos.txt"
if (-Not (Test-Path -Path $repoFile)) {
    Write-Host "Repository list file not found: $repoFile"
    exit
}
$repos = Get-Content -Path $repoFile | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }

# 检查是否有有效的仓库名称
if ($repos.Count -eq 0) {
    Write-Host "No valid repositories found in $repoFile"
    exit
}

# 循环删除仓库
foreach ($repo in $repos) {
    if (-Not ($repo -match "^[^/]+/[^/]+$")) {
        Write-Host "Invalid repository format: $repo (expected format: username/repo)"
        continue
    }
    $uri = "https://api.github.com/repos/$repo"
    try {
        Invoke-RestMethod -Method Delete -Uri $uri -Headers @{ Authorization = "token $token" }
        Write-Host "Deleted repository: $repo"
    } catch {
        Write-Host "Failed to delete repository: $repo - $($_.Exception.Message)"
    }
}