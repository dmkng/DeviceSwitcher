@echo off
fltmc >nul 2>&1
if %errorlevel% neq 0 (
	powershell -NoProfile -WindowStyle Hidden -Command Start-Process '%~dpnx0' -Verb RunAs -WindowStyle Hidden
	exit /b
)

cd/d %~dp0

set/p pid=<.main.pid
taskkill /F /PID %pid%
if %errorlevel% neq 0 pause

set/p pid=<.wait.pid
taskkill /F /PID %pid%
if %errorlevel% neq 0 pause
