@echo off
NET SESSION >nul 2>&1
IF %ERRORLEVEL% == 0 goto Start
echo. Run the program as an Administrator.
pause > nul
exit.

:Start

REM Disable Some Service 

sc config DiagTrack start= disabled
sc config diagnosticshub.standardcollector.service start= disabled
sc config dmwappushservice start= disabled
sc config RemoteRegistry start= disabled
sc config SamSs start= demand
sc config SCardSvr start= disabled
sc config XboxNetApiSvc start= demand
sc config TapiSrv start= demand
sc config seclogon start= demand
sc config SCPolicySvc start= demand
sc config RemoteAccess start= disabled
sc config fax start= disabled
sc config XblGameSave start= demand
sc config wuauserv start= demand
sc config PhoneSvc start= demand
sc config lmhosts start= demand
sc config gupdate start= demand
sc config WerSvc start= disabled

REM  SCHEDULED TASKS tweaks 
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
schtasks /Change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable

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

cls

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

REM  Disable MRU lists (jump lists) of XAML apps in Start Menu 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f

REM Windows Explorer to start on This PC instead of Quick Access 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f

cls

REM Remove Bloatware Apps (Preinstalled)
echo Removing Bloatware Apps (Preinstalled)
PowerShell -Command "Get-AppxPackage *3DBuilder* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Appconnector* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft3DViewer* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *MicrosoftPowerBIForWindows* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Print3D* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *XboxApp* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *XboxGameOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *GetHelp* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *BingFoodAndDrink* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *BingHealthAndFitness* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *BingTravel* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *WindowsReadingList* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *MixedReality.Portal* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *ScreenSketch* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *YourPhone* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *PicsArt-PhotoStudio* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *EclipseManager* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Netflix* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *PolarrPhotoEditorAcademicEdition* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Wunderlist* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *LinkedInforWindows* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *AutodeskSketchBook* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Twitter* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *DisneyMagicKingdoms* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *ActiproSoftwareLLC* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Plex* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *iHeartRadio* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *FarmVille2CountryEscape* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Duolingo* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *CyberLinkMediaSuiteEssentials* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *DolbyAccess* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *DrawboardPDF* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Facebook* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *FitbitCoach* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Flipboard* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Asphalt8Airborne* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Keeper* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *BingNews* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *COOKINGFEVER* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *PandoraMediaInc* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *CaesarsSlotsFreeCasino* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Shazam* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *SpotifyMusic* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *PhototasticCollage* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *TuneInRadio* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *WinZipUniversal* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *XING* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *RoyalRevolt2* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *CandyCrushSodaSaga* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *BubbleWitch3Saga* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *CandyCrushSaga* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Getstarted* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *WindowsAlarms* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *bing* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *MicrosoftOfficeHub* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *OneNote* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *WindowsPhone* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *photos* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *SkypeApp* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *solit* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *zune* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *WindowsMaps* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Sway* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *CommsPhone* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *ConnectivityStore* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Facebook* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Twitter* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Drawboard PDF* | Remove-AppxPackage"

cls

REM - Show file extensions in Explorer
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t  REG_DWORD /d 0 /f

REM - Disable Transparency in taskbar, menu start etc (Build1006+ not sure work need reboot)
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f

REM - Disable windows, menu Start animations.
REG ADD "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012078010000000 /f
REG ADD "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f

REM - Disable Action Center (taskbar notification center)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Current\Version\ImmersiveShell" /v UseActionCenterExperience /t REG_DWORD /d 0 /f

REM - Uninstall OneDrive 
echo Unistalling OneDrive
start /wait "" "%SYSTEMROOT%\SYSWOW64\ONEDRIVESETUP.EXE" /UNINSTALL
rd C:\OneDriveTemp /Q /S >NUL 2>&1
rd "%USERPROFILE%\OneDrive" /Q /S >NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S >NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S >NUL 2>&1
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f /v Attributes /t REG_DWORD /d 0 >NUL 2>&1
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f /v Attributes /t REG_DWORD /d 0 >NUL 2>&1
TASKKILL /F /IM explorer.exe
ping localhost -n 1 > nul
start explorer.exe

REM - Setting power option to high for best performance
powercfg -setactive scheme_min
EXIT

REM - Optimizing Windows by forcing L2 and L3 CPU cache usage. EXPERT MODE
EXIT.

wmic cpu get L2CacheSize | findstr /r "[0-9][0-9]" > L2CacheSize.txt
if %errorlevel%==1 exit.
set /P L2CS=<L2CacheSize.txt
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v SecondLevelDataCache /t REG_DWORD /f /d %L2CS%
:L3CS
wmic cpu get L3CacheSize | findstr /r "[0-9][0-9]" > L3CacheSize.txt
if %errorlevel%==1 exit.
set /P L3CS=<L3CacheSize.txt
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ThirdLevelDataCache /t REG_DWORD /f /d %L3CS%
