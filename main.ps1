# Device ID (can be found in Device Manager under Properties > Details > Device Instance Path)
$Id = 'HID\VID_2386&PID_432F&COL02\6&2AE36198&0&0001' # Lenovo ThinkPad T480 Touch Screen

# Name displayed in the notification
$Name = 'Touch screen'

# Prefix of the icons displayed in the notification
# (icons with '-on.png', '-off.png', '-err.png', -on-dark.png', '-off-dark.png' and '-err-dark.png' suffix must exist in the same directory as DeviceSwitcher)
$Icon = 'screen'

##################################################

$ErrorActionPreference = 'SilentlyContinue'

if(-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
	Start-Process (Join-Path $PSHome 'powershell.exe') -Verb RunAs -WindowStyle Hidden -ArgumentList ('-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File ' + $MyInvocation.MyCommand.Definition)
	exit
}

Set-Location $PSScriptRoot

Set-Content .main.pid $PID

[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] > $null
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null

$Notify = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe')

$Suffix = If((Get-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme).AppsUseLightTheme -eq 0) { ".png" } Else { "-dark.png" }

$OnXml = New-Object Windows.Data.Xml.Dom.XmlDocument
$OnXml.LoadXml(@"
<toast duration='short' scenario='urgent'>
	<audio silent='true'/>
	<visual>
		<binding template='ToastGeneric'>
			<image id="1" placement='appLogoOverride' src='$PSScriptRoot\$Icon-off$Suffix'/>
			<text id="1">$Name has been disabled.</text>
			<text id="2" placement='attribution'>DeviceSwitcher</text>
		</binding>
	</visual>
</toast>
"@)

$OffXml = New-Object Windows.Data.Xml.Dom.XmlDocument
$OffXml.LoadXml(@"
<toast duration='short' scenario='urgent'>
	<audio silent='true'/>
	<visual>
		<binding template='ToastGeneric'>
			<image id="1" placement='appLogoOverride' src='$PSScriptRoot\$Icon-on$Suffix'/>
			<text id="1">$Name has been enabled.</text>
			<text id="2" placement='attribution'>DeviceSwitcher</text>
		</binding>
	</visual>
</toast>
"@)

$ErrXml = New-Object Windows.Data.Xml.Dom.XmlDocument
$ErrXml.LoadXml(@"
<toast duration='long' scenario='urgent'>
	<visual>
		<binding template='ToastGeneric'>
			<image id='1' placement='appLogoOverride' src='$PSScriptRoot\$Icon-err$Suffix'/>
			<text id='1'>$Name can't be switched.</text>
			<text id='2'>$val Either the device wasn't found or some error occured.</text>
			<text id='3' placement='attribution'>DeviceSwitcher</text>
		</binding>
	</visual>
</toast>
"@)

Function SignalCheck {
	$WaitId = (Start-Process -PassThru -NoNewWindow -RedirectStandardOutput NUL waitfor DeviceSwitcher$PID).Id
	Set-Content .wait.pid $WaitId
	Wait-Process $WaitId
}

while($true) {
	$Item = Get-PnpDevice $Id
	if($Item.Status -eq 'OK') {
		SignalCheck
		Disable-PnpDevice $Id -Confirm:$false
		$Notify.Show([Windows.UI.Notifications.ToastNotification]::new($OffXml))
	} elseif($Item.Status -eq 'Error') {
		SignalCheck
		Enable-PnpDevice $Id -Confirm:$false
		$Notify.Show([Windows.UI.Notifications.ToastNotification]::new($OnXml))
	} else {
		$Notify.Show([Windows.UI.Notifications.ToastNotification]::new($ErrXml))
		Remove-Item .main.pid,.wait.pid -Force
		exit
	}
}
