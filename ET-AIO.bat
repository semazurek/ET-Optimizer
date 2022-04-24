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
set version=E.T. ver 4.5
title %version%

set /a counter=1
set /a alltodo=0
:: alltodo all 64

NET SESSION >nul 2>&1
IF %ERRORLEVEL% == 0 goto GUIChoice

set announcement=Run the script as an Administrator.
echo %announcement%
powershell (New-Object -ComObject Wscript.Shell).Popup("""%announcement%""",0,"""%version%""",0x10 + 4096)
:: Checks if it is running as administrator if not quit
exit

:: GUI Windows Form
:GUIChoice
:: Cleaning help files
del %programdata%\*.lbool >nul 2>nul

Powershell -Command "[reflection.assembly]::LoadWithPartialName( 'System.Windows.Forms'); [reflection.assembly]::loadwithpartialname('System.Drawing'); function do_start { If ($chck1.Checked -eq 1) {echo True > %programdata%\etvisualtweaks.lbool}; If ($chck2.Checked -eq 1) {echo True > %programdata%\etperformancetweaks.lbool}; If ($chck3.Checked -eq 1) {echo True > %programdata%\ettelemetry.lbool}; If ($chck4.Checked -eq 1) {echo True > %programdata%\etwindowsgamebar.lbool}; If ($chck5.Checked -eq 1) {echo True > %programdata%\etservices.lbool}; If ($chck6.Checked -eq 1) {echo True > %programdata%\etbloatware.lbool}; If ($chck7.Checked -eq 1) {echo True > %programdata%\etstartup.lbool}; If ($chck8.Checked -eq 1) {echo True > %programdata%\etcleaning.lbool}; If ($chck9.Checked -eq 1) {echo True > %programdata%\etadblock.lbool}; If ($chck10.Checked -eq 1) {echo True > %programdata%\etonedrive.lbool}; $form.close()}; $form= New-Object Windows.Forms.Form; $form.Size = New-Object System.Drawing.Size(350,395); $form.StartPosition = 'CenterScreen'; $form.FormBorderStyle = 'FixedDialog'; $form.Text = '%version%'; $form.AutoSizeMode = 'GrowAndShrink'; $form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen; $form.MinimizeBox = $false; $form.MaximizeBox = $false; $Font = New-Object System.Drawing.Font('Arial',11,[System.Drawing.FontStyle]::Regular); $form.Font = $font; $B_close = New-Object Windows.Forms.Button; $B_close.text = 'Start'; $B_close.Location = New-Object Drawing.Point 130,315; $B_close.add_click({do_start}); $form.controls.add($B_close); $label2 = New-Object Windows.Forms.Label; $label2.Location = New-Object Drawing.Point 10,32; $label2.Size = New-Object Drawing.Point 320,25; $label2.text = 'Select improvements to execute:'; $label2.Font = New-Object System.Drawing.Font('Arial',11,[System.Drawing.FontStyle]::Bold); $form.controls.add($label2); $chck1 = New-Object Windows.Forms.Checkbox; $chck1.Location = New-Object Drawing.Point 20,55; $chck1.Size = New-Object Drawing.Point 320,25; $chck1.Text = 'Enable Visual Tweaks'; $chck1.TabIndex = 0; $chck1.Checked = $true; $form.controls.add($chck1); $chck2 = New-Object Windows.Forms.Checkbox; $chck2.Location = New-Object Drawing.Point 20,80; $chck2.Size = New-Object Drawing.Point 320,25; $chck2.Text = 'Enable Performance Tweaks'; $chck2.TabIndex = 1; $chck2.Checked = $true; $form.controls.add($chck2); $chck3 = New-Object Windows.Forms.Checkbox; $chck3.Location = New-Object Drawing.Point 20,105; $chck3.Size = New-Object Drawing.Point 320,25; $chck3.Text = 'Disable Data Collection/Telemetry'; $chck3.TabIndex = 2; $chck3.Checked = $true; $form.controls.add($chck3); $chck4 = New-Object Windows.Forms.Checkbox; $chck4.Location = New-Object Drawing.Point 20,130; $chck4.Size = New-Object Drawing.Point 320,25; $chck4.Text = 'Remove Windows Game Bar/DVR'; $chck4.TabIndex = 3; $chck4.Checked = $true; $form.controls.add($chck4); $chck5 = New-Object Windows.Forms.Checkbox; $chck5.Location = New-Object Drawing.Point 20,155; $chck5.Size = New-Object Drawing.Point 320,25; $chck5.Text = 'Enable Services Tweaks'; $chck5.TabIndex = 4; $chck5.Checked = $true; $form.controls.add($chck5); $chck6 = New-Object Windows.Forms.Checkbox; $chck6.Location = New-Object Drawing.Point 20,180; $chck6.Size = New-Object Drawing.Point 320,25; $chck6.Text = 'Remove Bloatware (Preinstalled)'; $chck6.TabIndex = 5; $chck6.Checked = $true; $form.controls.add($chck6); $chck7 = New-Object Windows.Forms.Checkbox; $chck7.Location = New-Object Drawing.Point 20,205; $chck7.Size = New-Object Drawing.Point 320,25; $chck7.Text = 'Disable Unnecessary Startup Apps'; $chck7.TabIndex = 6; $chck7.Checked = $true; $form.controls.add($chck7); $chck8 = New-Object Windows.Forms.Checkbox; $chck8.Location = New-Object Drawing.Point 20,230; $chck8.Size = New-Object Drawing.Point 320,25; $chck8.Text = 'Clean Temp/Cache/Prefetch/Updates'; $chck8.TabIndex = 7; $chck8.Checked = $true; $form.controls.add($chck8); $chck9 = New-Object Windows.Forms.Checkbox; $chck9.Location = New-Object Drawing.Point 20,255; $chck9.Size = New-Object Drawing.Point 320,25; $chck9.Text = 'Enable Lite-Adblock (AdAway)'; $chck9.TabIndex = 8; $chck9.Checked = $false; $form.controls.add($chck9); $chck10 = New-Object Windows.Forms.Checkbox; $chck10.Location = New-Object Drawing.Point 20,280; $chck10.Size = New-Object Drawing.Point 320,25; $chck10.Text = 'Remove Microsoft OneDrive'; $chck10.TabIndex = 9; $chck10.Checked = $false; $form.controls.add($chck10); function About {$aboutForm = New-Object System.Windows.Forms.Form; $aboutFormExit = New-Object System.Windows.Forms.Button; $aboutFormImage = New-Object System.Windows.Forms.PictureBox; $aboutFormNameLabel = New-Object System.Windows.Forms.Label; $aboutFormText = New-Object System.Windows.Forms.Label; $aboutFormText2 = New-Object System.Windows.Forms.Label; $aboutForm.MinimizeBox = $false; $aboutForm.MaximizeBox = $false; $aboutForm.TopMost = $true; $aboutForm.AutoSizeMode = 'GrowAndShrink'; $aboutForm.FormBorderStyle = 'FixedDialog'; $aboutForm.AcceptButton = $aboutFormExit; $aboutForm.CancelButton = $aboutFormExit; $aboutForm.ClientSize = '350, 110'; $aboutForm.ControlBox = $false; $aboutForm.ShowInTaskBar = $false; $aboutForm.StartPosition = 'CenterParent'; $aboutForm.Text = 'About'; $aboutForm.Add_Load($aboutForm_Load); $aboutFormNameLabel.Font = New-Object Drawing.Font('Arial', 9, [System.Drawing.FontStyle]::Bold); $aboutFormNameLabel.Location = '110, 10'; $aboutFormNameLabel.Size = '200, 18'; $aboutFormNameLabel.Text = '       E.T. All in One'; $aboutForm.Controls.Add($aboutFormNameLabel); $aboutFormText.Location = '100, 30'; $aboutFormText.Size = '300, 20'; $aboutFormText.Text = '         Sebastian Mazurek'; $aboutForm.Controls.Add($aboutFormText); $aboutFormText2.Location = '100, 50'; $aboutFormText2.Size = '300, 20'; $aboutFormText2.Text = '      GitHub.com/semazurek'; $aboutForm.Controls.Add($aboutFormText2); $aboutFormExit.Location = '135, 75'; $aboutFormExit.Text = 'OK'; $aboutForm.Controls.Add($aboutFormExit); [void]$aboutForm.ShowDialog()}; function addMenuItem { param([ref]$ParentItem, [string]$ItemName='', [string]$ItemText='', [scriptblock]$ScriptBlock=$null ) [System.Windows.Forms.ToolStripMenuItem]$private:menuItem=` New-Object System.Windows.Forms.ToolStripMenuItem; $private:menuItem.Name =$ItemName; $private:menuItem.Text =$ItemText; if ($ScriptBlock -ne $null) { $private:menuItem.add_Click(([System.EventHandler]$handler=` $ScriptBlock));}; if (($ParentItem.Value) -is [System.Windows.Forms.MenuStrip]) { ($ParentItem.Value).Items.Add($private:menuItem);} return $private:menuItem; }; function Backup{vssadmin delete shadows /All /Quiet; powershell.exe -Command 'Enable-ComputerRestore -Drive %systemdrive%'; powershell.exe -ExecutionPolicy Bypass -Command 'Checkpoint-Computer -Description 'ET-RestorePoint' -RestorePointType 'MODIFY_SETTINGS''; powershell (New-Object -ComObject Wscript.Shell).Popup('''Backup has been created.''',0,'''%version%''',0x40 + 4096); echo [ET] %time% - %date% > %programdata%\ET-dump.log}; [System.Windows.Forms.MenuStrip]$mainMenu=New-Object System.Windows.Forms.MenuStrip; $form.Controls.Add($mainMenu); [scriptblock]$exit= {$form.Close()}; [scriptblock]$backup= {Backup}; [scriptblock]$restore= {rstrui.exe}; [scriptblock]$about= {About}; (addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Backup' -ScriptBlock $backup); (addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Restore' -ScriptBlock $restore); (addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'About' -ScriptBlock $about); (addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Exit' -ScriptBlock $exit); $form.ShowDialog();">nul 2>nul

if not exist %programdata%\*.lbool exit.
:: if not chosen any option = no .lbool files in programdata = exit

if exist %programdata%\etadblock.lbool set /a alltodo+=1
if exist %programdata%\etcleaning.lbool set /a alltodo+=3
if exist %programdata%\etstartup.lbool set /a alltodo+=1
if exist %programdata%\etbloatware.lbool set /a alltodo+=1
if exist %programdata%\etservices.lbool set /a alltodo+=2
if exist %programdata%\etwindowsgamebar.lbool set /a alltodo+=2
if exist %programdata%\ettelemetry.lbool set /a alltodo+=17
if exist %programdata%\etperformancetweaks.lbool set /a alltodo+=29
if exist %programdata%\etvisualtweaks.lbool set /a alltodo+=7
if exist %programdata%\etonedrive.lbool set /a alltodo+=1

:: BackUp/Restore Point First Time Run Asking
:RestorePoint
cls
if not exist %programdata%\ET-dump.log goto FirstTime
if exist %programdata%\ET-dump.log goto Start

:FirstTime
set announcement=Do you want to create a restore point?

powershell (New-Object -ComObject Wscript.Shell).Popup("""%announcement%""",0,"""%version%""",0x4 + 0x20 + 4096) > %temp%\status.log
set /P choice=<%temp%\status.log
if exist %temp%\status.log del %temp%\status.log
if %choice%==6 goto YesCreateRestore
if %choice%==7 goto Start
goto FirstTime

:YesCreateRestore
vssadmin delete shadows /All /Quiet
cls
powershell.exe -Command "Enable-ComputerRestore -Drive %systemdrive%"
powershell.exe -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description "ET-RestorePoint" -RestorePointType "MODIFY_SETTINGS""
cls
goto Start

:: DO NOT TOUCH THIS PART INSIDE (PLEASE)
:: #############################################################################################################################################

:: HERE YOU CAN DO ANYTHING YOU WANT:

:Start
cls

if not exist %programdata%\etvisualtweaks.lbool goto SkipVisualTweaks

:VisualTweaks

:: Show file extensions in Explorer
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo + [Setting] Show file extensions in Explorer
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t  REG_DWORD /d 0 /f >nul 2>nul

::  Disable Transparency in taskbar, menu start etc
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo + [Setting] Disable Transparency in taskbar/menu start
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f >nul 2>nul

::  Disable windows animations, menu Start animations.
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
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

:: Disable News and Interests on Taskbar
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] News and Interests on Taskbar
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable MRU lists (jump lists) of XAML apps in Start Menu
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul 
echo # [Disable] MRU lists (jump lists) of XAML apps in Start Menu 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f >nul 2>nul

::  Hide the search box from taskbar. You can still search by pressing the Win key and start typing what you're looking for 
:: 0 = hide completely, 1 = show only icon, 2 = show long search box
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo + [Setting] Hide the search box from taskbar.
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f >nul 2>nul

:: Windows Explorer to start on This PC instead of Quick Access 
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo + [Setting] Windows Explorer to start on This PC instead of Quick Access 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul 2>nul

del %programdata%\etvisualtweaks.lbool >nul 2>nul

:SkipVisualTweaks

if not exist %programdata%\etperformancetweaks.lbool goto SkipPerformanceTweaks

:PerformanceTweaks

::  Disable Edge WebWidget
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Edge WebWidget 
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v WebWidgetAllowed /t REG_DWORD /d 0 /f >nul 2>nul

::  Setting power option to high for best performance
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo + [Setting] Power option to high for best performance
powercfg -setactive scheme_min

::  Enable All (Logical) Cores (Boot Advanced Options)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo + [Setting] Enable All (Logical) Cores (Boot Advanced Options)
wmic cpu get NumberOfLogicalProcessors | findstr /r "[0-9]" > NumLogicalCores.txt
set /P NOLP=<NumLogicalCores.txt
bcdedit /set {current} numproc %NOLP% >nul 2>nul
if exist NumLogicalCores.txt del NumLogicalCores.txt

:: Dual boot timeout 3sec
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo + [Setting] Dual boot timeout 3sec
bcdedit /set timeout 3 >nul 2>nul

:: Disable Hibernation/Fast startup in Windows to free RAM from "C:\hiberfil.sys"
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Hibernation/Fast startup in Windows
powercfg -hibernate off

:: Disable windows insider experiments
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Windows Insider experiments
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f >nul 2>nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t "REG_DWORD" /d "0" /f >nul 2>nul

:: Disable app launch tracking
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] App launch tracking
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /d "0" /t REG_DWORD /f >nul 2>nul

:: Disable powerthrottling (Intel 6gen and higher)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Powerthrottling (Intel 6gen and higher)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f >nul 2>nul

:: Turn Off Background Apps
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo + [Setting] Turn Off Background Apps
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled  /t REG_DWORD /d 1 /f >nul 2>nul
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v BackgroundAppGlobalToggle /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable Sticky Keys prompt
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Sticky Keys prompt
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d 506 /f >nul 2>nul

:: Disable Activity History
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Activity History
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable Automatic Updates for Microsoft Store apps
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Automatic Updates for Microsoft Store apps
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul 2>nul

::  SmartScreen Filter for Store Apps: Disable
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] SmartScreen Filter for Store Apps
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f >nul 2>nul

::  Let websites provide locally...
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo + [Setting] Let websites provide locally
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f >nul 2>nul

::  Microsoft Edge settings
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo + [Setting] Microsoft Edge settings for privacy
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v DoNotTrack /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\User\Default\SearchScopes" /v ShowSearchSuggestionsGlobal /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\FlipAhead" /v FPEnabled /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f >nul 2>nul

::  Disable location sensor
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Location sensor
reg add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v SensorPermissionState /t REG_DWORD /d 0 /f >nul 2>nul

:: WiFi Sense: HotSpot Sharing: Disable
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] WiFi Sense: HotSpot Sharing
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v value /t REG_DWORD /d 0 /f >nul 2>nul

:: WiFi Sense: Shared HotSpot Auto-Connect: Disable
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] WiFi Sense: Shared HotSpot Auto-Connect
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v value /t REG_DWORD /d 0 /f >nul 2>nul

:: Change Windows Updates to "Notify to schedule restart"
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo + [Setting] Windows Updates to "Notify to schedule restart"
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v UxOption /t REG_DWORD /d 1 /f >nul 2>nul

:: Disable P2P Update downloads outside of local network
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] P2P Update downlods outside of local network
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f >nul 2>nul

:: Setting Lower Shutdown time
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo + [Setting] Lower Shutdown time
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d 2000 /f >nul 2>nul

:: Remove Old Device Drivers
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo - [Remove] Old Device Drivers
SET DEVMGR_SHOW_NONPRESENT_DEVICES=1

:: Disable Get Even More Out of Windows Screen /W10
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Get Even More Out of Windows Screen
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable automatically installing suggested apps /W10
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Automatically installing suggested apps
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable Start Menu Ads/Suggestions /W10
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Start Menu Ads/Suggestions
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable Allowing Suggested Apps In WindowsInk Workspace
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Allowing Suggested Apps In WindowsInk Workspace
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WindowsInkWorkspace\AllowSuggestedAppsInWindowsInkWorkspace" /v "value" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disables several unnecessary components
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Unnecessary components
set components=Printing-PrintToPDFServices-Features Printing-XPSServices-Features Xps-Foundation-Xps-Viewer
(for %%a in (%components%) do ( 
   PowerShell -Command " disable-windowsoptionalfeature -online -featureName %%a -NoRestart " >nul 2>nul
))

::  Disabling Process Mitigation
:: Audit exploit mitigations for increased process security or for converting existing Enhanced Mitigation Experience Toolkit
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Process Mitigation
powershell set-ProcessMitigation -System -Disable  DEP, EmulateAtlThunks, SEHOP, ForceRelocateImages, RequireInfo, BottomUp, HighEntropy, StrictHandle, DisableWin32kSystemCalls, AuditSystemCall, DisableExtensionPoints, BlockDynamicCode, AllowThreadsToOptOut, AuditDynamicCode, CFG, SuppressExports, StrictCFG, MicrosoftSignedOnly, AllowStoreSignedBinaries, AuditMicrosoftSigned, AuditStoreSigned, EnforceModuleDependencySigning, DisableNonSystemFonts, AuditFont, BlockRemoteImageLoads, BlockLowLabelImageLoads, PreferSystem32, AuditRemoteImageLoads, AuditLowLabelImageLoads, AuditPreferSystem32, EnableExportAddressFilter, AuditEnableExportAddressFilter, EnableExportAddressFilterPlus, AuditEnableExportAddressFilterPlus, EnableImportAddressFilter, AuditEnableImportAddressFilter, EnableRopStackPivot, AuditEnableRopStackPivot, EnableRopCallerCheck, AuditEnableRopCallerCheck, EnableRopSimExec, AuditEnableRopSimExec, SEHOP, AuditSEHOP, SEHOPTelemetry, TerminateOnError, DisallowChildProcessCreation, AuditChildProcess >nul 2>nul

:: Defragmenting the File Indexing Service database file
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo + [Setting] Defragment Database Indexing Service File 
net stop wsearch >nul 2>nul
esentutl /d C:\ProgramData\Microsoft\Search\Data\Applications\Windows\Windows.edb >nul 2>nul
net start wsearch >nul 2>nul

del %programdata%\etperformancetweaks.lbool >nul 2>nul

:SkipPerformanceTweaks

if not exist %programdata%\ettelemetry.lbool goto SkipTelemetry

:Telemetry

:: SCHEDULED TASKS tweaks (Updates, Telemetry etc)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
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
schtasks /Change /TN "GoogleUpdateTaskMachineCore" /Disable >nul 2>nul
schtasks /Change /TN "GoogleUpdateTaskMachineUA" /Disable >nul 2>nul

:: Remove Telemetry & Data Collection 
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
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

:: Disable PowerShell Telemetry
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] PowerShell Telemetry
setx POWERSHELL_TELEMETRY_OPTOUT 1 >nul 2>nul

:: Disable Skype Telemetry
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Skype Telemetry
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW" /v "TraceLevelThreshold" /t REG_DWORD /d "0" /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype" /v "EnableTracing" /t REG_DWORD /d "0" /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW" /v "EnableTracing" /t REG_DWORD /d "0" /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype" /v "WPPFilePath" /t REG_SZ /d "%%SYSTEMDRIVE%%\TEMP\Tracing\WPPMedia" /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW" /v "WPPFilePath" /t REG_SZ /d "%%SYSTEMDRIVE%%\TEMP\WPPMedia" /f >nul 2>nul

:: Disable windows media player usage reports
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Windows media player usage reports
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d "0" /f >nul 2>nul

:: Disable mozilla telemetry
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Mozilla telemetry
reg add HKLM\SOFTWARE\Policies\Mozilla\Firefox /v "DisableTelemetry" /t REG_DWORD /d "2" /f >nul 2>nul

:: Settings -> Privacy -> General -> Let apps use my advertising ID...
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Let apps use my advertising ID
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>nul

::  Send Microsoft info about how I write to help us improve typing and writing in the future
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Send Microsoft info about how I write
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f >nul 2>nul

::  Handwriting recognition personalization
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Handwriting recognition personalization
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f >nul 2>nul

:: Disable watson malware reports
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Watson malware reports
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "DisableGenericReports" /t REG_DWORD /d "2" /f >nul 2>nul

:: Disable malware diagnostic data 
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Malware diagnostic data 
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d "2" /f >nul 2>nul

:: Disable  setting override for reporting to Microsoft MAPS
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Setting override for reporting to Microsoft MAPS
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "LocalSettingOverrideSpynetReporting" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable spynet Defender reporting
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Spynet Defender reporting
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d 0 /f >nul 2>nul

:: Do not send malware samples for further analysis
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo + [Setting] Do not send malware samples for further analysis
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "2" /f >nul 2>nul

::  Prevents sending speech, inking and typing samples to MS (so Cortana can learn to recognise you)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Sending speech, inking and typing samples to MS
reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f >nul 2>nul

::  Prevents sending contacts to MS (so Cortana can compare speech etc samples)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Sending contacts to MS
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v HarvestContacts /t REG_DWORD /d 0 /f >nul 2>nul

::  Immobilise Cortana 
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Cortana 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul 2>nul

del %programdata%\ettelemetry.lbool >nul 2>nul

:SkipTelemetry

if not exist %programdata%\etwindowsgamebar.lbool goto SkipWindowsGameBar

:WindowsGameBar

:: Turning Off Windows Game Bar/DVR
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo # [Disable] Windows Game Bar/DVR
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul 2>nul

:: Removing Windows Game Bar 
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo - [Remove] Windows Game Bar 
PowerShell -Command "Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *XboxGameOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage"

del %programdata%\etwindowsgamebar.lbool >nul 2>nul

:SkipWindowsGameBar

if not exist %programdata%\etadblock.lbool goto SkipAdblock

:Adblock

::  Ads blocking via hosts file (AdAway)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo + [Setting] Ad blocking via hosts file
PowerShell -Command "wget https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt -OutFile hosts.txt" >nul 2>nul
if not exist %windir%\System32\Drivers\etc\hosts-copy-et copy %windir%\System32\Drivers\etc\hosts %windir%\System32\Drivers\etc\hosts-copy-et >nul 2>nul
copy hosts.txt %windir%\System32\Drivers\etc\hosts >nul 2>nul
if exist hosts.txt del hosts.txt

del %programdata%\etadblock.lbool >nul 2>nul

:SkipAdblock

:: Disable Some Service:

if not exist %programdata%\etservices.lbool goto SkipServices

:Services

:: Disable
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo + [Setting] Services to: Disable Mode
set toDisable=DiagTrack diagnosticshub.standardcollector.service dmwappushservice RemoteRegistry RemoteAccess SCardSvr SCPolicySvc fax XblAuthManager XboxNetApiSvc XblGameSave WerSvc NvTelemetryContainer gadjservice AdobeARMservice PSI_SVC_2 lfsvc WalletService RetailDemo SEMgrSvc diagsvc AJRouter
(for %%a in (%toDisable%) do ( 
   sc stop %%a >nul 2>nul
   sc config %%a start= disabled  >nul 2>nul
))

:: Manuall
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo + [Setting] Services to: Manuall Mode
set toManuall=BITS SamSs TapiSrv seclogon wuauserv PhoneSvc lmhosts iphlpsvc gupdate gupdatem edgeupdate edgeupdatem MapsBroker PnkBstrA brave bravem asus asusm adobeupdateservice adobeflashplayerupdatesvc WSearch
(for %%a in (%toManuall%) do ( 
   sc config %%a start= demand >nul 2>nul
))

del %programdata%\etservices.lbool >nul 2>nul

:SkipServices

if not exist %programdata%\etbloatware.lbool goto SkipBloatware

:Bloatware

setlocal enabledelayedexpansion

:: Remove Bloatware Apps (Preinstalled) 68 apps
echo - [Remove] Bloatware Apps

set listofbloatware=3DBuilder Automate Appconnector Microsoft3DViewer MicrosoftPowerBIForWindows MicrosoftPowerBIForWindows Print3D XboxApp GetHelp WindowsFeedbackHub BingFoodAndDrink BingHealthAndFitness BingTravel WindowsReadingList MixedReality.Portal ScreenSketch YourPhone PicsArt-PhotoStudio EclipseManager PolarrPhotoEditorAcademicEdition Wunderlist LinkedInforWindows AutodeskSketchBook Twitter DisneyMagicKingdoms MarchofEmpires ActiproSoftwareLLC Plex iHeartRadio FarmVille2CountryEscape Duolingo CyberLinkMediaSuiteEssentials DolbyAccess DrawboardPDF FitbitCoach Flipboard Asphalt8Airborne Keeper BingNews COOKINGFEVER PandoraMediaInc CaesarsSlotsFreeCasino Shazam PhototasticCollage TuneInRadio WinZipUniversal XING RoyalRevolt2 CandyCrushSodaSaga BubbleWitch3Saga CandyCrushSaga Getstarted bing MicrosoftOfficeHub OneNote WindowsPhone SkypeApp windowscommunicationsapps WindowsMaps Sway CommsPhone ConnectivityStore Hotspot Sketchable Clipchamp Prime TikTok ToDo
(for %%a in (%listofbloatware%) do ( 
	set /a insidecount+=1 >nul 2>nul
	title %version% [%counter%/%alltodo%] [!insidecount!/68]
   PowerShell -Command "Get-AppxPackage -allusers *%%a* | Remove-AppxPackage"
))

set /a counter+=1 >nul 2>nul

del %programdata%\etbloatware.lbool >nul 2>nul

:SkipBloatware

if not exist %programdata%\etstartup.lbool goto SkipStartUp

:StartUp

:: Disabling unnecessary applications at startup
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
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

:: uTorrent Autorun
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "ut" /f >nul 2>nul

:: Lync - Skype for Business Autorun
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Lync" /f >nul 2>nul

:: Google Chrome Installer (Update)
reg delete "HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components" /v "Google Chrome" /f >nul 2>nul

:: Microsoft Edge Installer (Update)
reg delete "HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components" /v "Microsoft Edge" /f >nul 2>nul

:: Discord Update
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Discord" /f >nul 2>nul

:: Ubisoft Game Launcher
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Ubisoft Game Launcher" /f >nul 2>nul

del %programdata%\etstartup.lbool >nul 2>nul

:SkipStartUp

if not exist %programdata%\etcleaning.lbool goto SkipCleaning

:Cleaning

::  TEMP/Logs/Cache/Prefetch/Updates Cleaning
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo - [Clean] Temp
Del /S /F /Q %temp% >nul 2>nul
Del /S /F /Q %Windir%\Temp >nul 2>nul

title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo - [Clean] Windows Update downloads
Del /S /F /Q %windir%\SoftwareDistribution\Download >nul 2>nul

title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo - [Clean] Prefetch/Cache/Logs
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

del %localappdata%\EpicGamesLauncher\Saved\Logs /F /Q /S >nul 2>nul
del %localappdata%\CrashReportClient\Saved\Logs /F /Q /S >nul 2>nul

del %localappdata%\Steam\htmlcache\Code Cache /F /Q /S >nul 2>nul
del %localappdata%\Steam\htmlcache\GPUCache /F /Q /S >nul 2>nul
del %localappdata%\Steam\htmlcache\Cache /F /Q /S >nul 2>nul

del %localappdata%\Yarn\Cache /F /Q /S >nul 2>nul

del %appdata%\Microsoft\Teams\Cache /F /Q /S >nul 2>nul

del %programdata%\GOG.com\Galaxy\webcache /F /Q /S >nul 2>nul
del %programdata%\GOG.com\Galaxy\logs /F /Q /S >nul 2>nul

del /f /s /q %systemroot%\System32\DriverStore\FileRepository\*.* >nul 2>nul

del %localappdata%\Microsoft\Windows\WebCache /F /Q /S >nul 2>nul

:: Cleaning Disk - cleanmgr
start cleanmgr.exe /autoclean

:: Cleaning Disk - CCleaner
if not exist "%programfiles%\CCleaner\CCleaner.exe" goto NoCC
if not exist "%programfiles%\CCleaner\CCleaner64.exe" goto NoCC
start CCleaner.exe /AUTO

:NoCC

del %programdata%\etcleaning.lbool >nul 2>nul

:SkipCleaning

if not exist %programdata%\etonedrive.lbool goto SkipOneDrive

:OneDrive
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
echo - [Remove] Microsoft OneDrive
taskkill /F /IM "OneDrive.exe" >nul 2>nul
%systemroot\SysWOW64\OneDriveSetup.exe /uninstall >nul 2>nul
%systemroot\System32\OneDriveSetup.exe /uninstall >nul 2>nul

rd "%UserProfile%\OneDrive" /Q /S 1>NUL 2>NUL
rd "%LocalAppData%\Microsoft\OneDrive" /Q /S 1>NUL 2>NUL
rd "%ProgramData%\Microsoft OneDrive" /Q /S 1>NUL 2>NUL
rd "%systemdrive%\OneDriveTemp" /Q /S 1>NUL 2>NUL

::Remove OneDrive leftovers in explorer left side panel
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>nul

del %programdata%\etonedrive.lbool >nul 2>nul

:SkipOneDrive

echo ------------------------------------------------

set announcement=Everything has been done. Reboot is recommended.
echo %announcement%
powershell (New-Object -ComObject Wscript.Shell).Popup("""%announcement%""",0,"""%version%""",0x40 + 4096) >nul 2>nul
exit
