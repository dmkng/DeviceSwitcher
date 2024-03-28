@powershell -NoProfile -WindowStyle Hidden -Command Start-Process powershell -Verb RunAs -WindowStyle Hidden -ArgumentList '-NoProfile -WindowStyle Hidden -File \"%~dp0main.ps1\"'
