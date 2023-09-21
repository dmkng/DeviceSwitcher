@powershell -NoProfile -WindowStyle Hidden -Command Start-Process powershell -Verb runAs -WindowStyle Hidden -ArgumentList '-NoProfile -WindowStyle Hidden -File \"%~dp0main.ps1\"'
