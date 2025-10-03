# n8n Projects Collection

本倉庫用來保存我在不同時期（例如 2025-08、2025-10）的 **n8n 自動化流程練習與設定**。

## 📂 專案結構

```yaml
n8n/
├─ 2025-08/
│  ├─ docker-compose.yml
│  ├─ README.md   👈 說明 8 月版本
│  └─ ...
├─ 2025-10/
│  ├─ docker-compose.yml
│  ├─ README.md   👈 說明 10 月版本
│  └─ ...
├─ .gitignore
└─ README.md      👈 專案總說明
```

- `2025-08/`  
  2025 年 8 月版本的 n8n 設定與實作。
- `2025-10/`  
  2025 年 10 月版本的 n8n 設定與實作。

> 每個資料夾都有獨立的 `docker-compose.yml` 以及對應的 `README.md`，方便快速啟動或回顧。

## 🚀 使用方式

1. 先進入想要的版本資料夾，例如：
   ```bash
   cd 2025-10
   ```

## git push

### 📝 建議你的 .gitignore 寫法（放在 n8n/ 根目錄）

```bash
# n8n runtime data
*/n8n_data/
*.sqlite
*.db
*.log
*.journal

# Node / 系統雜項
node_modules/
dist/
.DS_Store
Thumbs.db
.vscode/
```

```powershell
cd D:\docker\n8n
git init
git branch -M main
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/haha1811/n8n.git
git push -u origin main
```

### 後續你可以這樣操作

#### 🔄 更新檔案並推送

1. 修改或新增檔案
2. 執行：

   ```bash
   git add .
   git commit -m "update: 說明更新的內容"
   git push
   ```

#### 🌿 建立新版本資料夾

如果下個月還有 `2025-11` 版本：

```bash
mkdir 2025-11
cd 2025-11
# 放 docker-compose.yml、README.md 等
cd ..
git add .
git commit -m "add 2025-11 version"
git push
```

#### 👀 驗證 GitHub

去你的 repo 頁面 [https://github.com/haha1811/n8n](https://github.com/haha1811/n8n) 看看，應該就能看到所有檔案結構了。

---
