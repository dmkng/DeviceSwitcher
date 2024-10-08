@echo off
set/p main=<"%~dp0.main.pid"
waitfor.exe /S %computername% /SI DeviceSwitcher%main% >nul
