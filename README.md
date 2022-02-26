@echo off
NET SESSION >nul 2>&1
IF %ERRORLEVEL% == 0 goto Start
echo. Run the program as an Administrator.
pause > nul
exit.

:Start
title E.T. ver 2.2
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

REM Disable News and Interests on Taskbar
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f

REM  Disable MRU lists (jump lists) of XAML apps in Start Menu 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f

REM Windows Explorer to start on This PC instead of Quick Access 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f

cls

REM Remove Bloatware Apps (Preinstalled)
echo Removing Bloatware Apps (Preinstalled)  [1/75]
PowerShell -Command "Get-AppxPackage *3DBuilder* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [2/75]

PowerShell -Command "Get-AppxPackage *Automate* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [3/75]

PowerShell -Command "Get-AppxPackage *Appconnector* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [4/75]

PowerShell -Command "Get-AppxPackage *Microsoft3DViewer* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [5/75]

PowerShell -Command "Get-AppxPackage *MicrosoftPowerBIForWindows* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [6/75]

PowerShell -Command "Get-AppxPackage *Print3D* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [7/75]

PowerShell -Command "Get-AppxPackage *XboxApp* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [8/75]

PowerShell -Command "Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [9/75]

PowerShell -Command "Get-AppxPackage *XboxGameOverlay* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [10/75]

PowerShell -Command "Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [11/75]

PowerShell -Command "Get-AppxPackage *GetHelp* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [12/75]

PowerShell -Command "Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [13/75]

PowerShell -Command "Get-AppxPackage *BingFoodAndDrink* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [14/75]

PowerShell -Command "Get-AppxPackage *BingHealthAndFitness* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [15/75]

PowerShell -Command "Get-AppxPackage *BingTravel* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [16/75]

PowerShell -Command "Get-AppxPackage *WindowsReadingList* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [17/75]

PowerShell -Command "Get-AppxPackage *MixedReality.Portal* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [18/75]

PowerShell -Command "Get-AppxPackage *ScreenSketch* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [19/75]

PowerShell -Command "Get-AppxPackage *YourPhone* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [20/75]

PowerShell -Command "Get-AppxPackage *PicsArt-PhotoStudio* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [21/75]

PowerShell -Command "Get-AppxPackage *EclipseManager* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [22/75]

PowerShell -Command "Get-AppxPackage *Netflix* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [23/75]

PowerShell -Command "Get-AppxPackage *PolarrPhotoEditorAcademicEdition* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [24/75]

PowerShell -Command "Get-AppxPackage *Wunderlist* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [25/75]

PowerShell -Command "Get-AppxPackage *LinkedInforWindows* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [26/75]

PowerShell -Command "Get-AppxPackage *AutodeskSketchBook* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [27/75]

PowerShell -Command "Get-AppxPackage *Twitter* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [28/75]

PowerShell -Command "Get-AppxPackage *DisneyMagicKingdoms* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [29/75]

PowerShell -Command "Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [30/75]

PowerShell -Command "Get-AppxPackage *ActiproSoftwareLLC* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [31/75]

PowerShell -Command "Get-AppxPackage *Plex* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [32/75]

PowerShell -Command "Get-AppxPackage *iHeartRadio* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [33/75]

PowerShell -Command "Get-AppxPackage *FarmVille2CountryEscape* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [34/75]

PowerShell -Command "Get-AppxPackage *Duolingo* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [35/75]

PowerShell -Command "Get-AppxPackage *CyberLinkMediaSuiteEssentials* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [36/75]

PowerShell -Command "Get-AppxPackage *DolbyAccess* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [37/75]

PowerShell -Command "Get-AppxPackage *DrawboardPDF* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [38/75]

PowerShell -Command "Get-AppxPackage *Facebook* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [39/75]

PowerShell -Command "Get-AppxPackage *FitbitCoach* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [40/75]

PowerShell -Command "Get-AppxPackage *Flipboard* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [41/75]

PowerShell -Command "Get-AppxPackage *Asphalt8Airborne* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [42/75]

PowerShell -Command "Get-AppxPackage *Keeper* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [43/75]

PowerShell -Command "Get-AppxPackage *BingNews* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [44/75]

PowerShell -Command "Get-AppxPackage *COOKINGFEVER* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [45/75]

PowerShell -Command "Get-AppxPackage *PandoraMediaInc* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [46/75]

PowerShell -Command "Get-AppxPackage *CaesarsSlotsFreeCasino* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [47/75]

PowerShell -Command "Get-AppxPackage *Shazam* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [48/75]

PowerShell -Command "Get-AppxPackage *SpotifyMusic* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [49/75]

PowerShell -Command "Get-AppxPackage *PhototasticCollage* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [50/75]

PowerShell -Command "Get-AppxPackage *TuneInRadio* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [51/75]

PowerShell -Command "Get-AppxPackage *WinZipUniversal* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [52/75]

PowerShell -Command "Get-AppxPackage *XING* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [53/75]

PowerShell -Command "Get-AppxPackage *RoyalRevolt2* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [54/75]

PowerShell -Command "Get-AppxPackage *CandyCrushSodaSaga* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [55/75]

PowerShell -Command "Get-AppxPackage *BubbleWitch3Saga* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [56/75]

PowerShell -Command "Get-AppxPackage *CandyCrushSaga* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [57/75]

PowerShell -Command "Get-AppxPackage *Getstarted* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [58/75]

PowerShell -Command "Get-AppxPackage *WindowsAlarms* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [59/75]

PowerShell -Command "Get-AppxPackage *bing* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [60/75]

PowerShell -Command "Get-AppxPackage *MicrosoftOfficeHub* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [61/75]

PowerShell -Command "Get-AppxPackage *OneNote* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [62/75]

PowerShell -Command "Get-AppxPackage *WindowsPhone* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [63/75]

PowerShell -Command "Get-AppxPackage *SkypeApp* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [64/75]

PowerShell -Command "Get-AppxPackage *solit* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [65/75]

PowerShell -Command "Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [66/75]

PowerShell -Command "Get-AppxPackage *zune* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [67/75]

PowerShell -Command "Get-AppxPackage *WindowsMaps* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [68/75]

PowerShell -Command "Get-AppxPackage *Sway* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [69/75]

PowerShell -Command "Get-AppxPackage *CommsPhone* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [70/75]

PowerShell -Command "Get-AppxPackage *ConnectivityStore* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [71/75]

PowerShell -Command "Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [72/75]

PowerShell -Command "Get-AppxPackage *Facebook* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [73/75]

PowerShell -Command "Get-AppxPackage *Twitter* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [74/75]

PowerShell -Command "Get-AppxPackage *Drawboard PDF* | Remove-AppxPackage"
 echo Removing Bloatware Apps (Preinstalled)  [75/75]

PowerShell -Command "Get-AppxPackage *Hotspot* | Remove-AppxPackage"

cls

REM - Show file extensions in Explorer
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t  REG_DWORD /d 0 /f

REM - Disable Transparency in taskbar, menu start etc
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WIndows\CurrentVersion\Explorer\Advanced" /v UseOLEDTaskbarTransparency /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm" /v ForceEffectMode /t REG_DWORD /d 2 /f


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

REM - Uninstall OneDrive 
echo Unistalling OneDrive
start /wait "" "%SYSTEMROOT%\SYSWOW64\ONEDRIVESETUP.EXE" /UNINSTALL
rd C:\OneDriveTemp /Q /S >NUL 2>&1
rd "%USERPROFILE%\OneDrive" /Q /S >NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S >NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S >NUL 2>&1
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f /v Attributes /t REG_DWORD /d 0 >NUL 2>&1
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f /v Attributes /t REG_DWORD /d 0 >NUL 2>&1

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
