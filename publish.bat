@echo off
cd /d "D:\wait_what\Documents\quartz"

echo.
echo ?? 正在从 Obsidian 同步笔记...
robocopy "D:\wait_what\Documents\READ and practice\Public" content /E /XJ /XD ".obsidian" ".trash" >nul

echo.
echo ?? 正在提交到 GitHub...
git add content/
git commit -m "Update notes from Obsidian at %date% %time%" --quiet
git push origin main

echo.
echo ? 已成功推送！网站将在 1-2 分钟内更新。
echo 按任意键关闭...
pause >nul