@powershell -NoProfile -WindowStyle Hidden -Command Start-Process schtasks -Verb RunAs -WindowStyle Hidden -ArgumentList '/Delete /TN DeviceSwitcherTask /F'
