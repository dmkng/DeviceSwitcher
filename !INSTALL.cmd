@echo off
fltmc.exe>nul 2>&1 || (
    powershell.exe -NoProfile -WindowStyle Hidden -Command Start-Process '%~dpnx0' -Verb RunAs -WindowStyle Hidden
    exit
)

set cfg=%tmp%\~ds%random%.tmp
(
echo ^<?xml version="1.0"?^>
echo ^<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task"^>^<Triggers^>^<LogonTrigger^>^<Enabled^>true^</Enabled^>^</LogonTrigger^>^</Triggers^>^<Principals^>^<Principal id="Author"^>^<GroupId^>S-1-5-32-545^</GroupId^>^<RunLevel^>HighestAvailable^</RunLevel^>^</Principal^>^</Principals^>^<Settings^>^<MultipleInstancesPolicy^>IgnoreNew^</MultipleInstancesPolicy^>^<DisallowStartIfOnBatteries^>false^</DisallowStartIfOnBatteries^>^<AllowHardTerminate^>false^</AllowHardTerminate^>^<StartWhenAvailable^>true^</StartWhenAvailable^>^<RunOnlyIfNetworkAvailable^>false^</RunOnlyIfNetworkAvailable^>^<AllowStartOnDemand^>true^</AllowStartOnDemand^>^<Enabled^>true^</Enabled^>^<Hidden^>false^</Hidden^>^<RunOnlyIfIdle^>false^</RunOnlyIfIdle^>^<WakeToRun^>false^</WakeToRun^>^<ExecutionTimeLimit^>PT0S^</ExecutionTimeLimit^>^<Priority^>7^</Priority^>^</Settings^>^<Actions Context="Author"^>^<Exec^>^<Command^>powershell^</Command^>^<Arguments^>-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File '%~dp0main.ps1'^</Arguments^>^</Exec^>^</Actions^>^</Task^>
)>"%cfg%"
set "id=%~dp0"
set "id=%id::=%"
schtasks.exe /Create /TN "DeviceSwitcher\%id:\=%" /XML "%cfg%" /F
del/f/q "%cfg%"
