@echo off

REM Check for admin permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM If error flag set, we do not have admin.
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
    
set version=E.T. ver 4.0
title %version%

NET SESSION >nul 2>&1
IF %ERRORLEVEL% == 0 goto CheckVer
echo. Run the script as an Administrator.
powershell (New-Object -ComObject Wscript.Shell).Popup("""Run the script as an Administrator.""",0,"""%version%""",0x10)
REM Checks if it is running as administrator if not quit
exit

:CheckVer
ver | findstr 10.0
if %errorlevel%==0 goto RestorePoint
ver | findstr 11.0
if %errorlevel%==0 goto RestorePoint
ver | findstr 6.3
if %errorlevel%==0 goto RestorePoint
echo Unsupported version of the system
mshta.exe vbscript:Execute("msgbox ""Unsupported version of the system"",16,""%version%"":close")
powershell (New-Object -ComObject Wscript.Shell).Popup("""Unsupported version of the system""",0,"""%version%""",0x10)

exit

:RestorePoint
cls
if not exist %programdata%\ET-dump.log goto FirstTime
if exist %programdata%\ET-dump.log goto OnceAgain

:FirstTime
echo [ET] %time% - %date% > %programdata%\ET-dump.log
powershell (New-Object -ComObject Wscript.Shell).Popup("""Do you want to create a restore point?""",0,"""%version%""",0x4 + 0x20) > status.log
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
powershell (New-Object -ComObject Wscript.Shell).Popup("""Do you want to restore the previous settings?""",0,"""%version%""",0x4 + 0x20) > status.log
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

:Start
cls

REM - Show file extensions in Explorer
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t  REG_DWORD /d 0 /f

REM - Disable Transparency in taskbar, menu start etc
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f

REM - Disable windows animations, menu Start animations.
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting  /t REG_DWORD /d 3 /f

REG ADD "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012078010000000 /f
REG ADD "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f

REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\AnimateMinMax" /v DefaultApplied  /t REG_DWORD /d 0 /f
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ComboBoxAnimation" /v DefaultApplied  /t REG_DWORD /d 0 /f
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ControlAnimations" /v DefaultApplied  /t REG_DWORD /d 0 /f
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\MenuAnimation" /v DefaultApplied  /t REG_DWORD /d 0 /f
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TaskbarAnimation" /v DefaultApplied  /t REG_DWORD /d 0 /f
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TooltipAnimation" /v DefaultApplied  /t REG_DWORD /d 0 /f

REM - Disable Edge WebWidget 
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v WebWidgetAllowed /t REG_DWORD /d 0 /f

REM - Setting power option to high for best performance
powercfg -setactive scheme_min

REM - Enable All (Logical) Cores (Boot Advanced Options)
wmic cpu get NumberOfLogicalProcessors | findstr /r "[0-9]" > NumLogicalCores.txt
set /P NOLP=<NumLogicalCores.txt
bcdedit /set {current} numproc %NOLP%
if exist NumLogicalCores.txt del NumLogicalCores.txt

REM - Disable Hibernation/Fast startup in Windows to free RAM from "C:\hiberfil.sys"
powercfg -hibernate off

REM - Turn Off Background Apps
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled  /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v BackgroundAppGlobalToggle /t REG_DWORD /d 0 /f

cls

REM SCHEDULED TASKS tweaks 
schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /Disable
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyUpload" /Disable
schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /Disable
schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /Disable
schtasks /Change /TN "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" /Disable
schtasks /Change /TN "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" /Disable
schtasks /Change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable
schtasks /Change /TN "NIUpdateServiceStartupTask" /Disable
schtasks /Change /TN "NerverCenterUpdate" /Disable
schtasks /Change /TN "Opera scheduled Autoupdate 1648482218" /Disable
schtasks /Change /TN "NerveCenterUpdate" /Disable

cls

REM Remove Telemetry & Data Collection 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f


REM Settings -> Privacy -> General -> Let apps use my advertising ID...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f

REM - SmartScreen Filter for Store Apps: Disable
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f

REM - Let websites provide locally...
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f

REM - Send Microsoft info about how I write to help us improve typing and writing in the future
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f

REM - Prevents sending speech, inking and typing samples to MS (so Cortana can learn to recognise you)
reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f

REM - Prevents sending contacts to MS (so Cortana can compare speech etc samples)
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v HarvestContacts /t REG_DWORD /d 0 /f

REM - Immobilise Cortana 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f

REM - Handwriting recognition personalization
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f

REM - Microsoft Edge settings
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v DoNotTrack /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\User\Default\SearchScopes" /v ShowSearchSuggestionsGlobal /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\FlipAhead" /v FPEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f

REM - Disable location sensor
reg add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v SensorPermissionState /t REG_DWORD /d 0 /f

cls

REM WiFi Sense: HotSpot Sharing: Disable
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v value /t REG_DWORD /d 0 /f

REM WiFi Sense: Shared HotSpot Auto-Connect: Disable
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v value /t REG_DWORD /d 0 /f

REM Change Windows Updates to "Notify to schedule restart"
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v UxOption /t REG_DWORD /d 1 /f

REM Disable P2P Update downlods outside of local network
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f

REM  Hide the search box from taskbar. You can still search by pressing the Win key and start typing what you're looking for 
REM 0 = hide completely, 1 = show only icon, 2 = show long search box
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f

REM Disable News and Interests on Taskbar
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f

REM Disable MRU lists (jump lists) of XAML apps in Start Menu 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f

REM Windows Explorer to start on This PC instead of Quick Access 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f

REM Disable Get Even More Out of Windows Screen /W10
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f

REM Disable automatically installing suggested apps /W10
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f

REM Disable Start Menu Ads/Suggestions /W10
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f

REM Disable Allowing Suggested Apps In WindowsInk Workspace
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WindowsInkWorkspace\AllowSuggestedAppsInWindowsInkWorkspace" /v "value" /t REG_DWORD /d 0 /f

REM Setting Lower Shutdown time
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d 2000 /f

REM Turning Off Windows Game Bar/DVR
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f

REM Removing Windows Game Bar 
PowerShell -Command "Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *XboxGameOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage"

REM Disable Sticky Keys prompt
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d 506 /f

REM Disable Activity History
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f

REM Disable Automatic Updates for Microsoft Store apps
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f

cls

setlocal enabledelayedexpansion

REM Disable Some Service:

REM Disable
set toDisable=DiagTrack diagnosticshub.standardcollector.service dmwappushservice RemoteRegistry RemoteAccess SCardSvr SCPolicySvc fax XblAuthManager XboxNetApiSvc XblGameSave WerSvc NvTelemetryContainer gadjservice AdobeARMservice PSI_SVC_2 lfsvc wlidsvc WalletService RetailDemo SEMgrSvc diagsvc AJRouter
set /a counter=1
(for %%a in (%toDisable%) do ( 
   sc config %%a start= disabled
   cls
   echo Setting Services to: Disable Mode [!counter!/23]
   set /a counter+=1
))

ping localhost -n 2 > nul

REM Manuall
set toManuall=BITS SamSs TapiSrv seclogon wuauserv PhoneSvc lmhosts iphlpsvc gupdate gupdatem edgeupdate edgeupdatem MapsBroker PnkBstrA brave bravem
set /a counter=1
(for %%a in (%toManuall%) do ( 
   sc config %%a start= demand
   cls
   echo Setting Services to: Manuall Mode [!counter!/16]

   set /a counter+=1
))

ping localhost -n 2 > nul

REM Remove Bloatware Apps (Preinstalled)
set listofbloatware=3DBuilder Automate Appconnector Microsoft3DViewer MicrosoftPowerBIForWindows MicrosoftPowerBIForWindows Print3D XboxApp GetHelp WindowsFeedbackHub BingFoodAndDrink BingHealthAndFitness BingTravel WindowsReadingList MixedReality.Portal ScreenSketch YourPhone PicsArt-PhotoStudio EclipseManager Netflix PolarrPhotoEditorAcademicEdition Wunderlist LinkedInforWindows AutodeskSketchBook Twitter DisneyMagicKingdoms MarchofEmpires ActiproSoftwareLLC Plex iHeartRadio FarmVille2CountryEscape Duolingo CyberLinkMediaSuiteEssentials DolbyAccess DrawboardPDF Facebook FitbitCoach Flipboard Asphalt8Airborne Keeper BingNews COOKINGFEVER PandoraMediaInc CaesarsSlotsFreeCasino Shazam SpotifyMusic PhototasticCollage TuneInRadio WinZipUniversal XING RoyalRevolt2 CandyCrushSodaSaga BubbleWitch3Saga CandyCrushSaga Getstarted bing MicrosoftOfficeHub OneNote WindowsPhone SkypeApp windowscommunicationsapps WindowsMaps Sway CommsPhone ConnectivityStore Hotspot Sketchable Clipchamp Prime TikTok Instagram WhatsApp ToDo
set /a counter=1
(for %%a in (%listofbloatware%) do ( 
	cls
   echo Scanning for Bloatware Apps [!counter!/73]
   PowerShell -Command "Get-AppxPackage *%%a* | Remove-AppxPackage"
   set /a counter+=1
))

REM Disables several unnecessary components
set components=Printing-PrintToPDFServices-Features Printing-XPSServices-Features Xps-Foundation-Xps-Viewer WCF-Services45 MSRDC-Infrastructure
set /a counter=1
(for %%a in (%components%) do ( 
	cls
   echo Disable unnecessary component [!counter!/5]
   PowerShell -Command " disable-windowsoptionalfeature -online -featureName %%a -NoRestart "
   set /a counter+=1
))

cls

REM - Uninstall OneDrive 
if exist %USERPROFILE%\OneDrive goto RemoveOneDrive
if exist "%PROGRAMDATA%\Microsoft OneDrive" goto RemoveOneDrive

goto Next

:RemoveOneDrive
taskkill.exe /F /IM "OneDrive.exe" > nul
echo Unistalling OneDrive
if exist %SYSTEMROOT%\SYSWOW64\ONEDRIVESETUP.EXE start /wait "" "%SYSTEMROOT%\SYSWOW64\ONEDRIVESETUP.EXE" /UNINSTALL
if exist %SYSTEMROOT%\System32\OneDriveSetup.exe start /wait "" "%SYSTEMROOT%\System32\OneDriveSetup.exe" /UNINSTALL
rd C:\OneDriveTemp /Q /S >NUL 2>&1
rd "%USERPROFILE%\OneDrive" /Q /S >NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S >NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S >NUL 2>&1
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f /v Attributes /t REG_DWORD /d 0 >NUL 2>&1
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f /v Attributes /t REG_DWORD /d 0 >NUL 2>&1

:Next

REM - Ads blocking via hosts file (AdAway)
echo Setting Ad blocking via hosts file
PowerShell -Command "wget https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt -o hosts.txt"
if not exist C:\Windows\System32\Drivers\etc\hosts-copy-et copy C:\Windows\System32\Drivers\etc\hosts C:\Windows\System32\Drivers\etc\hosts-copy-et
copy hosts.txt C:\Windows\System32\Drivers\etc\hosts
if exist hosts.txt del hosts.txt

cls

REM - Disabling Process Mitigation
REM Audit exploit mitigations for increased process security or for converting existing Enhanced Mitigation Experience Toolkit
echo Disabling Process Mitigation
powershell set-ProcessMitigation -System -Disable  DEP, EmulateAtlThunks, SEHOP, ForceRelocateImages, RequireInfo, BottomUp, HighEntropy, StrictHandle, DisableWin32kSystemCalls, AuditSystemCall, DisableExtensionPoints, BlockDynamicCode, AllowThreadsToOptOut, AuditDynamicCode, CFG, SuppressExports, StrictCFG, MicrosoftSignedOnly, AllowStoreSignedBinaries, AuditMicrosoftSigned, AuditStoreSigned, EnforceModuleDependencySigning, DisableNonSystemFonts, AuditFont, BlockRemoteImageLoads, BlockLowLabelImageLoads, PreferSystem32, AuditRemoteImageLoads, AuditLowLabelImageLoads, AuditPreferSystem32, EnableExportAddressFilter, AuditEnableExportAddressFilter, EnableExportAddressFilterPlus, AuditEnableExportAddressFilterPlus, EnableImportAddressFilter, AuditEnableImportAddressFilter, EnableRopStackPivot, AuditEnableRopStackPivot, EnableRopCallerCheck, AuditEnableRopCallerCheck, EnableRopSimExec, AuditEnableRopSimExec, SEHOP, AuditSEHOP, SEHOPTelemetry, TerminateOnError, DisallowChildProcessCreation, AuditChildProcess

cls

REM Disabling unnecessary applications at startup

REM Java Update Checker x64
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "SunJavaUpdateSched" /f

REM Mini Partition Tool Wizard Updater
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MTPW" /f

REM Teams Machine Installer
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "TeamsMachineInstaller" /f

REM Cisco Meeting Daemon
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "CiscoMeetingDaemon" /f

REM Adobe Reader Speed Launcher
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Adobe Reader Speed Launcher" /f

REM CCleaner Smart Cleaning/Monitor
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "CCleaner Smart Cleaning" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "CCleaner Monitor" /f

REM Spotify Web Helper
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Spotify Web Helper" /f

REM Gaijin.Net Updater
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Gaijin.Net Updater" /f

REM Microsoft Teams Update
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "com.squirrel.Teams.Teams" /f

REM Google Update
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Google Update" /f

REM Microsoft Edge Update
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Microsoft Edge Update" /f

REM BitTorrent Bleep
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "BitTorrent Bleep" /f

REM Skype
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Skype" /f

REM Adobe Update Startup Utility
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "adobeAAMUpdater-1.0" /f
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "AdobeAAMUpdater" /f

REM iTunes Helper
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "iTunesHelper" /f

REM CyberLink Update Utility
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "UpdatePPShortCut" /f

REM MSI Live Update
reg delete "HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Live Update" /f

REM Wondershare Helper Compact
reg delete "HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Wondershare Helper Compact" /f

REM Cisco AnyConnect Secure Mobility Agent
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Cisco AnyConnect Secure Mobility Agent for Windows" /f

cls

REM - TEMP/Prefetch Cleaning
echo Cleaning Temporary Files
Del /S /F /Q %temp%
Del /S /F /Q %Windir%\Temp

cls

echo Done.

powershell (New-Object -ComObject Wscript.Shell).Popup("""Everything has been done :) Reboot is recommended.""",0,"""%version%""",0x40)

exit
