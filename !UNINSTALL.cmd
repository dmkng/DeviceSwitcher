@powershell -NoProfile -Command Start-Process schtasks -Verb runAs -WindowStyle Hidden -ArgumentList '/delete /tn TouchSwitchTask /f'
