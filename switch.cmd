@echo off
set/p main=<"%~dp0.main.pid"
waitfor /SI DeviceSwitcher%main% >nul
