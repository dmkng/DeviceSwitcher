@echo off
if not "%~1" == "admin" (
	powershell -NoProfile -WindowStyle Hidden -Command Start-Process '%~dpnx0' -Verb runAs -ArgumentList admin
	exit /b
)
cd %~dp0
set /p main=<.main.pid
taskkill /f /pid %main%
if %errorlevel% neq 0 pause
set /p wait=<.wait.pid
taskkill /f /pid %wait%
if %errorlevel% neq 0 pause
