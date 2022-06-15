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
:: https://github.com/semazurek/ET-All-in-One-Optimizer
:: https://www.paypal.com/paypalme/rikey

set version=E.T. ver 4.6
title %version%

set /a counter=1
set /a alltodo=0
:: alltodo all 66

::First Admin Check
NET SESSION >nul 2>&1
IF %ERRORLEVEL% == 0 goto GUIChoice

::Second Admin Check (old)
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
   echo Requesting administrative privileges...
   goto UACPrompt
) else ( goto GUIChoice )

set announcement=Run the script as an Administrator.
echo %announcement%
powershell (New-Object -ComObject Wscript.Shell).Popup("""%announcement%""",0,"""%version%""",0x10 + 4096)
:: Checks if it is running as administrator if not quit
exit

:: GUI Window Form
:GUIChoice
:: Cleaning help files
del %programdata%\*.lbool >nul 2>nul
if exist GUI.ps1 del GUI.ps1 >nul 2>nul

:: PowerShell Window.Forms Code exported into .ps1
(
echo $versionPS=$args[0]+' '+$args[1]+' '+$args[2];
echo [reflection.assembly]::LoadWithPartialName^( 'System.Windows.Forms'^); 
echo [reflection.assembly]::loadwithpartialname^('System.Drawing'^); 

echo function do_start { 
echo If ^($chck1.Checked -eq 1^) {echo True ^> $Env:programdata\etvisualtweaks.lbool}; 
echo If ^($chck2.Checked -eq 1^) {echo True ^> $Env:programdata\etperformancetweaks.lbool}; 
echo If ^($chck3.Checked -eq 1^) {echo True ^> $Env:programdata\ettelemetry.lbool}; 
echo If ^($chck4.Checked -eq 1^) {echo True ^> $Env:programdata\etwindowsgamebar.lbool}; 
echo If ^($chck5.Checked -eq 1^) {echo True ^> $Env:programdata\etservices.lbool}; 
echo If ^($chck6.Checked -eq 1^) {echo True ^> $Env:programdata\etbloatware.lbool}; 
echo If ^($chck7.Checked -eq 1^) {echo True ^> $Env:programdata\etstartup.lbool}; 
echo If ^($chck8.Checked -eq 1^) {echo True ^> $Env:programdata\etcleaning.lbool}; 
echo If ^($chck9.Checked -eq 1^) {echo True ^> $Env:programdata\etadblock.lbool}; 
echo If ^($chck10.Checked -eq 1^) {echo True ^> $Env:programdata\etonedrive.lbool}; 
echo If ^($chck11.Checked -eq 1^) {echo True ^> $Env:programdata\etxbxservices.lbool}; 
echo If ^($chck12.Checked -eq 1^) {echo True ^> $Env:programdata\etdnsone.lbool}; 
echo $form.close^(^)
echo }; 
echo $form= New-Object Windows.Forms.Form; 
echo $form.Size = New-Object System.Drawing.Size^(350,440^); 
echo $form.StartPosition = 'CenterScreen'; 
echo $form.FormBorderStyle = 'FixedDialog'; 
echo $form.Text = $versionPS; 
echo $form.AutoSizeMode = 'GrowAndShrink'; 
echo $form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen; 
echo $form.MinimizeBox = $false; 
echo $form.MaximizeBox = $false; 
echo $Font = New-Object System.Drawing.Font^('Arial',11,[System.Drawing.FontStyle]::Regular^); 
echo $form.Font = $font; 

echo $B_close = New-Object Windows.Forms.Button; 
echo $B_close.text = 'Start'; 
echo $B_close.Location = New-Object Drawing.Point 170,365; 
echo $B_close.Size = New-Object Drawing.Point 100,25;
echo $B_close.add_click^({do_start}^); $form.controls.add^($B_close^); 

echo $B_checkall = New-Object Windows.Forms.Button; 
echo $B_checkall.text = 'Select All'; 
echo $B_checkall.Location = New-Object Drawing.Point 60,365; 
echo $B_checkall.Size = New-Object Drawing.Point 100,25;
echo $B_checkall.add_click^({
echo $chck1.Checked = $true; $chck2.Checked = $true; $chck3.Checked = $true; $chck4.Checked = $true; $chck5.Checked = $true; $chck6.Checked = $true; 
echo $chck7.Checked = $true; $chck8.Checked = $true; $chck9.Checked = $true; $chck10.Checked = $true; $chck11.Checked = $true; $chck12.Checked = $true; 
echo $B_checkall.Visible = $false;
echo $B_uncheckall.Visible = $true;
echo }^); 
echo $form.controls.add^($B_checkall^);

echo $B_uncheckall = New-Object Windows.Forms.Button; 
echo $B_uncheckall.text = 'Unselect All'; 
echo $B_uncheckall.Location = New-Object Drawing.Point 60,365; 
echo $B_uncheckall.Size = New-Object Drawing.Point 100,25;
echo $B_uncheckall.add_click^({
echo $chck1.Checked = $false; $chck2.Checked = $false; $chck3.Checked = $false; $chck4.Checked = $false; $chck5.Checked = $false; $chck6.Checked = $false; 
echo $chck7.Checked = $false; $chck8.Checked = $false; $chck9.Checked = $false; $chck10.Checked = $false; $chck11.Checked = $false; $chck12.Checked = $false; 
echo $B_checkall.Visible = $true;
echo $B_uncheckall.Visible = $false;
echo }^); 
echo $form.controls.add^($B_uncheckall^);

echo $B_uncheckall.Visible = $false;
echo $label2 = New-Object Windows.Forms.Label; 
echo $label2.Location = New-Object Drawing.Point 10,32; 
echo $label2.Size = New-Object Drawing.Point 270,25; 
echo $label2.text = 'Select improvements to execute:'; 
echo $label2.Font = New-Object System.Drawing.Font^('Arial',11,[System.Drawing.FontStyle]::Bold^); 
echo $form.controls.add^($label2^); 

echo $chck1 = New-Object Windows.Forms.Checkbox; 
echo $chck1.Location = New-Object Drawing.Point 20,55; 
echo $chck1.Size = New-Object Drawing.Point 270,25; 
echo $chck1.Text = 'Enable Visual Tweaks'; 
echo $chck1.TabIndex = 0; 
echo $chck1.Checked = $true; 
echo $form.controls.add^($chck1^); 

echo $chck2 = New-Object Windows.Forms.Checkbox; 
echo $chck2.Location = New-Object Drawing.Point 20,80; 
echo $chck2.Size = New-Object Drawing.Point 270,25; 
echo $chck2.Text = 'Enable Performance Tweaks'; 
echo $chck2.TabIndex = 1; 
echo $chck2.Checked = $true; 
echo $form.controls.add^($chck2^); 

echo $chck3 = New-Object Windows.Forms.Checkbox; 
echo $chck3.Location = New-Object Drawing.Point 20,105; 
echo $chck3.Size = New-Object Drawing.Point 270,25; 
echo $chck3.Text = 'Disable Data Collection/Telemetry'; 
echo $chck3.TabIndex = 2; 
echo $chck3.Checked = $true; 
echo $form.controls.add^($chck3^); 

echo $chck4 = New-Object Windows.Forms.Checkbox; 
echo $chck4.Location = New-Object Drawing.Point 20,130; 
echo $chck4.Size = New-Object Drawing.Point 270,25; 
echo $chck4.Text = 'Remove Windows Game Bar/DVR'; 
echo $chck4.TabIndex = 3; 
echo $chck4.Checked = $true; 
echo $form.controls.add^($chck4^); 

echo $chck5 = New-Object Windows.Forms.Checkbox; 
echo $chck5.Location = New-Object Drawing.Point 20,155; 
echo $chck5.Size = New-Object Drawing.Point 270,25; 
echo $chck5.Text = 'Enable Services Tweaks'; 
echo $chck5.TabIndex = 4; 
echo $chck5.Checked = $true; 
echo $form.controls.add^($chck5^); 

echo $chck6 = New-Object Windows.Forms.Checkbox; 
echo $chck6.Location = New-Object Drawing.Point 20,180; 
echo $chck6.Size = New-Object Drawing.Point 270,25; 
echo $chck6.Text = 'Remove Bloatware ^(Preinstalled^)'; 
echo $chck6.TabIndex = 5; 
echo $chck6.Checked = $true; 
echo $form.controls.add^($chck6^); 

echo $chck7 = New-Object Windows.Forms.Checkbox; 
echo $chck7.Location = New-Object Drawing.Point 20,205; 
echo $chck7.Size = New-Object Drawing.Point 270,25; 
echo $chck7.Text = 'Disable Unnecessary Startup Apps'; 
echo $chck7.TabIndex = 6; 
echo $chck7.Checked = $true; 
echo $form.controls.add^($chck7^); 

echo $chck8 = New-Object Windows.Forms.Checkbox; 
echo $chck8.Location = New-Object Drawing.Point 20,230; 
echo $chck8.Size = New-Object Drawing.Point 275,25; 
echo $chck8.Text = 'Clean Temp/Cache/Prefetch/Updates'; 
echo $chck8.TabIndex = 7; 
echo $chck8.Checked = $true; 
echo $form.controls.add^($chck8^); 

echo $chck9 = New-Object Windows.Forms.Checkbox; 
echo $chck9.Location = New-Object Drawing.Point 20,255; 
echo $chck9.Size = New-Object Drawing.Point 270,25; 
echo $chck9.Text = 'Enable Lite-Adblock ^(AdAway^)'; 
echo $chck9.TabIndex = 8; 
echo $chck9.Checked = $false; 
echo $form.controls.add^($chck9^); 

echo $chck10 = New-Object Windows.Forms.Checkbox; 
echo $chck10.Location = New-Object Drawing.Point 20,280; 
echo $chck10.Size = New-Object Drawing.Point 270,25; 
echo $chck10.Text = 'Remove Microsoft OneDrive'; 
echo $chck10.TabIndex = 9; 
echo $chck10.Checked = $false; 
echo $form.controls.add^($chck10^); 

echo $chck11 = New-Object Windows.Forms.Checkbox; 
echo $chck11.Location = New-Object Drawing.Point 20,305; 
echo $chck11.Size = New-Object Drawing.Point 270,25; 
echo $chck11.Text = 'Disable Xbox Services'; 
echo $chck11.TabIndex = 10; 
echo $chck11.Checked = $false; 
echo $form.controls.add^($chck11^); 


echo $chck12 = New-Object Windows.Forms.Checkbox; 
echo $chck12.Location = New-Object Drawing.Point 20,330; 
echo $chck12.Size = New-Object Drawing.Point 270,25; 
echo $chck12.Text = 'Enable Fast/Secure DNS ^(1.1.1.1^)'; 
echo $chck12.TabIndex = 11; 
echo $chck12.Checked = $false; 
echo $form.controls.add^($chck12^); 


echo function About {
echo $aboutForm = New-Object System.Windows.Forms.Form; 
echo $aboutFormExit = New-Object System.Windows.Forms.Button; 
echo $aboutFormNameLabel = New-Object System.Windows.Forms.Label; 
echo $aboutFormText = New-Object System.Windows.Forms.Label; 
echo $aboutFormText2 = New-Object System.Windows.Forms.Label; 
echo $aboutForm.MinimizeBox = $false; 
echo $aboutForm.MaximizeBox = $false; 
echo $aboutForm.TopMost = $true; 
echo $aboutForm.AutoSizeMode = 'GrowAndShrink'; 
echo $aboutForm.FormBorderStyle = 'FixedDialog'; 
echo $aboutForm.AcceptButton = $aboutFormExit; 
echo $aboutForm.CancelButton = $aboutFormExit; 
echo $aboutForm.ClientSize = '350, 110'; 
echo $aboutForm.ControlBox = $false; 
echo $aboutForm.ShowInTaskBar = $false; 
echo $aboutForm.StartPosition = 'CenterParent'; 
echo $aboutForm.Text = 'About'; 
echo $aboutForm.Add_Load^($aboutForm_Load^); 
echo $aboutFormNameLabel.Font = New-Object Drawing.Font^('Arial', 9, [System.Drawing.FontStyle]::Bold^); 
echo $aboutFormNameLabel.Location = '110, 10'; 
echo $aboutFormNameLabel.Size = '200, 18'; 
echo $aboutFormNameLabel.Text = '       E.T. All in One'; 
echo $aboutForm.Controls.Add^($aboutFormNameLabel^); 
echo $aboutFormText.Location = '100, 30'; 
echo $aboutFormText.Size = '300, 20'; $aboutFormText.Text = '         Sebastian Mazurek'; 
echo $aboutForm.Controls.Add^($aboutFormText^); 
echo $aboutFormText2.Location = '100, 50'; 
echo $aboutFormText2.Size = '300, 20';  
echo $aboutFormText2.Text = '      GitHub.com/semazurek'; 
echo $aboutForm.Controls.Add^($aboutFormText2^); 
echo $aboutFormExit.Location = '138, 75'; 
echo $aboutFormExit.Text = 'OK'; 
echo $aboutForm.Controls.Add^($aboutFormExit^); 
echo [void]$aboutForm.ShowDialog^(^)
echo }; 

echo function Extras {
echo $extraForm = New-Object System.Windows.Forms.Form; 
echo $extraFormB1 = New-Object System.Windows.Forms.Button; 
echo $extraFormB2 = New-Object System.Windows.Forms.Button; 
echo $extraFormB3 = New-Object System.Windows.Forms.Button; 
echo $extraFormB4 = New-Object System.Windows.Forms.Button; 
echo $extraFormB5 = New-Object System.Windows.Forms.Button; 
echo $extraFormB6 = New-Object System.Windows.Forms.Button; 
echo $extraFormB7 = New-Object System.Windows.Forms.Button; 
echo $extraFormB8 = New-Object System.Windows.Forms.Button; 
echo $extraFormB9 = New-Object System.Windows.Forms.Button; 
echo $extraFormB10 = New-Object System.Windows.Forms.Button; 
echo $extraForm.MinimizeBox = $false; 
echo $extraForm.MaximizeBox = $false; 
echo $extraForm.TopMost = $true; 
echo $extraForm.AutoSizeMode = 'GrowAndShrink'; 
echo $extraForm.FormBorderStyle = 'FixedDialog'; 
echo $extraForm.AcceptButton = $extraFormExit; 
echo $extraForm.CancelButton = $extraFormExit; 
echo $extraForm.ClientSize = '200, 330'; 
echo $extraForm.ShowInTaskBar = $false; 

echo $extraForm.Location = ^(30,30^);
echo $extraForm.Text = 'Extras'; 
echo $extraForm.Font = $font;

echo $extraFormB1.Location = '25, 15'; 
echo $extraFormB1.Size = New-Object Drawing.Point 150,25;
echo $extraFormB1.Text = 'Disk Defragmenter'; 
echo $extraFormB1.add_click^({dfrgui.exe}^);
echo $extraForm.Controls.Add^($extraFormB1^); 

echo $extraFormB2.Location = '25, 45'; 
echo $extraFormB2.Size = New-Object Drawing.Point 150,25;
echo $extraFormB2.Text = 'Cleanmgr'; 
echo $extraFormB2.add_click^({cleanmgr.exe}^);
echo $extraForm.Controls.Add^($extraFormB2^); 

echo $extraFormB3.Location = '25, 75'; 
echo $extraFormB3.Size = New-Object Drawing.Point 150,25;
echo $extraFormB3.Text = 'Msconfig'; 
echo $extraFormB3.add_click^({msconfig}^);
echo $extraForm.Controls.Add^($extraFormB3^); 

echo $extraFormB4.Location = '25, 105'; 
echo $extraFormB4.Size = New-Object Drawing.Point 150,25;
echo $extraFormB4.Text = 'Control Panel'; 
echo $extraFormB4.add_click^({control.exe}^);
echo $extraForm.Controls.Add^($extraFormB4^); 

echo $extraFormB5.Location = '25, 135'; 
echo $extraFormB5.Size = New-Object Drawing.Point 150,25;
echo $extraFormB5.Text = 'Device Manager'; 
echo $extraFormB5.add_click^({devmgmt.msc}^);
echo $extraForm.Controls.Add^($extraFormB5^); 

echo $extraFormB6.Location = '25, 165'; 
echo $extraFormB6.Size = New-Object Drawing.Point 150,25;
echo $extraFormB6.Text = 'UAC Settings'; 
echo $extraFormB6.add_click^({UserAccountControlSettings.exe}^);
echo $extraForm.Controls.Add^($extraFormB6^); 

echo $extraFormB7.Location = '25, 195'; 
echo $extraFormB7.Size = New-Object Drawing.Point 150,25;
echo $extraFormB7.Text = 'Msinfo32'; 
echo $extraFormB7.add_click^({msinfo32}^);
echo $extraForm.Controls.Add^($extraFormB7^); 

echo $extraFormB8.Location = '25, 225'; 
echo $extraFormB8.Size = New-Object Drawing.Point 150,25;
echo $extraFormB8.Text = 'Services'; 
echo $extraFormB8.add_click^({services.msc}^);
echo $extraForm.Controls.Add^($extraFormB8^); 

echo $extraFormB9.Location = '25, 255'; 
echo $extraFormB9.Size = New-Object Drawing.Point 150,25;
echo $extraFormB9.Text = 'Remote Desktop'; 
echo $extraFormB9.add_click^({mstsc}^);
echo $extraForm.Controls.Add^($extraFormB9^); 

echo $extraFormB10.Location = '25, 285'; 
echo $extraFormB10.Size = New-Object Drawing.Point 150,25;
echo $extraFormB10.Text = 'Event Viewer'; 
echo $extraFormB10.add_click^({eventvwr.msc}^);
echo $extraForm.Controls.Add^($extraFormB10^); 

echo [void]$extraForm.ShowDialog^(^)
echo }; 

echo function addMenuItem { param^([ref]$ParentItem, [string]$ItemName='', [string]$ItemText='', [scriptblock]$ScriptBlock=$null ^) [System.Windows.Forms.ToolStripMenuItem]$private:menuItem=` New-Object System.Windows.Forms.ToolStripMenuItem;
echo $private:menuItem.Name =$ItemName; 
echo $private:menuItem.Text =$ItemText; 
echo if ^($ScriptBlock -ne $null^) { $private:menuItem.add_Click^(^([System.EventHandler]$handler=` $ScriptBlock^)^);}; 
echo if ^(^($ParentItem.Value^) -is [System.Windows.Forms.MenuStrip]^) { ^($ParentItem.Value^).Items.Add^($private:menuItem^);} return $private:menuItem; }; 
echo function Backup{vssadmin delete shadows /All /Quiet; powershell.exe -Command 'Enable-ComputerRestore -Drive $Env:systemdrive'; powershell.exe -ExecutionPolicy Bypass -Command 'Checkpoint-Computer -Description 'ET-RestorePoint' -RestorePointType 'MODIFY_SETTINGS''; powershell ^(New-Object -ComObject Wscript.Shell^).Popup^('''Restore point has been created.''',0,'''Backup''',0x40 + 4096^); $timeback=Get-Date -Format G ;echo [ET] $timeback ^> $Env:programdata\ET-dump.log}; 
echo [System.Windows.Forms.MenuStrip]$mainMenu=New-Object System.Windows.Forms.MenuStrip; $form.Controls.Add^($mainMenu^); 
echo [scriptblock]$exit= {$form.Close^(^)}; 
echo [scriptblock]$backup= {Backup}; 
echo [scriptblock]$restore= {rstrui.exe}; 
echo [scriptblock]$about= {About}; 
echo [scriptblock]$extras= {Extras}; 
echo ^(addMenuItem -ParentItem ^([ref]$mainMenu^) -ItemName 'mnuFile' -ItemText 'Backup' -ScriptBlock $backup^); 
echo ^(addMenuItem -ParentItem ^([ref]$mainMenu^) -ItemName 'mnuFile' -ItemText 'Restore' -ScriptBlock $restore^); 
echo ^(addMenuItem -ParentItem ^([ref]$mainMenu^) -ItemName 'mnuFile' -ItemText 'Extras' -ScriptBlock $extras^);
echo ^(addMenuItem -ParentItem ^([ref]$mainMenu^) -ItemName 'mnuFile' -ItemText 'About' -ScriptBlock $about^);  
echo ^(addMenuItem -ParentItem ^([ref]$mainMenu^) -ItemName 'mnuFile' -ItemText 'Exit' -ScriptBlock $exit^); 
echo $form.ShowDialog^(^);
)>GUI.ps1

::Force PS authorization for scripts
Powershell -Command "set-executionpolicy remotesigned"
cls
echo Selection window has been initiated
Powershell -Command ".\GUI.ps1 %version%" >nul 2>nul

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
if exist %programdata%\etxbxservices.lbool set /a alltodo+=1
if exist %programdata%\etdnsone.lbool set /a alltodo+=1

:: Cleaning GUI windows form file after usage
if exist GUI.ps1 del GUI.ps1 >nul 2>nul

:: BackUp/Restore Point First Time Run Asking
:RestorePoint
cls
if not exist %programdata%\ET-dump.log goto FirstTime
if exist %programdata%\ET-dump.log goto Start

:FirstTime
cls
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
powershell -Command "Write-Host ' [Setting] Show file extensions in Explorer ' -F blue -B black"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t  REG_DWORD /d 0 /f >nul 2>nul

::  Disable Transparency in taskbar, menu start etc
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Disable Transparency in taskbar/menu start ' -F blue -B black"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f >nul 2>nul

::  Disable windows animations, menu Start animations.
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Windows animations, menu Start animations ' -F darkgray -B black"
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
powershell -Command "Write-Host ' [Disable] News and Interests on Taskbar ' -F darkgray -B black"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable MRU lists (jump lists) of XAML apps in Start Menu
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul 
powershell -Command "Write-Host ' [Disable] MRU lists (jump lists) of XAML apps in Start Menu ' -F darkgray -B black"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f >nul 2>nul

::  Hide the search box from taskbar. You can still search by pressing the Win key and start typing what you're looking for 
:: 0 = hide completely, 1 = show only icon, 2 = show long search box
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Hide the search box from taskbar. ' -F blue -B black"
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f >nul 2>nul

:: Windows Explorer to start on This PC instead of Quick Access 
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Windows Explorer to start on This PC instead of Quick Access ' -F blue -B black" 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul 2>nul

del %programdata%\etvisualtweaks.lbool >nul 2>nul

:SkipVisualTweaks

if not exist %programdata%\etperformancetweaks.lbool goto SkipPerformanceTweaks

:PerformanceTweaks

::  Disable Edge WebWidget
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Edge WebWidget ' -F darkgray -B black"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v WebWidgetAllowed /t REG_DWORD /d 0 /f >nul 2>nul

::  Setting power option to high for best performance
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Power option to high for best performance ' -F blue -B black"
powercfg -setactive scheme_min

::  Enable All (Logical) Cores (Boot Advanced Options)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Enable All (Logical) Cores (Boot Advanced Options) ' -F blue -B black"
wmic cpu get NumberOfLogicalProcessors | findstr /r "[0-9]" > NumLogicalCores.txt
set /P NOLP=<NumLogicalCores.txt
bcdedit /set {current} numproc %NOLP% >nul 2>nul
if exist NumLogicalCores.txt del NumLogicalCores.txt

:: Dual boot timeout 3sec
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Dual boot timeout 3sec ' -F blue -B black"
bcdedit /set timeout 3 >nul 2>nul

:: Disable Hibernation/Fast startup in Windows to free RAM from "C:\hiberfil.sys"
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Hibernation/Fast startup in Windows ' -F darkgray -B black"
powercfg -hibernate off

:: Disable windows insider experiments
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Windows Insider experiments ' -F darkgray -B black"
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f >nul 2>nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t "REG_DWORD" /d "0" /f >nul 2>nul

:: Disable app launch tracking
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] App launch tracking ' -F darkgray -B black"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /d "0" /t REG_DWORD /f >nul 2>nul

:: Disable powerthrottling (Intel 6gen and higher)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Powerthrottling (Intel 6gen and higher) ' -F darkgray -B black"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f >nul 2>nul

:: Turn Off Background Apps
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Turn Off Background Apps ' -F blue -B black"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled  /t REG_DWORD /d 1 /f >nul 2>nul
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v BackgroundAppGlobalToggle /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable Sticky Keys prompt
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Sticky Keys prompt ' -F darkgray -B black"
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d 506 /f >nul 2>nul

:: Disable Activity History
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Activity History ' -F darkgray -B black"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable Automatic Updates for Microsoft Store apps
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Automatic Updates for Microsoft Store apps ' -F darkgray -B black"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul 2>nul

::  SmartScreen Filter for Store Apps: Disable
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] SmartScreen Filter for Store Apps ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f >nul 2>nul

::  Let websites provide locally...
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Let websites provide locally ' -F blue -B black"
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f >nul 2>nul

::  Microsoft Edge settings
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Microsoft Edge settings for privacy ' -F blue -B black"
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v DoNotTrack /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\User\Default\SearchScopes" /v ShowSearchSuggestionsGlobal /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\FlipAhead" /v FPEnabled /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f >nul 2>nul

::  Disable location sensor
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Location sensor ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v SensorPermissionState /t REG_DWORD /d 0 /f >nul 2>nul

:: WiFi Sense: HotSpot Sharing: Disable
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] WiFi Sense: HotSpot Sharing ' -F darkgray -B black"
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v value /t REG_DWORD /d 0 /f >nul 2>nul

:: WiFi Sense: Shared HotSpot Auto-Connect: Disable
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] WiFi Sense: Shared HotSpot Auto-Connect ' -F darkgray -B black"
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v value /t REG_DWORD /d 0 /f >nul 2>nul

:: Change Windows Updates to "Notify to schedule restart"
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Windows Updates to Notify to schedule restart ' -F blue -B black"
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v UxOption /t REG_DWORD /d 1 /f >nul 2>nul

:: Disable P2P Update downloads outside of local network
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] P2P Update downlods outside of local network ' -F darkgray -B black"
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f >nul 2>nul

:: Setting Lower Shutdown time
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Lower Shutdown time ' -F blue -B black"
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d 2000 /f >nul 2>nul

:: Remove Old Device Drivers
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Remove] Old Device Drivers ' -F red -B black"
SET DEVMGR_SHOW_NONPRESENT_DEVICES=1

:: Disable Get Even More Out of Windows Screen /W10
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Get Even More Out of Windows Screen ' -F darkgray -B black"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable automatically installing suggested apps /W10
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Automatically installing suggested apps ' -F darkgray -B black"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable Start Menu Ads/Suggestions /W10
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Start Menu Ads/Suggestions ' -F darkgray -B black"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable Allowing Suggested Apps In WindowsInk Workspace
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Allowing Suggested Apps In WindowsInk Workspace ' -F darkgray -B black"
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WindowsInkWorkspace\AllowSuggestedAppsInWindowsInkWorkspace" /v "value" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disables several unnecessary components
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Unnecessary components ' -F darkgray -B black"
set components=Printing-PrintToPDFServices-Features Printing-XPSServices-Features Xps-Foundation-Xps-Viewer
(for %%a in (%components%) do ( 
   PowerShell -Command " disable-windowsoptionalfeature -online -featureName %%a -NoRestart " >nul 2>nul
))

::  Disabling Process Mitigation
:: Audit exploit mitigations for increased process security or for converting existing Enhanced Mitigation Experience Toolkit
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Process Mitigation ' -F darkgray -B black"
powershell set-ProcessMitigation -System -Disable  DEP, EmulateAtlThunks, SEHOP, ForceRelocateImages, RequireInfo, BottomUp, HighEntropy, StrictHandle, DisableWin32kSystemCalls, AuditSystemCall, DisableExtensionPoints, BlockDynamicCode, AllowThreadsToOptOut, AuditDynamicCode, CFG, SuppressExports, StrictCFG, MicrosoftSignedOnly, AllowStoreSignedBinaries, AuditMicrosoftSigned, AuditStoreSigned, EnforceModuleDependencySigning, DisableNonSystemFonts, AuditFont, BlockRemoteImageLoads, BlockLowLabelImageLoads, PreferSystem32, AuditRemoteImageLoads, AuditLowLabelImageLoads, AuditPreferSystem32, EnableExportAddressFilter, AuditEnableExportAddressFilter, EnableExportAddressFilterPlus, AuditEnableExportAddressFilterPlus, EnableImportAddressFilter, AuditEnableImportAddressFilter, EnableRopStackPivot, AuditEnableRopStackPivot, EnableRopCallerCheck, AuditEnableRopCallerCheck, EnableRopSimExec, AuditEnableRopSimExec, SEHOP, AuditSEHOP, SEHOPTelemetry, TerminateOnError, DisallowChildProcessCreation, AuditChildProcess >nul 2>nul

:: Defragmenting the File Indexing Service database file
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Defragment Database Indexing Service File ' -F blue -B black" 
net stop wsearch >nul 2>nul
esentutl /d C:\ProgramData\Microsoft\Search\Data\Applications\Windows\Windows.edb >nul 2>nul
net start wsearch >nul 2>nul

del %programdata%\etperformancetweaks.lbool >nul 2>nul

:SkipPerformanceTweaks

if not exist %programdata%\ettelemetry.lbool goto SkipTelemetry

:Telemetry

:: SCHEDULED TASKS tweaks (Updates, Telemetry etc)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] SCHEDULED TASKS tweaks (Updates, Telemetry etc) ' -F darkgray -B black"
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
powershell -Command "Write-Host ' [Disable] Telemetry/Data Collection ' -F darkgray -B black" 
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
powershell -Command "Write-Host ' [Disable] PowerShell Telemetry ' -F darkgray -B black"
setx POWERSHELL_TELEMETRY_OPTOUT 1 >nul 2>nul

:: Disable Skype Telemetry
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Skype Telemetry ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW" /v "TraceLevelThreshold" /t REG_DWORD /d "0" /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype" /v "EnableTracing" /t REG_DWORD /d "0" /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW" /v "EnableTracing" /t REG_DWORD /d "0" /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype" /v "WPPFilePath" /t REG_SZ /d "%%SYSTEMDRIVE%%\TEMP\Tracing\WPPMedia" /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW" /v "WPPFilePath" /t REG_SZ /d "%%SYSTEMDRIVE%%\TEMP\WPPMedia" /f >nul 2>nul

:: Disable windows media player usage reports
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Windows media player usage reports ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d "0" /f >nul 2>nul

:: Disable mozilla telemetry
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Mozilla telemetry ' -F darkgray -B black"
reg add HKLM\SOFTWARE\Policies\Mozilla\Firefox /v "DisableTelemetry" /t REG_DWORD /d "2" /f >nul 2>nul

:: Settings -> Privacy -> General -> Let apps use my advertising ID...
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Let apps use my advertising ID ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>nul

::  Send Microsoft info about how I write to help us improve typing and writing in the future
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Send Microsoft info about how I write ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f >nul 2>nul

::  Handwriting recognition personalization
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Handwriting recognition personalization ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f >nul 2>nul

:: Disable watson malware reports
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Watson malware reports ' -F darkgray -B black"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "DisableGenericReports" /t REG_DWORD /d "2" /f >nul 2>nul

:: Disable malware diagnostic data 
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Malware diagnostic data ' -F darkgray -B black" 
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d "2" /f >nul 2>nul

:: Disable  setting override for reporting to Microsoft MAPS
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Setting override for reporting to Microsoft MAPS ' -F darkgray -B black"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "LocalSettingOverrideSpynetReporting" /t REG_DWORD /d 0 /f >nul 2>nul

:: Disable spynet Defender reporting
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Spynet Defender reporting ' -F darkgray -B black"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d 0 /f >nul 2>nul

:: Do not send malware samples for further analysis
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Do not send malware samples for further analysis ' -F blue -B black"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "2" /f >nul 2>nul

::  Prevents sending speech, inking and typing samples to MS (so Cortana can learn to recognise you)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Sending speech, inking and typing samples to MS ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f >nul 2>nul

::  Prevents sending contacts to MS (so Cortana can compare speech etc samples)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Sending contacts to MS ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v HarvestContacts /t REG_DWORD /d 0 /f >nul 2>nul

::  Immobilise Cortana 
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Cortana ' -F darkgray -B black"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul 2>nul

del %programdata%\ettelemetry.lbool >nul 2>nul

:SkipTelemetry

if not exist %programdata%\etwindowsgamebar.lbool goto SkipWindowsGameBar

:WindowsGameBar

:: Turning Off Windows Game Bar/DVR
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Windows Game Bar/DVR ' -F darkgray -B black"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul 2>nul

:: Removing Windows Game Bar 
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Remove] Windows Game Bar ' -F red -B black"
PowerShell -Command "Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *XboxGameOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage"

del %programdata%\etwindowsgamebar.lbool >nul 2>nul

:SkipWindowsGameBar

if not exist %programdata%\etadblock.lbool goto SkipAdblock

:Adblock

::  Ads blocking via hosts file (AdAway)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Ad blocking via hosts file ' -F blue -B black"
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
powershell -Command "Write-Host ' [Setting] Services to: Disable Mode ' -F blue -B black"
set toDisable=DiagTrack diagnosticshub.standardcollector.service dmwappushservice RemoteRegistry RemoteAccess SCardSvr SCPolicySvc fax WerSvc NvTelemetryContainer gadjservice AdobeARMservice PSI_SVC_2 lfsvc WalletService RetailDemo SEMgrSvc diagsvc AJRouter
(for %%a in (%toDisable%) do ( 
   sc stop %%a >nul 2>nul
   sc config %%a start= disabled  >nul 2>nul
))

:: Manuall
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Services to: Manuall Mode ' -F blue -B black"
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
powershell -Command "Write-Host ' [Remove] Bloatware Apps ' -F red -B black"

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
powershell -Command "Write-Host ' [Disable] Unnecessary applications at startup ' -F darkgray -B black"

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
powershell -Command "Write-Host ' [Clean] Temp ' -F darkgreen -B black"
Del /S /F /Q %temp% >nul 2>nul
Del /S /F /Q %Windir%\Temp >nul 2>nul

title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Clean] Windows Update downloads ' -F darkgreen -B black"
Del /S /F /Q %windir%\SoftwareDistribution\Download >nul 2>nul

title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Clean] Prefetch/Cache/Logs ' -F darkgreen -B black"
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
powershell -Command "Write-Host ' [Remove] Microsoft OneDrive ' -F red -B black"
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

if not exist %programdata%\etxbxservices.lbool goto SkipXboxServices

:XboxServices
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Xbox Services ' -F darkgray -B black"
sc config XblAuthManager start= disabled >nul 2>nul
sc config XboxNetApiSvc start= disabled >nul 2>nul
sc config XblGameSave start= disabled >nul 2>nul

del %programdata%\etxbxservices.lbool >nul 2>nul

:SkipXboxServices

if not exist %programdata%\etdnsone.lbool goto SkipDNSOne

:DNSOne
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Fast/Secure DNS 1.1.1.1 ' -F blue -B black"
ipconfig /flushdns >nul 2>nul

:: Custom DNS can couse problems with connection mostly becouse of Internet Service Provider (blocking custom DNS)
:: or could not connect into website (extremely rare case)

netsh interface ipv4 add dnsservers "Ethernet" address=1.1.1.1 index=1 >nul 2>nul
netsh interface ipv4 add dnsservers "Ethernet" address=8.8.8.8 index=2 >nul 2>nul

netsh interface ipv4 add dnsservers "Wi-Fi" address=1.1.1.1 index=1 >nul 2>nul
netsh interface ipv4 add dnsservers "Wi-Fi" address=8.8.8.8 index=2 >nul 2>nul

del %programdata%\etdnsone.lbool >nul 2>nul

:SkipDNSOne

echo ------------------------------------------------

set announcement=Everything has been done. Reboot is recommended.
echo  %announcement%
echo  Donate with PayPal button if you want :)
powershell (New-Object -ComObject Wscript.Shell).Popup("""%announcement%""",0,"""%version%""",0x40 + 4096) >nul 2>nul
exit
