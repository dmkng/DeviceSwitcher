$Id = 'HID\VID_2386&PID_432F&COL02\6&2AE36198&0&0001'

##################################################

$ErrorActionPreference = 'SilentlyContinue'

Set-Location $PSScriptRoot

Set-Content .main.pid $PID

[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] > $null
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null

$Xml = New-Object Windows.Data.Xml.Dom.XmlDocument
$Notify = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe')

while($true) {
    $Item = Get-PnpDevice -InstanceId $Id -Class 'HIDClass'
    if($Item.Status -eq 'OK') {
	$WaitId = (Start-Process -PassThru -NoNewWindow -RedirectStandardOutput NUL waitfor DeviceSwitcher$PID).Id
        Set-Content .wait.pid $WaitId
        Wait-Process $WaitId

        Disable-PnpDevice $Id -Confirm:$false

        $Xml.LoadXml(@"
<toast>
    <audio silent='true'/>
    <visual>
        <binding template='ToastGeneric'>
            <text>Touch screen has been disabled.</text>
            <image placement='appLogoOverride' src='$($PSScriptRoot)\icon-off.png'/>
        </binding>
    </visual>
</toast>
"@)
        $Notify.Show([Windows.UI.Notifications.ToastNotification]::new($Xml))
    } elseif($Item.Status -eq 'Error') {
	$WaitId = (Start-Process -PassThru -NoNewWindow -RedirectStandardOutput NUL waitfor DeviceSwitcher$PID).Id
        Set-Content .wait.pid $WaitId
        Wait-Process $WaitId

        Enable-PnpDevice $Id -Confirm:$false

        $Xml.LoadXml(@"
<toast>
    <audio silent='true'/>
    <visual>
        <binding template='ToastGeneric'>
            <text>Touch screen has been enabled.</text>
            <image placement='appLogoOverride' src='$($PSScriptRoot)\icon-on.png'/>
        </binding>
    </visual>
</toast>
"@)
        $Notify.Show([Windows.UI.Notifications.ToastNotification]::new($Xml))
    }
}
