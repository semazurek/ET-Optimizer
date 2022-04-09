@echo off

:: #############################################################################################################################################
:: DO NOT TOUCH THIS PART INSIDE (PLEASE)

:: Check for admin permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

:: If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

:: Created by Rikey
set version=E.T. ver 4.2
title %version%

NET SESSION >nul 2>&1
IF %ERRORLEVEL% == 0 goto CheckVer

set announcement=Run the script as an Administrator.
echo %announcement%
powershell (New-Object -ComObject Wscript.Shell).Popup("""%announcement%""",0,"""%version%""",0x10)
:: Checks if it is running as administrator if not quit
exit

:: Checking version of Windows (10, 11 = 10 8.1 = 6.3)
:CheckVer
ver | findstr 10.0
if %errorlevel%==0 set ThisOS=10
ver | findstr 11.0
if %errorlevel%==0 set ThisOS=11
ver | findstr 6.3
if %errorlevel%==0 set ThisOS=81

if %ThisOS%==10 goto RestorePoint
if %ThisOS%==11 goto RestorePoint
if %ThisOS%==81 goto RestorePoint

set announcement=Unsupported version of the system
echo %announcement%
powershell (New-Object -ComObject Wscript.Shell).Popup("""%announcement%""",0,"""%version%""",0x10)
exit

:: BackUp/Restore Point
:RestorePoint
cls
if not exist %programdata%\ET-dump.log goto FirstTime
if exist %programdata%\ET-dump.log goto OnceAgain

:FirstTime
echo [ET] %time% - %date% > %programdata%\ET-dump.log
set announcement=Do you want to create a restore point?

powershell (New-Object -ComObject Wscript.Shell).Popup("""%announcement%""",0,"""%version%""",0x4 + 0x20) > status.log
set /P choice=<status.log
if exist status.log del status.log
if %choice%==6 goto YesRestore
if %choice%==7 goto NoRestore
goto FirstTime

:YesRestore
vssadmin delete shadows /All /Quiet
cls
powershell.exe -Command "Enable-ComputerRestore -Drive %systemdrive%"
powershell.exe -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description "ET-RestorePoint" -RestorePointType "MODIFY_SETTINGS""
cls
goto Start

:NoRestore
del %programdata%\ET-dump.log
goto Start

:OnceAgain
set announcement=Do you want to restore the previous settings?

powershell (New-Object -ComObject Wscript.Shell).Popup("""%announcement%""",0,"""%version%""",0x4 + 0x20) > status.log
set /P choice=<status.log
if exist status.log del status.log
if %choice%==6 goto BackUp
if %choice%==7 goto Start
goto OnceAgain

:BackUp
del %programdata%\ET-dump.log
cls
rstrui.exe
exit

:: DO NOT TOUCH THIS PART INSIDE (PLEASE)
:: #############################################################################################################################################


:: HERE YOU CAN DO ANYTHING YOU WANT:

:Start
cls

::  Show file extensions in Explorer
echo + [Setting] Show file extensions in Explorer
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t  REG_DWORD /d 0 /f >nul 2>nul

::  Disable Transparency in taskbar, menu start etc
echo # [Disable] Transparency in taskbar, menu start etc
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul 2>nul

::  Disable windows animations, menu Start animations.
echo # [Disable] Windows animations, menu Start animations.
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting  /t REG_DWORD /d 3 /f >nul 2>nul

REG ADD "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012078010000000 /f >nul 2>nul
REG ADD "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>nul

REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\AnimateMinMax" /v DefaultApplied  /t REG_DWORD /d 0 /f >nul 2>nul
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ComboBoxAnimation" /v DefaultApplied  /t REG_DWORD /d 0 /f >nul 2>nul
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ControlAnimations" /v DefaultApplied  /t REG_DWORD /d 0 /f >nul 2>nul
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\MenuAnimation" /v DefaultApplied  /t REG_DWORD /d 0 /f >nul 2>nul
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TaskbarAnimation" /v DefaultApplied  /t REG_DWORD /d 0 /f >nul 2>nul
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TooltipAnimation" /v DefaultApplied  /t REG_DWORD /d 0 /f >nul 2>nul

::  Disable Edge WebWidget 
echo # [Disable] Edge WebWidget 
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v WebWidgetAllowed /t REG_DWORD /d 0 /f >nul 2>nul

::  Setting power option to high for best performance
echo + [Setting] Power option to high for best performance
powercfg -setactive scheme_min

::  Enable All (Logical) Cores (Boot Advanced Options)
echo + [Setting] Enable All (Logical) Cores (Boot Advanced Options)
wmic cpu get NumberOfLogicalProcessors | findstr /r "[0-9]" > NumLogicalCores.txt
set /P NOLP=<NumLogicalCores.txt
bcdedit /set {current} numproc %NOLP% >nul 2>nul
if exist NumLogicalCores.txt del NumLogicalCores.txt

:: Disable Boot screen Animation
echo # [Disable] Boot screen Animation
bcdedit /set bootux disabled >nul 2>nul

:: Disable windows logo on startup
echo # [Disable] Windows logo on startup
bcdedit /set quietboot yes >nul 2>nul

:: Dual boot timeout 3sec
echo + [Setting] Dual boot timeout 3sec
bcdedit /set timeout 3 >nul 2>nul

:: Disable Hibernation/Fast startup in Windows to free RAM from "C:\hiberfil.sys"
echo # [Disable] Hibernation/Fast startup in Windows
powercfg -hibernate off

:: Disable windows insider experiments
echo # [Disable] Windows Insider experiments
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f >nul 2>nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t "REG_DWORD" /d "0" /f >nul 2>nul

:: Disable app launch tracking
echo # [Disable] App launch tracking
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /d "0" /t REG_DWORD /f >nul 2>nul

:: Disable windows media player usage reports
echo # [Disable] Windows media player usage reports
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d "0" /f >nul 2>nul

:: Disable mozilla telemetry
echo # [Disable] Mozilla telemetry
reg add HKLM\SOFTWARE\Policies\Mozilla\Firefox /v "DisableTelemetry" /t REG_DWORD /d "2" /f >nul 2>nul

:: Disable powerthrottling (Intel 6gen and higher)
echo # [Disable] Powerthrottling (Intel 6gen and higher)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f >nul 2>nul

:: Turn Off Background Apps
echo + [Setting] Turn Off Background Apps
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled  /t REG_DWORD /d 1 /f >nul 2>nul
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v BackgroundAppGlobalToggle /t REG_DWORD /d 0 /f >nul 2>nul

:: SCHEDULED TASKS tweaks (Updates, Telemetry etc)
echo # [Disable] SCHEDULED TASKS tweaks (Updates, Telemetry etc)
schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvent" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyUpload" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /Disable >nul 2>nul
schtasks /Change /TN "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" /Disable >nul 2>nul
schtasks /Change /TN "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable >nul 2>nul
schtasks /Change /TN "NIUpdateServiceStartupTask" /Disable >nul 2>nul
schtasks /Change /TN "NerveCenterUpdate" /Disable >nul 2>nul
schtasks /Change /TN "Adobe Acrobat Update Task" /Disable >nul 2>nul
schtasks /Change /TN "AMDLinkUpdate" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Office\Office Automatic Updates 2.0" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Office\Office Feature Updates" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Office\Office Feature Updates Logon" /Disable >nul 2>nul

:: Remove Telemetry & Data Collection 
echo # [Disable] Telemetry/Data Collection 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\SYSTEM\ControlSet001\Services\dmwappushservice" /v "Start" /t REG_DWORD /d 4 /f >nul 2>nul
reg add "HKLM\SYSTEM\ControlSet001\Services\DiagTrack" /v "Start" /t REG_DWORD /d 4 /f >nul 2>nul

:: Settings -> Privacy -> General -> Let apps use my advertising ID...
echo # [Disable] Let apps use my advertising ID
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>nul

::  SmartScreen Filter for Store Apps: Disable
echo # [Disable] SmartScreen Filter for Store Apps
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f >nul 2>nul

::  Let websites provide locally...
echo + [Setting] Let websites provide locally
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f >nul 2>nul

::  Send Microsoft info about how I write to help us improve typing and writing in the future
echo # [Disable] Send Microsoft info about how I write
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f >nul 2>nul

::  Handwriting recognition personalization
echo # [Disable] Handwriting recognition personalization
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f >nul 2>nul

::  Microsoft Edge settings
echo + [Setting] Microsoft Edge settings for privacy
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v DoNotTrack /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\User\Default\SearchScopes" /v ShowSearchSuggestionsGlobal /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\FlipAhead" /v FPEnabled /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f >nul 2>nul

::  Disable location sensor
echo # [Disable] Location sensor
reg add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v SensorPermissionState /t REG_DWORD /d 0 /f >nul 2>nul

:: WiFi Sense: HotSpot Sharing: Disable
echo # [Disable] WiFi Sense: HotSpot Sharing
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v value /t REG_DWORD /d 0 /f >nul 2>nul

:: WiFi Sense: Shared HotSpot Auto-Connect: Disable
echo # [Disable] WiFi Sense: Shared HotSpot Auto-Connect
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v value /t REG_DWORD /d 0 /f >nul 2>nul

:: Change Windows Updates to "Notify to schedule restart"
echo + [Setting] Windows Updates to "Notify to schedule restart"
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v UxOption /t REG_DWORD /d 1 /f >nul 2>nul

:: Disable P2P Update downlods outside of local network
echo # [Disable] P2P Update downlods outside of local network
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable News and Interests on Taskbar
echo # [Disable] News and Interests on Taskbar
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable MRU lists (jump lists) of XAML apps in Start Menu 
echo # [Disable] MRU lists (jump lists) of XAML apps in Start Menu 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f >nul 2>nul

:: Windows Explorer to start on This PC instead of Quick Access 
echo + [Setting] Windows Explorer to start on This PC instead of Quick Access 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul 2>nul

:: Setting Lower Shutdown time
echo + [Setting] Lower Shutdown time
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d 2000 /f >nul 2>nul

if %ThisOS%==81 goto Skip4Win8

:: Disable watson malware reports
echo # [Disable] Watson malware reports
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "DisableGenericReports" /t REG_DWORD /d "2" /f >nul 2>nul

:: Disable malware diagnostic data 
echo # [Disable] Malware diagnostic data 
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d "2" /f >nul 2>nul

:: Disable  setting override for reporting to Microsoft MAPS
echo # [Disable] Setting override for reporting to Microsoft MAPS
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "LocalSettingOverrideSpynetReporting" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable spynet Defender reporting
echo # [Disable] Spynet Defender reporting
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d 0 /f >nul 2>nul

:: Do not send malware samples for further analysis
echo + [Setting] Do not send malware samples for further analysis
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "2" /f >nul 2>nul

::  Hide the search box from taskbar. You can still search by pressing the Win key and start typing what you're looking for 
:: 0 = hide completely, 1 = show only icon, 2 = show long search box
echo + [Setting] Hide the search box from taskbar.
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f >nul 2>nul

::  Prevents sending speech, inking and typing samples to MS (so Cortana can learn to recognise you)
echo # [Disable] Sending speech, inking and typing samples to MS
reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f >nul 2>nul

::  Prevents sending contacts to MS (so Cortana can compare speech etc samples)
echo # [Disable] Sending contacts to MS
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v HarvestContacts /t REG_DWORD /d 0 /f >nul 2>nul

::  Immobilise Cortana 
echo # [Disable] Cortana 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable Get Even More Out of Windows Screen /W10
echo # [Disable] Get Even More Out of Windows Screen
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable automatically installing suggested apps /W10
echo # [Disable] Automatically installing suggested apps
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable Start Menu Ads/Suggestions /W10
echo # [Disable] Start Menu Ads/Suggestions
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable Allowing Suggested Apps In WindowsInk Workspace
echo # [Disable] Allowing Suggested Apps In WindowsInk Workspace
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WindowsInkWorkspace\AllowSuggestedAppsInWindowsInkWorkspace" /v "value" /t REG_DWORD /d 0 /f >nul 2>nul

:: Turning Off Windows Game Bar/DVR
echo # [Disable] Windows Game Bar/DVR
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul 2>nul

:: Removing Windows Game Bar 
echo - [Remove] Windows Game Bar 
PowerShell -Command "Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *XboxGameOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage"

::  Ads blocking via hosts file (AdAway)
echo + [Setting] Ad blocking via hosts file
PowerShell -Command "wget https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt -o hosts.txt" >nul 2>nul
if not exist C:\Windows\System32\Drivers\etc\hosts-copy-et copy C:\Windows\System32\Drivers\etc\hosts C:\Windows\System32\Drivers\etc\hosts-copy-et >nul 2>nul
copy hosts.txt C:\Windows\System32\Drivers\etc\hosts >nul 2>nul
if exist hosts.txt del hosts.txt

:Skip4Win8

:: Disable Sticky Keys prompt
echo # [Disable] Sticky Keys prompt
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d 506 /f >nul 2>nul

:: Disable Activity History
echo # [Disable] Activity History
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable Automatic Updates for Microsoft Store apps
echo # [Disable] Automatic Updates for Microsoft Store apps
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul 2>nul

:: Disable Some Service:

:: Disable
echo + [Setting] Services to: Disable Mode
set toDisable=DiagTrack diagnosticshub.standardcollector.service dmwappushservice RemoteRegistry RemoteAccess SCardSvr SCPolicySvc fax XblAuthManager XboxNetApiSvc XblGameSave WerSvc NvTelemetryContainer gadjservice AdobeARMservice PSI_SVC_2 lfsvc wlidsvc WalletService RetailDemo SEMgrSvc diagsvc AJRouter
(for %%a in (%toDisable%) do ( 
   sc stop %%a >nul 2>nul
   sc config %%a start= disabled  >nul 2>nul
))

:: Manuall
echo + [Setting] Services to: Manuall Mode
set toManuall=BITS SamSs TapiSrv seclogon wuauserv PhoneSvc lmhosts iphlpsvc gupdate gupdatem edgeupdate edgeupdatem MapsBroker PnkBstrA brave bravem asus asusm adobeupdateservice adobeflashplayerupdatesvc
(for %%a in (%toManuall%) do ( 
   sc config %%a start= demand >nul 2>nul
))

:: Remove Bloatware Apps (Preinstalled)
echo - [Remove] Bloatware Apps
set listofbloatware=3DBuilder Automate Appconnector Microsoft3DViewer MicrosoftPowerBIForWindows MicrosoftPowerBIForWindows Print3D XboxApp GetHelp WindowsFeedbackHub BingFoodAndDrink BingHealthAndFitness BingTravel WindowsReadingList MixedReality.Portal ScreenSketch YourPhone PicsArt-PhotoStudio EclipseManager Netflix PolarrPhotoEditorAcademicEdition Wunderlist LinkedInforWindows AutodeskSketchBook Twitter DisneyMagicKingdoms MarchofEmpires ActiproSoftwareLLC Plex iHeartRadio FarmVille2CountryEscape Duolingo CyberLinkMediaSuiteEssentials DolbyAccess DrawboardPDF Facebook FitbitCoach Flipboard Asphalt8Airborne Keeper BingNews COOKINGFEVER PandoraMediaInc CaesarsSlotsFreeCasino Shazam SpotifyMusic PhototasticCollage TuneInRadio WinZipUniversal XING RoyalRevolt2 CandyCrushSodaSaga BubbleWitch3Saga CandyCrushSaga Getstarted bing MicrosoftOfficeHub OneNote WindowsPhone SkypeApp windowscommunicationsapps WindowsMaps Sway CommsPhone ConnectivityStore Hotspot Sketchable Clipchamp Prime TikTok Instagram WhatsApp ToDo Teams
(for %%a in (%listofbloatware%) do ( 
   PowerShell -Command "Get-AppxPackage *%%a* | Remove-AppxPackage"
))

::  Disabling Process Mitigation
:: Audit exploit mitigations for increased process security or for converting existing Enhanced Mitigation Experience Toolkit
echo # [Disable] Process Mitigation
powershell set-ProcessMitigation -System -Disable  DEP, EmulateAtlThunks, SEHOP, ForceRelocateImages, RequireInfo, BottomUp, HighEntropy, StrictHandle, DisableWin32kSystemCalls, AuditSystemCall, DisableExtensionPoints, BlockDynamicCode, AllowThreadsToOptOut, AuditDynamicCode, CFG, SuppressExports, StrictCFG, MicrosoftSignedOnly, AllowStoreSignedBinaries, AuditMicrosoftSigned, AuditStoreSigned, EnforceModuleDependencySigning, DisableNonSystemFonts, AuditFont, BlockRemoteImageLoads, BlockLowLabelImageLoads, PreferSystem32, AuditRemoteImageLoads, AuditLowLabelImageLoads, AuditPreferSystem32, EnableExportAddressFilter, AuditEnableExportAddressFilter, EnableExportAddressFilterPlus, AuditEnableExportAddressFilterPlus, EnableImportAddressFilter, AuditEnableImportAddressFilter, EnableRopStackPivot, AuditEnableRopStackPivot, EnableRopCallerCheck, AuditEnableRopCallerCheck, EnableRopSimExec, AuditEnableRopSimExec, SEHOP, AuditSEHOP, SEHOPTelemetry, TerminateOnError, DisallowChildProcessCreation, AuditChildProcess >nul 2>nul

:: Disabling unnecessary applications at startup
echo # [Disable] Unnecessary applications at startup

:: Java Update Checker x64
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "SunJavaUpdateSched" /f >nul 2>nul

:: Mini Partition Tool Wizard Updater
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MTPW" /f >nul 2>nul

:: Teams Machine Installer
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "TeamsMachineInstaller" /f >nul 2>nul

:: Cisco Meeting Daemon
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "CiscoMeetingDaemon" /f >nul 2>nul

:: Adobe Reader Speed Launcher
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Adobe Reader Speed Launcher" /f >nul 2>nul

:: CCleaner Smart Cleaning/Monitor
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "CCleaner Smart Cleaning" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "CCleaner Monitor" /f >nul 2>nul

:: Spotify Web Helper
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Spotify Web Helper" /f >nul 2>nul

:: Gaijin.Net Updater
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Gaijin.Net Updater" /f >nul 2>nul

:: Microsoft Teams Update
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "com.squirrel.Teams.Teams" /f >nul 2>nul

:: Google Update
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Google Update" /f >nul 2>nul

:: Microsoft Edge Update
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Microsoft Edge Update" /f >nul 2>nul

:: BitTorrent Bleep
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "BitTorrent Bleep" /f >nul 2>nul

:: Skype
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Skype" /f >nul 2>nul

:: Adobe Update Startup Utility
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "adobeAAMUpdater-1.0" /f >nul 2>nul
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "AdobeAAMUpdater" /f >nul 2>nul

:: iTunes Helper
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "iTunesHelper" /f >nul 2>nul

:: CyberLink Update Utility
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "UpdatePPShortCut" /f >nul 2>nul

:: MSI Live Update
reg delete "HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Live Update" /f >nul 2>nul

:: Wondershare Helper Compact
reg delete "HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Wondershare Helper Compact" /f >nul 2>nul

:: Cisco AnyConnect Secure Mobility Agent
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Cisco AnyConnect Secure Mobility Agent for Windows" /f >nul 2>nul

:: Opera Browser Assistant (Update/Tray)
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Opera Browser Assistant" /f >nul 2>nul

:: Steam Autorun
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Steam" /f >nul 2>nul

:: Origin Autorun
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "EADM" /f >nul 2>nul

:: Epic Games Launcher Autorun
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "EpicGamesLauncher" /f >nul 2>nul

:: Gog Galaxy Autorun
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "GogGalaxy" /f >nul 2>nul

:: Skype for Desktop Autorun
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Skype for Desktop" /f >nul 2>nul

:: Wargaming.net Game Center
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Wargaming.net Game Center" /f >nul 2>nul

::  TEMP/Logs/Cache/Prefetch/Updates Cleaning
Del /S /F /Q %temp% >nul 2>nul
Del /S /F /Q %Windir%\Temp >nul 2>nul
Del /S /F /Q %windir%\SoftwareDistribution\Download >nul 2>nul
Del /S /F /Q %windir%\Prefetch >nul 2>nul

del %AppData%\Origin\Telemetry /F /Q /S >nul 2>nul
del %AppData%\Origin\Logs /F /Q /S >nul 2>nul
del %AppData%\Origin\NucleusCache /F /Q /S >nul 2>nul
del %AppData%\Origin\ConsolidatedCache /F /Q /S >nul 2>nul
del %AppData%\Origin\CatalogCache /F /Q /S >nul 2>nul
del %localAppData%\Origin\ThinSetup /F /Q /S >nul 2>nul
del %AppData%\Origin\Telemetry /F /Q /S >nul 2>nul
del %localAppData%\Origin\Logs /F /Q /S >nul 2>nul

del %localAppData%\Battle.net\Cache /F /Q /S >nul 2>nul
del %AppData%\Battle.net\Logs /F /Q /S >nul 2>nul
del %AppData%\Battle.net\Errors /F /Q /S >nul 2>nul

del %AppData%\vstelemetry >nul 2>nul
del %LocalAppData%\Microsoft\VSApplicationInsights /F /Q /S >nul 2>nul
del %ProgramData%\Microsoft\VSApplicationInsights  /F /Q /S >nul 2>nul
del %Temp%\Microsoft\VSApplicationInsights  /F /Q /S >nul 2>nul
del %Temp%\VSFaultInfo  /F /Q /S >nul 2>nul
del %Temp%\VSFeedbackPerfWatsonData  /F /Q /S >nul 2>nul
del %Temp%\VSFeedbackVSRTCLogs  /F /Q /S >nul 2>nul
del %Temp%\VSRemoteControl  /F /Q /S >nul 2>nul
del %Temp%\VSTelem /F /Q /S >nul 2>nul
del %Temp%\VSTelem.Out /F /Q /S >nul 2>nul

:: Cleaning Disk - cleanmgr
echo ~ [Run] CleanMgr - auto
start cleanmgr.exe /autoclean

if not exist "%programfiles%\CCleaner\CCleaner.exe" goto NoCC
if not exist "%programfiles%\CCleaner\CCleaner64.exe" goto NoCC
echo ~ [Run] CCleaner - auto
start CCleaner.exe /AUTO

:NoCC

:: Disables several unnecessary components
echo # [Disable] Several unnecessary components
set components=Printing-PrintToPDFServices-Features Printing-XPSServices-Features Xps-Foundation-Xps-Viewer WCF-Services45 MSRDC-Infrastructure
(for %%a in (%components%) do ( 
   PowerShell -Command " disable-windowsoptionalfeature -online -featureName %%a -NoRestart " >nul 2>nul
))

echo ------------------------------------------------
PowerShell -Command "[System.Console]::Beep(392,500); [System.Console]::Beep(440,500); [System.Console]::Beep(349.2,500); [System.Console]::Beep(174.6,700); [System.Console]::Beep(261.6,800)"

set announcement=Everything has been done. Reboot is recommended.
echo %announcement%
powershell (New-Object -ComObject Wscript.Shell).Popup("""%announcement%""",0,"""%version%""",0x40) >nul 2>nul

set announcement=Second run of the script will allow you to restore all settings.
echo %announcement%
powershell (New-Object -ComObject Wscript.Shell).Popup("""%announcement%""",0,"""%version%""",0x40) >nul 2>nul
exit
