@echo off
fltmc >nul 2>&1 || (
	powershell -NoProfile -WindowStyle Hidden -Command Start-Process '%~dpnx0' -Verb RunAs -WindowStyle Hidden
	exit/b
)

schtasks /Delete /TN DeviceSwitcherTask /F
