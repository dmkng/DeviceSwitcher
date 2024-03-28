@echo off
set/p main=<"%~dp0.main.pid"
waitfor /si DeviceSwitcher%main%>NUL
