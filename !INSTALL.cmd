@powershell -NoProfile -WindowStyle Hidden -Command Start-Process schtasks -Verb runAs -WindowStyle Hidden -ArgumentList '/create /ru \"\" /tn TouchSwitchTask /sc onlogon /rl highest /f /tr \"cmd /c powershell -NoProfile -WindowStyle Hidden -File \"\"\"%~dp0main.ps1\"\"\"\"'