@echo off
fltmc >nul 2>&1 || (
	powershell -NoProfile -WindowStyle Hidden -Command Start-Process '%~dpnx0' -Verb RunAs -WindowStyle Hidden
	exit/b
)

cd/d %~dp0

if not exist .main.pid goto wait
set/p pid=<.main.pid
del/f/q .main.pid
taskkill/f/pid %pid%
if %errorlevel% neq 0 set err=1

:wait
if not exist .wait.pid goto end
set/p pid=<.wait.pid
del/f/q .wait.pid
taskkill/f/pid %pid%
if %errorlevel% neq 0 set err=1

:end
if defined err pause
