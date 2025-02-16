@echo off
echo Starting GitHub repository deletion...
powershell -ExecutionPolicy Bypass -File "%~dp0delete_repos.ps1"
echo Deletion process completed.
pause