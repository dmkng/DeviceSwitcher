@echo off
fltmc.exe>nul 2>&1 || (
	powershell.exe -NoProfile -WindowStyle Hidden -Command Start-Process '%~dpnx0' -Verb RunAs -WindowStyle Hidden
	exit
)

set "id=%~dp0"
set "id=%id::=%"
schtasks.exe /Delete /TN "DeviceSwitcher\%id:\=%" /F
