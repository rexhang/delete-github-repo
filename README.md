# GitHub 仓库批量删除工具

这是一个用于快速删除 GitHub 上多个仓库的 PowerShell 脚本工具。通过读取仓库列表文件和 GitHub Token 文件，脚本可以自动批量删除指定的仓库，适合需要清理大量仓库的场景。

---

## **功能**
1. **批量删除仓库**：通过读取 `repos.txt` 文件中的仓库列表，自动删除多个 GitHub 仓库。
2. **自动清理输入**：脚本会自动清理 `repos.txt` 文件中的多余空格和空行，确保仓库名称格式正确。
3. **Token 文件支持**：从 `github-delete-token.txt` 文件中读取 GitHub 个人访问令牌（PAT），无需硬编码到脚本中。
4. **错误处理**：
   - 如果仓库名称格式不正确，脚本会跳过并提示错误。
   - 如果删除失败（例如权限不足或仓库不存在），脚本会捕获并显示错误信息。
5. **一键运行**：通过 `.cmd` 批处理文件，双击即可运行脚本，无需手动输入命令。

---

## **使用方法**

### **1. 创建 GitHub 个人访问令牌（PAT）**
1. 登录 GitHub，点击右上角头像，进入 **Settings**。
2. 在左侧菜单中选择 **Developer settings**。
3. 点击 **Personal access tokens**，然后选择 **Tokens (classic)**。
4. 点击 **Generate new token**，然后选择 **Generate new token (classic)**。
5. 在权限设置中，勾选 `repo` 和 `delete_repo` 权限（用于访问和删除仓库）。
6. 点击 **Generate token**，生成后复制 Token 并保存到 `github-delete-token.txt` 文件中。
   - **注意**：Token 只会显示一次，请妥善保存。

### **2. 准备工作**
1. 在脚本目录下创建以下文件：
   - `repos.txt`：列出要删除的仓库，每行一个，格式为 `用户名/仓库名`。
   - `github-delete-token.txt`：存放 GitHub 个人访问令牌（PAT）。
2. 确保 GitHub Token 具有 `repo` 和 `delete_repo` 权限。

### **3. 文件结构**
```
DeleteRepos/
│
├── repos.txt                # 仓库列表文件
├── github-delete-token.txt # GitHub Token 文件
├── delete_repos.ps1         # PowerShell 脚本
├── delete_repos.cmd         # 批处理文件
└── README.md                # 说明文档
```

### **4. 运行脚本**
1. 双击运行 `delete_repos.cmd`。
2. 脚本会自动读取 `repos.txt` 中的仓库列表并逐个删除。
3. 删除完成后，脚本会显示结果。

---

## **文件说明**

### **1. `repos.txt`**
- 格式：每行一个仓库，格式为 `用户名/仓库名`。
- 示例：
  ```
  myusername/repo1
  myusername/repo2
  myusername/repo3
  ```

### **2. `github-delete-token.txt`**
- 内容：GitHub 个人访问令牌（PAT）。
- 注意：确保文件内容只有 Token 本身，没有多余的空格或换行。

### **3. `delete_repos.ps1`**
- PowerShell 脚本，用于读取文件并删除仓库。

### **4. `delete_repos.cmd`**
- 批处理文件，用于一键运行 PowerShell 脚本。

---

## **注意事项**
1. **备份数据**：删除仓库是不可逆操作，请提前备份重要数据。
2. **Token 安全**：确保 `github-delete-token.txt` 文件安全，避免泄露。
3. **权限检查**：确保 GitHub Token 具有 `repo` 权限。

---

## **示例**

### **1. `repos.txt` 示例**
```
myusername/old-repo1
myusername/old-repo2
myusername/nonexistent-repo
invalid-repo-format
```

### **2. 运行结果示例**

#### **成功删除**
```
Starting GitHub repository deletion...
Deleted repository: myusername/old-repo1
Deleted repository: myusername/old-repo2
Deletion process completed.
```

#### **部分成功，部分失败**
```
Starting GitHub repository deletion...
Deleted repository: myusername/old-repo1
Failed to delete repository: myusername/nonexistent-repo - 404 Not Found
Invalid repository format: invalid-repo-format (expected format: username/repo)
Deletion process completed.
```

#### **全部失败**
```
Starting GitHub repository deletion...
Failed to delete repository: myusername/nonexistent-repo - 404 Not Found
Invalid repository format: invalid-repo-format (expected format: username/repo)
Deletion process completed.
```

---

## **贡献**
如果你有任何改进建议或发现问题，欢迎提交 Issue 或 Pull Request！

---

## **许可证**
本项目基于 [MIT 许可证](LICENSE) 开源。
