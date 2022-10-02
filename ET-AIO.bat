
:: #############################################################################################################################################
:: DO NOT TOUCH THIS PART INSIDE (PLEASE)
@echo off
setlocal enabledelayedexpansion

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

set version=E.T. ver 5.0
title %version%
::mode con cols=72 lines=30
set /a counter=1
:: alltodo is 63

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
del %programdata%\ET\*.lbool >nul 2>nul
if exist GUI.ps1 del GUI.ps1 >nul 2>nul
if exist %programdata%\GUI.ps1 del %programdata%\GUI.ps1 >nul 2>nul
if not exist %programdata%\ET mkdir %programdata%\ET

:: PowerShell Window.Forms Code exported into .ps1
(
echo $versionPS=$args[0]+' '+$args[1]+' '+$args[2]+'.0';
echo [reflection.assembly]::LoadWithPartialName^( 'System.Windows.Forms'^); 
echo [reflection.assembly]::loadwithpartialname^('System.Drawing'^); 
echo Add-Type -AssemblyName System.Windows.Forms
echo [System.Windows.Forms.Application]::EnableVisualStyles^(^)

echo function do_start { 
echo If ^($chck1.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck1.lbool};
echo If ^($chck2.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck2.lbool};
echo If ^($chck3.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck3.lbool};
echo If ^($chck4.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck4.lbool};
echo If ^($chck5.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck5.lbool};
echo If ^($chck6.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck6.lbool};
echo If ^($chck7.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck7.lbool};
echo If ^($chck8.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck8.lbool};
echo If ^($chck9.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck9.lbool};
echo If ^($chck10.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck10.lbool};
echo If ^($chck11.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck11.lbool};
echo If ^($chck12.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck12.lbool};
echo If ^($chck13.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck13.lbool};
echo If ^($chck14.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck14.lbool};
echo If ^($chck15.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck15.lbool};
echo If ^($chck16.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck16.lbool};
echo If ^($chck17.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck17.lbool};
echo If ^($chck18.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck18.lbool};
echo If ^($chck19.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck19.lbool};
echo If ^($chck20.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck20.lbool};
echo If ^($chck21.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck21.lbool};
echo If ^($chck22.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck22.lbool};
echo If ^($chck23.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck23.lbool};
echo If ^($chck24.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck24.lbool};
echo If ^($chck25.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck25.lbool};
echo If ^($chck26.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck26.lbool};
echo If ^($chck27.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck27.lbool};
echo If ^($chck28.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck28.lbool};
echo If ^($chck29.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck29.lbool};
echo If ^($chck30.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck30.lbool};
echo If ^($chck31.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck31.lbool};
echo If ^($chck32.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck32.lbool};
echo If ^($chck33.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck33.lbool};
echo If ^($chck34.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck34.lbool};
echo If ^($chck35.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck35.lbool};
echo If ^($chck36.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck36.lbool};
echo If ^($chck37.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck37.lbool};
echo If ^($chck38.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck38.lbool};
echo If ^($chck39.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck39.lbool};
echo If ^($chck40.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck40.lbool};
echo If ^($chck41.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck41.lbool};
echo If ^($chck42.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck42.lbool};
echo If ^($chck43.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck43.lbool};
echo If ^($chck44.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck44.lbool};
echo If ^($chck45.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck45.lbool};
echo If ^($chck46.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck46.lbool};
echo If ^($chck47.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck47.lbool};
echo If ^($chck48.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck48.lbool};
echo If ^($chck49.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck49.lbool};
echo If ^($chck50.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck50.lbool};
echo If ^($chck51.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck51.lbool};
echo If ^($chck52.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck52.lbool};
echo If ^($chck53.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck53.lbool};
echo If ^($chck54.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck54.lbool};
echo If ^($chck55.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck55.lbool};
echo If ^($chck56.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck56.lbool};
echo If ^($chck57.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck57.lbool};
echo If ^($chck58.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck58.lbool};
echo If ^($chck59.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck59.lbool};
echo If ^($chck60.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck60.lbool};
echo If ^($chck61.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck61.lbool};
echo If ^($chck62.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck62.lbool};
echo If ^($chck63.Checked -eq 1^) {echo True ^> $Env:programdata\ET\chck63.lbool};
echo $form.close^(^)
echo }; 
echo $form= New-Object Windows.Forms.Form; 
echo $form.Size = New-Object System.Drawing.Size^(895,730^); 
echo $form.StartPosition = 'CenterScreen'; 
echo $form.FormBorderStyle = 'FixedDialog'; 
echo $form.Text = $versionPS; 
echo $form.AutoSizeMode = 'GrowAndShrink'; 
echo $form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen; 
echo $form.MinimizeBox = $false; 
echo $form.MaximizeBox = $false; 
echo $Font = New-Object System.Drawing.Font^('Consolas',9,[System.Drawing.FontStyle]::Regular^); 
echo $form.FlatStyle = 'Flat'
echo $form.BackColor = [System.Drawing.ColorTranslator]::FromHtml^('#252525'^)
echo $form.ForeColor = [System.Drawing.ColorTranslator]::FromHtml^('#eeeeee'^)
echo $form.Font = $font; 

echo $B_close = New-Object Windows.Forms.Button; 
echo $B_close.text = 'Start'; 
echo $B_close.FlatStyle = 'Flat'
echo $B_close.Location = New-Object Drawing.Point 660,625; 
echo $B_close.Size = New-Object Drawing.Point 120,50;
echo $B_close.FlatStyle = 'Flat'
echo $B_close.Font = New-Object System.Drawing.Font^('Consolas',13,[System.Drawing.FontStyle]::Regular^);
echo $B_close.add_click^({do_start}^); $form.controls.add^($B_close^); 

echo $B_checkall = New-Object Windows.Forms.Button; 
echo $B_checkall.text = 'Select All'; 
echo $B_checkall.Location = New-Object Drawing.Point 510,625; 
echo $B_checkall.Size = New-Object Drawing.Point 140,50;
echo $B_checkall.FlatStyle = 'Flat'
echo $B_checkall.Font = New-Object System.Drawing.Font^('Consolas',13,[System.Drawing.FontStyle]::Regular^);
echo $B_checkall.add_click^({
echo $chck1.Checked = $true; $chck2.Checked = $true; $chck3.Checked = $true; $chck4.Checked = $true; $chck5.Checked = $true; $chck6.Checked = $true; $chck7.Checked = $true; $chck8.Checked = $true; $chck9.Checked = $true; $chck10.Checked = $true; 
echo $chck11.Checked = $true; $chck12.Checked = $true; $chck13.Checked = $true; $chck14.Checked = $true; $chck15.Checked = $true; $chck16.Checked = $true; $chck17.Checked = $true; $chck18.Checked = $true; $chck19.Checked = $true; $chck20.Checked = $true;
echo $chck21.Checked = $true; $chck22.Checked = $true; $chck23.Checked = $true; $chck24.Checked = $true; $chck25.Checked = $true; $chck26.Checked = $true; $chck27.Checked = $true; $chck28.Checked = $true; $chck29.Checked = $true; $chck30.Checked = $true;
echo $chck31.Checked = $true; $chck32.Checked = $true; $chck33.Checked = $true; $chck34.Checked = $true; $chck35.Checked = $true; $chck36.Checked = $true; $chck37.Checked = $true; $chck38.Checked = $true; $chck39.Checked = $true; $chck40.Checked = $true;
echo $chck41.Checked = $true; $chck42.Checked = $true; $chck43.Checked = $true; $chck44.Checked = $true; $chck45.Checked = $true; $chck46.Checked = $true; $chck47.Checked = $true; $chck48.Checked = $true; $chck49.Checked = $true; $chck50.Checked = $true;
echo $chck51.Checked = $true; $chck52.Checked = $true; $chck53.Checked = $true; $chck54.Checked = $true; $chck55.Checked = $true; $chck56.Checked = $true; $chck57.Checked = $true; $chck58.Checked = $true; $chck59.Checked = $true; $chck60.Checked = $true;
echo $chck61.Checked = $true; $chck62.Checked = $true; $chck63.Checked = $true;
echo $B_checkall.Visible = $false;
echo $B_uncheckall.Visible = $true;
echo $B_performanceoff.Visible = $true;
echo $B_performanceall.Visible = $false;
echo $B_visualoff.Visible = $true;
echo $B_visualall.Visible = $false;
echo $B_privacyoff.Visible = $true;
echo $B_privacyall.Visible = $false;
echo }^); 
echo $form.controls.add^($B_checkall^);

echo $B_uncheckall = New-Object Windows.Forms.Button; 
echo $B_uncheckall.text = 'Unselect All'; 
echo $B_uncheckall.Location = New-Object Drawing.Point 510,625; 
echo $B_uncheckall.Size = New-Object Drawing.Point 140,50;
echo $B_uncheckall.FlatStyle = 'Flat'
echo $B_uncheckall.Font = New-Object System.Drawing.Font^('Consolas',13,[System.Drawing.FontStyle]::Regular^);
echo $B_uncheckall.add_click^({
echo $chck1.Checked = $false; $chck2.Checked = $false; $chck3.Checked = $false; $chck4.Checked = $false; $chck5.Checked = $false; $chck6.Checked = $false; $chck7.Checked = $false; $chck8.Checked = $false; $chck9.Checked = $false; $chck10.Checked = $false; 
echo $chck11.Checked = $false; $chck12.Checked = $false; $chck13.Checked = $false; $chck14.Checked = $false; $chck15.Checked = $false; $chck16.Checked = $false; $chck17.Checked = $false; $chck18.Checked = $false; $chck19.Checked = $false; $chck20.Checked = $false;
echo $chck21.Checked = $false; $chck22.Checked = $false; $chck23.Checked = $false; $chck24.Checked = $false; $chck25.Checked = $false; $chck26.Checked = $false; $chck27.Checked = $false; $chck28.Checked = $false; $chck29.Checked = $false; $chck30.Checked = $false;
echo $chck31.Checked = $false; $chck32.Checked = $false; $chck33.Checked = $false; $chck34.Checked = $false; $chck35.Checked = $false; $chck36.Checked = $false; $chck37.Checked = $false; $chck38.Checked = $false; $chck39.Checked = $false; $chck40.Checked = $false;
echo $chck41.Checked = $false; $chck42.Checked = $false; $chck43.Checked = $false; $chck44.Checked = $false; $chck45.Checked = $false; $chck46.Checked = $false; $chck47.Checked = $false; $chck48.Checked = $false; $chck49.Checked = $false; $chck50.Checked = $false;
echo $chck51.Checked = $false; $chck52.Checked = $false; $chck53.Checked = $false; $chck54.Checked = $false; $chck55.Checked = $false; $chck56.Checked = $false; $chck57.Checked = $false; $chck58.Checked = $false; $chck59.Checked = $false; $chck60.Checked = $false;
echo $chck61.Checked = $false; $chck62.Checked = $false; $chck63.Checked = $false;
echo $B_checkall.Visible = $true;
echo $B_uncheckall.Visible = $false;
echo $B_performanceoff.Visible = $false;
echo $B_performanceall.Visible = $true;
echo $B_visualoff.Visible = $false;
echo $B_visualall.Visible = $true;
echo $B_privacyoff.Visible = $false;
echo $B_privacyall.Visible = $true;
echo }^); 
echo $form.controls.add^($B_uncheckall^);

echo $B_performanceall = New-Object Windows.Forms.Button; 
echo $B_performanceall.text = 'Performance'; 
echo $B_performanceall.Location = New-Object Drawing.Point 110,625; 
echo $B_performanceall.Size = New-Object Drawing.Point 130,50;
echo $B_performanceall.FlatStyle = 'Flat'
echo $B_performanceall.Font = New-Object System.Drawing.Font^('Consolas',13,[System.Drawing.FontStyle]::Regular^);
echo $B_performanceall.add_click^({
echo $chck1.Checked = $true; $chck2.Checked = $true; $chck3.Checked = $true; $chck4.Checked = $true; $chck5.Checked = $true; $chck6.Checked = $true; $chck7.Checked = $true; $chck8.Checked = $true; $chck9.Checked = $true; $chck10.Checked = $true; 
echo $chck11.Checked = $true; $chck12.Checked = $true; $chck13.Checked = $true; $chck14.Checked = $true; $chck15.Checked = $true; $chck16.Checked = $true; $chck17.Checked = $true; $chck18.Checked = $true; $chck19.Checked = $true; $chck20.Checked = $true;
echo $chck21.Checked = $true; $chck22.Checked = $true; $chck23.Checked = $true; $chck24.Checked = $true; $chck25.Checked = $true; $chck26.Checked = $true; $chck27.Checked = $true; $chck28.Checked = $true; $chck29.Checked = $true; $chck30.Checked = $true;
echo $B_performanceoff.Visible = $true;
echo $B_performanceall.Visible = $false;
echo }^); 
echo $form.controls.add^($B_performanceall^); 

echo $B_performanceoff = New-Object Windows.Forms.Button; 
echo $B_performanceoff.text = 'Performance'; 
echo $B_performanceoff.Location = New-Object Drawing.Point 110,625; 
echo $B_performanceoff.Size = New-Object Drawing.Point 130,50;
echo $B_performanceoff.ForeColor = 'blue';
echo $B_performanceoff.FlatStyle = 'Flat'
echo $B_performanceoff.Font = New-Object System.Drawing.Font^('Consolas',13,[System.Drawing.FontStyle]::Regular^);
echo $B_performanceoff.add_click^({
echo $chck1.Checked = $false; $chck2.Checked = $false; $chck3.Checked = $false; $chck4.Checked = $false; $chck5.Checked = $false; $chck6.Checked = $false; $chck7.Checked = $false; $chck8.Checked = $false; $chck9.Checked = $false; $chck10.Checked = $false; 
echo $chck11.Checked = $false; $chck12.Checked = $false; $chck13.Checked = $false; $chck14.Checked = $false; $chck15.Checked = $false; $chck16.Checked = $false; $chck17.Checked = $false; $chck18.Checked = $false; $chck19.Checked = $false; $chck20.Checked = $false;
echo $chck21.Checked = $false; $chck22.Checked = $false; $chck23.Checked = $false; $chck24.Checked = $false; $chck25.Checked = $false; $chck26.Checked = $false; $chck27.Checked = $false; $chck28.Checked = $false; $chck29.Checked = $false; $chck30.Checked = $false;
echo $B_performanceoff.Visible = $false;
echo $B_performanceall.Visible = $true;
echo }^); 
echo $form.controls.add^($B_performanceoff^); 

echo $B_visualall = New-Object Windows.Forms.Button; 
echo $B_visualall.text = 'Visual'; 
echo $B_visualall.Location = New-Object Drawing.Point 250,625; 
echo $B_visualall.Size = New-Object Drawing.Point 120,50;
echo $B_visualall.FlatStyle = 'Flat'
echo $B_visualall.Font = New-Object System.Drawing.Font^('Consolas',13,[System.Drawing.FontStyle]::Regular^);
echo $B_visualall.add_click^({
echo $chck48.Checked = $true; $chck49.Checked = $true; $chck50.Checked = $true;
echo $chck51.Checked = $true; $chck52.Checked = $true; $chck53.Checked = $true;
echo $B_visualoff.Visible = $true;
echo $B_visualall.Visible = $false;
echo }^); 
echo $form.controls.add^($B_visualall^); 

echo $B_visualoff = New-Object Windows.Forms.Button; 
echo $B_visualoff.text = 'Visual'; 
echo $B_visualoff.Location = New-Object Drawing.Point 250,625; 
echo $B_visualoff.Size = New-Object Drawing.Point 120,50;
echo $B_visualoff.ForeColor = 'blue';
echo $B_visualoff.FlatStyle = 'Flat'
echo $B_visualoff.Font = New-Object System.Drawing.Font^('Consolas',13,[System.Drawing.FontStyle]::Regular^);
echo $B_visualoff.add_click^({
echo $chck48.Checked = $false; $chck49.Checked = $false; $chck50.Checked = $false;
echo $chck51.Checked = $false; $chck52.Checked = $false; $chck53.Checked = $false;
echo $B_visualoff.Visible = $false;
echo $B_visualall.Visible = $true;
echo }^); 
echo $form.controls.add^($B_visualoff^); 

echo $B_privacyall = New-Object Windows.Forms.Button; 
echo $B_privacyall.text = 'Privacy'; 
echo $B_privacyall.Location = New-Object Drawing.Point 380,625; 
echo $B_privacyall.Size = New-Object Drawing.Point 120,50;
echo $B_privacyall.FlatStyle = 'Flat'
echo $B_privacyall.Font = New-Object System.Drawing.Font^('Consolas',13,[System.Drawing.FontStyle]::Regular^);
echo $B_privacyall.add_click^({
echo $chck31.Checked = $true; $chck32.Checked = $true; $chck33.Checked = $true; $chck34.Checked = $true; $chck35.Checked = $true; $chck36.Checked = $true; $chck37.Checked = $true; $chck38.Checked = $true; $chck39.Checked = $true; $chck40.Checked = $true;
echo $chck41.Checked = $true; $chck42.Checked = $true; $chck43.Checked = $true; $chck44.Checked = $true; $chck45.Checked = $true; $chck46.Checked = $true; $chck47.Checked = $true;
echo $B_privacyoff.Visible = $true;
echo $B_privacyall.Visible = $false;
echo }^); 
echo $form.controls.add^($B_privacyall^); 

echo $B_privacyoff = New-Object Windows.Forms.Button; 
echo $B_privacyoff.text = 'Privacy'; 
echo $B_privacyoff.Location = New-Object Drawing.Point 380,625; 
echo $B_privacyoff.Size = New-Object Drawing.Point 120,50;
echo $B_privacyoff.ForeColor = 'blue';
echo $B_privacyoff.FlatStyle = 'Flat'
echo $B_privacyoff.Font = New-Object System.Drawing.Font^('Consolas',13,[System.Drawing.FontStyle]::Regular^);
echo $B_privacyoff.add_click^({
echo $chck31.Checked = $false; $chck32.Checked = $false; $chck33.Checked = $false; $chck34.Checked = $false; $chck35.Checked = $false; $chck36.Checked = $false; $chck37.Checked = $false; $chck38.Checked = $false; $chck39.Checked = $false; $chck40.Checked = $false;
echo $chck41.Checked = $false; $chck42.Checked = $false; $chck43.Checked = $false; $chck44.Checked = $false; $chck45.Checked = $false; $chck46.Checked = $false; $chck47.Checked = $false;
echo $B_privacyoff.Visible = $false;
echo $B_privacyall.Visible = $true;
echo }^); 
echo $form.controls.add^($B_privacyoff^);

echo $B_uncheckall.Visible = $false;
echo $B_performanceall.Visible = $false;
echo $B_visualall.Visible = $false;
echo $B_privacyall.Visible = $false;
echo $label2 = New-Object Windows.Forms.Label; 
echo $label2.Location = '302,436';
echo $label2.Size = New-Object Drawing.Point 270,25; 
echo $label2.text = 'Other'; 
echo $label2.Font = New-Object System.Drawing.Font^('Consolas',11,[System.Drawing.FontStyle]::Bold^); 
echo $form.controls.add^($label2^); 

echo $chck1 = New-Object Windows.Forms.Checkbox; 
echo $chck1.Location = New-Object Drawing.Point 20,55; 
echo $chck1.Size = New-Object Drawing.Point 270,25; 
echo $chck1.Text = 'Disable Edge WebWidget'; 
echo $chck1.TabIndex = 0;
echo $chck1.Checked = $true; 
echo $form.controls.add^($chck1^); 

echo $chck2 = New-Object Windows.Forms.Checkbox; 
echo $chck2.Location = New-Object Drawing.Point 20,80; 
echo $chck2.Size = New-Object Drawing.Point 270,25; 
echo $chck2.Text = 'Set Power Option to High'; 
echo $chck2.TabIndex = 1; 
echo $chck2.Checked = $true; 
echo $form.controls.add^($chck2^); 
echo $chck2.add_MouseHover^({
echo $tooltip2 = New-Object System.Windows.Forms.ToolTip
echo $tooltip2.SetToolTip^($chck2, 'Setting power option to high for best CPU performance'^)
echo }^)

echo $chck3 = New-Object Windows.Forms.Checkbox; 
echo $chck3.Location = New-Object Drawing.Point 20,105; 
echo $chck3.Size = New-Object Drawing.Point 270,25; 
echo $chck3.Text = 'Enable All ^(Logical^) Cores'; 
echo $chck3.TabIndex = 2; 
echo $chck3.Checked = $true; 
echo $form.controls.add^($chck3^); 

echo $chck4 = New-Object Windows.Forms.Checkbox; 
echo $chck4.Location = New-Object Drawing.Point 20,130; 
echo $chck4.Size = New-Object Drawing.Point 270,25; 
echo $chck4.Text = 'Dual Boot Timeout 3sec'; 
echo $chck4.TabIndex = 3; 
echo $chck4.Checked = $true; 
echo $form.controls.add^($chck4^); 

echo $chck5 = New-Object Windows.Forms.Checkbox; 
echo $chck5.Location = New-Object Drawing.Point 20,155; 
echo $chck5.Size = New-Object Drawing.Point 270,25; 
echo $chck5.Text = 'Disable Hibernation/Fast Startup'; 
echo $chck5.TabIndex = 4; 
echo $chck5.Checked = $true; 
echo $form.controls.add^($chck5^); 
echo $chck5.add_MouseHover^({
echo $tooltip5 = New-Object System.Windows.Forms.ToolTip
echo $tooltip5.SetToolTip^($chck5, 'Disable Hibernation/Fast startup in Windows to free RAM from hiberfil.sys'^)
echo }^)

echo $chck6 = New-Object Windows.Forms.Checkbox; 
echo $chck6.Location = New-Object Drawing.Point 20,180; 
echo $chck6.Size = New-Object Drawing.Point 280,25; 
echo $chck6.Text = 'Disable Windows Insider Experiments'; 
echo $chck6.TabIndex = 5; 
echo $chck6.Checked = $true; 
echo $form.controls.add^($chck6^); 

echo $chck7 = New-Object Windows.Forms.Checkbox; 
echo $chck7.Location = New-Object Drawing.Point 20,205; 
echo $chck7.Size = New-Object Drawing.Point 270,25; 
echo $chck7.Text = 'Disable App Launch Tracking'; 
echo $chck7.TabIndex = 6; 
echo $chck7.Checked = $true; 
echo $form.controls.add^($chck7^); 

echo $chck8 = New-Object Windows.Forms.Checkbox; 
echo $chck8.Location = New-Object Drawing.Point 20,230; 
echo $chck8.Size = New-Object Drawing.Point 275,25; 
echo $chck8.Text = 'Disable Powerthrottling ^(Intel 6gen+^)'; 
echo $chck8.TabIndex = 7; 
echo $chck8.Checked = $true; 
echo $form.controls.add^($chck8^); 

echo $chck9 = New-Object Windows.Forms.Checkbox; 
echo $chck9.Location = New-Object Drawing.Point 20,255; 
echo $chck9.Size = New-Object Drawing.Point 275,25; 
echo $chck9.Text = 'Turn Off Background Apps'; 
echo $chck9.TabIndex = 8; 
echo $chck9.Checked = $true; 
echo $form.controls.add^($chck9^); 

echo $chck10 = New-Object Windows.Forms.Checkbox; 
echo $chck10.Location = New-Object Drawing.Point 20,280; 
echo $chck10.Size = New-Object Drawing.Point 270,25; 
echo $chck10.Text = 'Disable Sticky Keys Prompt'; 
echo $chck10.TabIndex = 9; 
echo $chck10.Checked = $true; 
echo $form.controls.add^($chck10^); 

echo $chck11 = New-Object Windows.Forms.Checkbox; 
echo $chck11.Location = New-Object Drawing.Point 20,305; 
echo $chck11.Size = New-Object Drawing.Point 270,25; 
echo $chck11.Text = 'Disable Activity History'; 
echo $chck11.TabIndex = 10; 
echo $chck11.Checked = $true; 
echo $form.controls.add^($chck11^); 

echo $chck12 = New-Object Windows.Forms.Checkbox; 
echo $chck12.Location = New-Object Drawing.Point 20,330; 
echo $chck12.Size = New-Object Drawing.Point 280,25; 
echo $chck12.Text = 'Disable Updates for MS Store Apps'; 
echo $chck12.TabIndex = 11; 
echo $chck12.Checked = $true; 
echo $form.controls.add^($chck12^); 
echo $chck12.add_MouseHover^({
echo $tooltip12 = New-Object System.Windows.Forms.ToolTip
echo $tooltip12.SetToolTip^($chck12, 'Disable Automatic Updates for Microsoft Store apps'^)
echo }^)

echo $chck13 = New-Object Windows.Forms.Checkbox; 
echo $chck13.Location = New-Object Drawing.Point 20,355; 
echo $chck13.Size = New-Object Drawing.Point 270,25; 
echo $chck13.Text = 'SmartScreen Filter for Apps: Disable'; 
echo $chck13.TabIndex = 12; 
echo $chck13.Checked = $true; 
echo $form.controls.add^($chck13^); 

echo $chck14 = New-Object Windows.Forms.Checkbox; 
echo $chck14.Location = New-Object Drawing.Point 20,380; 
echo $chck14.Size = New-Object Drawing.Point 270,25; 
echo $chck14.Text = 'Let Websites Provide Locally'; 
echo $chck14.TabIndex = 13; 
echo $chck14.Checked = $true; 
echo $form.controls.add^($chck14^); 

echo $chck15 = New-Object Windows.Forms.Checkbox; 
echo $chck15.Location = New-Object Drawing.Point 20,405; 
echo $chck15.Size = New-Object Drawing.Point 270,25; 
echo $chck15.Text = 'Fix Microsoft Edge Settings'; 
echo $chck15.TabIndex = 14; 
echo $chck15.Checked = $true; 
echo $form.controls.add^($chck15^); 

echo $chck16 = New-Object Windows.Forms.Checkbox; 
echo $chck16.Location = New-Object Drawing.Point 305,55; 
echo $chck16.Size = New-Object Drawing.Point 270,25; 
echo $chck16.Text = 'Disable Location Sensor'; 
echo $chck16.TabIndex = 15; 
echo $chck16.Checked = $true; 
echo $form.controls.add^($chck16^); 

echo $chck17 = New-Object Windows.Forms.Checkbox; 
echo $chck17.Location = New-Object Drawing.Point 305,80; 
echo $chck17.Size = New-Object Drawing.Point 270,25; 
echo $chck17.Text = 'Disable WiFi HotSpot Auto-Sharing'; 
echo $chck17.TabIndex = 16; 
echo $chck17.Checked = $true; 
echo $form.controls.add^($chck17^); 

echo $chck18 = New-Object Windows.Forms.Checkbox; 
echo $chck18.Location = New-Object Drawing.Point 305,105; 
echo $chck18.Size = New-Object Drawing.Point 270,25; 
echo $chck18.Text = 'Disable Shared HotSpot Connect'; 
echo $chck18.TabIndex = 17; 
echo $chck18.Checked = $true; 
echo $form.controls.add^($chck18^); 

echo $chck19 = New-Object Windows.Forms.Checkbox; 
echo $chck19.Location = New-Object Drawing.Point 305,130; 
echo $chck19.Size = New-Object Drawing.Point 270,25; 
echo $chck19.Text = 'Updates Notify to Schedule Restart'; 
echo $chck19.TabIndex = 18; 
echo $chck19.Checked = $true; 
echo $form.controls.add^($chck19^); 
echo $chck19.add_MouseHover^({
echo $tooltip19 = New-Object System.Windows.Forms.ToolTip
echo $tooltip19.SetToolTip^($chck19, 'Change Windows Updates to: Notify to schedule restart'^)
echo }^)

echo $chck20 = New-Object Windows.Forms.Checkbox; 
echo $chck20.Location = New-Object Drawing.Point 305,155; 
echo $chck20.Size = New-Object Drawing.Point 270,25; 
echo $chck20.Text = 'P2P Update Setting to LAN ^(local^)'; 
echo $chck20.TabIndex = 19; 
echo $chck20.Checked = $true; 
echo $form.controls.add^($chck20^); 
echo $chck20.add_MouseHover^({
echo $tooltip20 = New-Object System.Windows.Forms.ToolTip
echo $tooltip20.SetToolTip^($chck20, 'Disable P2P Update downloads outside of local network'^)
echo }^)

echo $chck21 = New-Object Windows.Forms.Checkbox; 
echo $chck21.Location = New-Object Drawing.Point 305,180; 
echo $chck21.Size = New-Object Drawing.Point 270,25; 
echo $chck21.Text = 'Set Lower Shutdown Time ^(2sec^)'; 
echo $chck21.TabIndex = 20; 
echo $chck21.Checked = $true; 
echo $form.controls.add^($chck21^); 

echo $chck22 = New-Object Windows.Forms.Checkbox; 
echo $chck22.Location = New-Object Drawing.Point 305,205; 
echo $chck22.Size = New-Object Drawing.Point 270,25; 
echo $chck22.Text = 'Remove Old Device Drivers'; 
echo $chck22.TabIndex = 21; 
echo $chck22.Checked = $true; 
echo $form.controls.add^($chck22^); 

echo $chck23 = New-Object Windows.Forms.Checkbox; 
echo $chck23.Location = New-Object Drawing.Point 305,230; 
echo $chck23.Size = New-Object Drawing.Point 270,25; 
echo $chck23.Text = 'Disable Get Even More Out of...'; 
echo $chck23.TabIndex = 22; 
echo $chck23.Checked = $true; 
echo $form.controls.add^($chck23^); 
echo $chck23.add_MouseHover^({
echo $tooltip23 = New-Object System.Windows.Forms.ToolTip
echo $tooltip23.SetToolTip^($chck23, 'Disable Get Even More Out of Windows Screen'^)
echo }^)

echo $chck24 = New-Object Windows.Forms.Checkbox; 
echo $chck24.Location = New-Object Drawing.Point 305,255; 
echo $chck24.Size = New-Object Drawing.Point 270,25; 
echo $chck24.Text = 'Disable Installing Suggested Apps'; 
echo $chck24.TabIndex = 23; 
echo $chck24.Checked = $true; 
echo $form.controls.add^($chck24^); 
echo $chck24.add_MouseHover^({
echo $tooltip24 = New-Object System.Windows.Forms.ToolTip
echo $tooltip24.SetToolTip^($chck23, 'Disable automatically installing suggested apps'^)
echo }^)

echo $chck25 = New-Object Windows.Forms.Checkbox; 
echo $chck25.Location = New-Object Drawing.Point 305,280; 
echo $chck25.Size = New-Object Drawing.Point 270,25; 
echo $chck25.Text = 'Disable Start Menu Ads/Suggestions'; 
echo $chck25.TabIndex = 24; 
echo $chck25.Checked = $true; 
echo $form.controls.add^($chck25^); 

echo $chck26 = New-Object Windows.Forms.Checkbox; 
echo $chck26.Location = New-Object Drawing.Point 305,305; 
echo $chck26.Size = New-Object Drawing.Point 274,25; 
echo $chck26.Text = 'Disable Suggest Apps WindowsInk'; 
echo $chck26.TabIndex = 25; 
echo $chck26.Checked = $true; 
echo $form.controls.add^($chck26^); 

echo $chck27 = New-Object Windows.Forms.Checkbox; 
echo $chck27.Location = New-Object Drawing.Point 305,330; 
echo $chck27.Size = New-Object Drawing.Point 270,25; 
echo $chck27.Text = 'Disable Unnecessary Components'; 
echo $chck27.TabIndex = 26; 
echo $chck27.Checked = $true; 
echo $form.controls.add^($chck27^); 
echo $chck27.add_MouseHover^({
echo $tooltip27 = New-Object System.Windows.Forms.ToolTip
echo $tooltip27.SetToolTip^($chck27, 'PrintToPDFServices, Printing-XPSServices, Xps-Viewer'^)
echo }^)

echo $chck28 = New-Object Windows.Forms.Checkbox; 
echo $chck28.Location = New-Object Drawing.Point 305,355; 
echo $chck28.Size = New-Object Drawing.Point 270,25; 
echo $chck28.Text = 'Defender Scheduled Scan Nerf'; 
echo $chck28.TabIndex = 27; 
echo $chck28.Checked = $true; 
echo $form.controls.add^($chck28^); 
echo $chck28.add_MouseHover^({
echo $tooltip28 = New-Object System.Windows.Forms.ToolTip
echo $tooltip28.SetToolTip^($chck28, 'Setting Windows Defender Scheduled Scan from highest to normal privileges'^)
echo }^)


echo $chck29 = New-Object Windows.Forms.Checkbox; 
echo $chck29.Location = New-Object Drawing.Point 305,380; 
echo $chck29.Size = New-Object Drawing.Point 270,25; 
echo $chck29.Text = 'Disable Process Mitigation'; 
echo $chck29.TabIndex = 28; 
echo $chck29.Checked = $true; 
echo $form.controls.add^($chck29^); 
echo $chck29.add_MouseHover^({
echo $tooltip29 = New-Object System.Windows.Forms.ToolTip
echo $tooltip29.SetToolTip^($chck29, 'Audit exploit mitigations for increased process security or for converting existing Enhanced Mitigation Experience Toolkit'^)
echo }^)

echo $chck30 = New-Object Windows.Forms.Checkbox; 
echo $chck30.Location = New-Object Drawing.Point 305,405; 
echo $chck30.Size = New-Object Drawing.Point 270,25; 
echo $chck30.Text = 'Defragment Indexing Service File'; 
echo $chck30.TabIndex = 29; 
echo $chck30.Checked = $true; 
echo $form.controls.add^($chck30^); 
echo $chck30.add_MouseHover^({
echo $tooltip30 = New-Object System.Windows.Forms.ToolTip
echo $tooltip30.SetToolTip^($chck30, 'Defragmenting the Indexing Service database file'^)
echo }^) 

echo $chck31 = New-Object Windows.Forms.Checkbox; 
echo $chck31.Location = New-Object Drawing.Point 595,55; 
echo $chck31.Size = New-Object Drawing.Point 270,25; 
echo $chck31.Text = 'Disable Telemetry Scheduled Tasks'; 
echo $chck31.TabIndex = 30; 
echo $chck31.Checked = $true; 
echo $form.controls.add^($chck31^); 

echo $chck32 = New-Object Windows.Forms.Checkbox; 
echo $chck32.Location = New-Object Drawing.Point 595,80; 
echo $chck32.Size = New-Object Drawing.Point 270,25; 
echo $chck32.Text = 'Remove Telemetry/Data Collection'; 
echo $chck32.TabIndex = 31; 
echo $chck32.Checked = $true; 
echo $form.controls.add^($chck32^); 

echo $chck33 = New-Object Windows.Forms.Checkbox; 
echo $chck33.Location = New-Object Drawing.Point 595,105; 
echo $chck33.Size = New-Object Drawing.Point 270,25; 
echo $chck33.Text = 'Disable PowerShell Telemetry'; 
echo $chck33.TabIndex = 32; 
echo $chck33.Checked = $true; 
echo $form.controls.add^($chck33^); 

echo $chck34 = New-Object Windows.Forms.Checkbox; 
echo $chck34.Location = New-Object Drawing.Point 595,130; 
echo $chck34.Size = New-Object Drawing.Point 270,25; 
echo $chck34.Text = 'Disable Skype Telemetry'; 
echo $chck34.TabIndex = 33; 
echo $chck34.Checked = $true; 
echo $form.controls.add^($chck34^); 

echo $chck35 = New-Object Windows.Forms.Checkbox; 
echo $chck35.Location = New-Object Drawing.Point 595,155; 
echo $chck35.Size = New-Object Drawing.Point 270,25; 
echo $chck35.Text = 'Disable Media Player Usage Reports'; 
echo $chck35.TabIndex = 34; 
echo $chck35.Checked = $true; 
echo $form.controls.add^($chck35^); 

echo $chck36 = New-Object Windows.Forms.Checkbox; 
echo $chck36.Location = New-Object Drawing.Point 595,180; 
echo $chck36.Size = New-Object Drawing.Point 270,25; 
echo $chck36.Text = 'Disable Mozilla Telemetry'; 
echo $chck36.TabIndex = 35; 
echo $chck36.Checked = $true; 
echo $form.controls.add^($chck36^); 

echo $chck37 = New-Object Windows.Forms.Checkbox; 
echo $chck37.Location = New-Object Drawing.Point 595,205; 
echo $chck37.Size = New-Object Drawing.Point 270,25; 
echo $chck37.Text = 'Disable Apps Use My Advertising ID'; 
echo $chck37.TabIndex = 36; 
echo $chck37.Checked = $true; 
echo $form.controls.add^($chck37^); 

echo $chck38 = New-Object Windows.Forms.Checkbox; 
echo $chck38.Location = New-Object Drawing.Point 595,230; 
echo $chck38.Size = New-Object Drawing.Point 270,25; 
echo $chck38.Text = 'Disable Send Info About How I Write'; 
echo $chck38.TabIndex = 37; 
echo $chck38.Checked = $true; 
echo $form.controls.add^($chck38^); 

echo $chck39 = New-Object Windows.Forms.Checkbox; 
echo $chck39.Location = New-Object Drawing.Point 595,255; 
echo $chck39.Size = New-Object Drawing.Point 270,25; 
echo $chck39.Text = 'Disable Handwriting Recognition'; 
echo $chck39.TabIndex = 38; 
echo $chck39.Checked = $true; 
echo $form.controls.add^($chck39^); 

echo $chck40 = New-Object Windows.Forms.Checkbox; 
echo $chck40.Location = New-Object Drawing.Point 595,280; 
echo $chck40.Size = New-Object Drawing.Point 270,25; 
echo $chck40.Text = 'Disable Watson Malware Reports'; 
echo $chck40.TabIndex = 39; 
echo $chck40.Checked = $true; 
echo $form.controls.add^($chck40^); 

echo $chck41 = New-Object Windows.Forms.Checkbox; 
echo $chck41.Location = New-Object Drawing.Point 595,305; 
echo $chck41.Size = New-Object Drawing.Point 270,25; 
echo $chck41.Text = 'Disable Malware Diagnostic Data'; 
echo $chck41.TabIndex = 40; 
echo $chck41.Checked = $true; 
echo $form.controls.add^($chck41^); 

echo $chck42 = New-Object Windows.Forms.Checkbox; 
echo $chck42.Location = New-Object Drawing.Point 595,330; 
echo $chck42.Size = New-Object Drawing.Point 270,25; 
echo $chck42.Text = 'Disable Reporting to MS MAPS'; 
echo $chck42.TabIndex = 41; 
echo $chck42.Checked = $true; 
echo $form.controls.add^($chck42^); 

echo $chck43 = New-Object Windows.Forms.Checkbox; 
echo $chck43.Location = New-Object Drawing.Point 595,355; 
echo $chck43.Size = New-Object Drawing.Point 270,25; 
echo $chck43.Text = 'Disable Spynet Defender Reporting'; 
echo $chck43.TabIndex = 42; 
echo $chck43.Checked = $true; 
echo $form.controls.add^($chck43^); 

echo $chck44 = New-Object Windows.Forms.Checkbox; 
echo $chck44.Location = New-Object Drawing.Point 595,380; 
echo $chck44.Size = New-Object Drawing.Point 270,25; 
echo $chck44.Text = 'Do Not Send Malware Samples'; 
echo $chck44.TabIndex = 43; 
echo $chck44.Checked = $true; 
echo $form.controls.add^($chck44^); 

echo $chck45 = New-Object Windows.Forms.Checkbox; 
echo $chck45.Location = New-Object Drawing.Point 595,405; 
echo $chck45.Size = New-Object Drawing.Point 270,25; 
echo $chck45.Text = 'Disable Sending Typing Samples'; 
echo $chck45.TabIndex = 44; 
echo $chck45.Checked = $true; 
echo $form.controls.add^($chck45^); 

echo $chck46 = New-Object Windows.Forms.Checkbox; 
echo $chck46.Location = New-Object Drawing.Point 595,430; 
echo $chck46.Size = New-Object Drawing.Point 270,25; 
echo $chck46.Text = 'Disable Sending Contacts to MS'; 
echo $chck46.TabIndex = 45; 
echo $chck46.Checked = $true; 
echo $form.controls.add^($chck46^); 

echo $chck47 = New-Object Windows.Forms.Checkbox; 
echo $chck47.Location = New-Object Drawing.Point 595,455; 
echo $chck47.Size = New-Object Drawing.Point 270,25; 
echo $chck47.Text = 'Disable Cortana'; 
echo $chck47.TabIndex = 46; 
echo $chck47.Checked = $true; 
echo $form.controls.add^($chck47^); 

echo $chck48 = New-Object Windows.Forms.Checkbox; 
echo $chck48.Location = New-Object Drawing.Point 20,460; 
echo $chck48.Size = New-Object Drawing.Point 270,25; 
echo $chck48.Text = 'Show File Extensions in Explorer'; 
echo $chck48.TabIndex = 47; 
echo $chck48.Checked = $true; 
echo $form.controls.add^($chck48^); 

echo $chck49 = New-Object Windows.Forms.Checkbox; 
echo $chck49.Location = New-Object Drawing.Point 20,485; 
echo $chck49.Size = New-Object Drawing.Point 270,25; 
echo $chck49.Text = 'Disable Transparency on Taskbar'; 
echo $chck49.TabIndex = 48; 
echo $chck49.Checked = $true; 
echo $form.controls.add^($chck49^); 

echo $chck50 = New-Object Windows.Forms.Checkbox; 
echo $chck50.Location = New-Object Drawing.Point 20,510; 
echo $chck50.Size = New-Object Drawing.Point 270,25; 
echo $chck50.Text = 'Disable Windows Animations'; 
echo $chck50.TabIndex = 49; 
echo $chck50.Checked = $true; 
echo $form.controls.add^($chck50^); 

echo $chck51 = New-Object Windows.Forms.Checkbox; 
echo $chck51.Location = New-Object Drawing.Point 20,535; 
echo $chck51.Size = New-Object Drawing.Point 270,25; 
echo $chck51.Text = 'Disable MRU lists ^(jump lists^)'; 
echo $chck51.TabIndex = 50; 
echo $chck51.Checked = $true; 
echo $form.controls.add^($chck51^); 

echo $chck52 = New-Object Windows.Forms.Checkbox; 
echo $chck52.Location = New-Object Drawing.Point 20,560; 
echo $chck52.Size = New-Object Drawing.Point 270,25; 
echo $chck52.Text = 'Set Search Box to Icon Only'; 
echo $chck52.TabIndex = 51; 
echo $chck52.Checked = $true; 
echo $form.controls.add^($chck52^);

echo $chck53 = New-Object Windows.Forms.Checkbox; 
echo $chck53.Location = New-Object Drawing.Point 20,585; 
echo $chck53.Size = New-Object Drawing.Point 270,25; 
echo $chck53.Text = 'Explorer on Start on This PC'; 
echo $chck53.TabIndex = 52; 
echo $chck53.Checked = $true; 
echo $form.controls.add^($chck53^); 

echo $chck54 = New-Object Windows.Forms.Checkbox; 
echo $chck54.Location = New-Object Drawing.Point 305,460; 
echo $chck54.Size = New-Object Drawing.Point 270,25; 
echo $chck54.Text = 'Remove Windows Game Bar/DVR'; 
echo $chck54.TabIndex = 53; 
echo $chck54.Checked = $true; 
echo $form.controls.add^($chck54^);  

echo $chck55 = New-Object Windows.Forms.Checkbox; 
echo $chck55.Location = New-Object Drawing.Point 305,485; 
echo $chck55.Size = New-Object Drawing.Point 270,25; 
echo $chck55.Text = 'Enable Service Tweaks'; 
echo $chck55.TabIndex = 54; 
echo $chck55.Checked = $true; 
echo $form.controls.add^($chck55^); 
echo $chck55.add_MouseHover^({
echo $tooltip55 = New-Object System.Windows.Forms.ToolTip
echo $tooltip55.SetToolTip^($chck55, 'More details on github.com/semazurek '^)
echo }^)

echo $chck56 = New-Object Windows.Forms.Checkbox; 
echo $chck56.Location = New-Object Drawing.Point 305,510; 
echo $chck56.Size = New-Object Drawing.Point 270,25; 
echo $chck56.Text = 'Remove Bloatware ^(Preinstalled^)'; 
echo $chck56.TabIndex = 55; 
echo $chck56.Checked = $true; 
echo $form.controls.add^($chck56^);
echo $chck56.add_MouseHover^({
echo $tooltip56 = New-Object System.Windows.Forms.ToolTip
echo $tooltip56.SetToolTip^($chck56, 'More details on github.com/semazurek '^)
echo }^)

echo $chck57 = New-Object Windows.Forms.Checkbox; 
echo $chck57.Location = New-Object Drawing.Point 305,535; 
echo $chck57.Size = New-Object Drawing.Point 270,25; 
echo $chck57.Text = 'Disable Unnecessary Startup Apps'; 
echo $chck57.TabIndex = 56; 
echo $chck57.Checked = $true; 
echo $form.controls.add^($chck57^); 
echo $chck57.add_MouseHover^({
echo $tooltip57 = New-Object System.Windows.Forms.ToolTip
echo $tooltip57.SetToolTip^($chck57, "Java Update Checker x64 `n Mini Partition Tool Wizard Updater `n Teams Machine Installer `n Cisco Meeting Daemon `n Adobe Reader Speed Launcher `n CCleaner Smart Cleaning/Monitor `n Spotify Web Helper `n Gaijin.Net Updater `n Microsoft Teams Update `n Google Update `n Microsoft Edge Update `n BitTorrent Bleep `n Skype `n Adobe Update Startup Utility `n iTunes Helper `n CyberLink Update Utility `n MSI Live Update `n Wondershare Helper Compact `n Cisco AnyConnect Secure Mobility Agent `n Wargaming.net Game Center `n Skype for Desktop `n Gog Galaxy `n Epic Games Launcher `n Origin `n Steam `n Opera Browser Assistant `n uTorrent `n Skype for Business `n Google Chrome Installer `n Microsoft Edge Installer `n Discord Update"^)
echo }^)

echo $chck58 = New-Object Windows.Forms.Checkbox; 
echo $chck58.Location = New-Object Drawing.Point 305,560; 
echo $chck58.Size = New-Object Drawing.Point 270,25; 
echo $chck58.Text = 'Clean Temp/Cache/Prefetch/Logs'; 
echo $chck58.TabIndex = 57; 
echo $chck58.Checked = $true; 
echo $form.controls.add^($chck58^); 

echo $chck59 = New-Object Windows.Forms.Checkbox; 
echo $chck59.Location = New-Object Drawing.Point 305,585; 
echo $chck59.Size = New-Object Drawing.Point 275,25; 
echo $chck59.Text = 'Remove News and Interests/Widgets'; 
echo $chck59.TabIndex = 58; 
echo $chck59.Checked = $false; 
echo $form.controls.add^($chck59^); 

echo $chck60 = New-Object Windows.Forms.Checkbox; 
echo $chck60.Location = New-Object Drawing.Point 595,495; 
echo $chck60.Size = New-Object Drawing.Point 270,25; 
echo $chck60.Text = 'Remove Microsoft OneDrive'; 
echo $chck60.TabIndex = 59; 
echo $chck60.Checked = $false; 
echo $form.controls.add^($chck60^); 

echo $chck61 = New-Object Windows.Forms.Checkbox; 
echo $chck61.Location = New-Object Drawing.Point 595,520; 
echo $chck61.Size = New-Object Drawing.Point 270,25; 
echo $chck61.Text = 'Disable Xbox Services'; 
echo $chck61.TabIndex = 60; 
echo $chck61.Checked = $false; 
echo $form.controls.add^($chck61^); 

echo $chck62 = New-Object Windows.Forms.Checkbox; 
echo $chck62.Location = New-Object Drawing.Point 595,545; 
echo $chck62.Size = New-Object Drawing.Point 270,25; 
echo $chck62.Text = 'Enable Fast/Secure DNS ^(1.1.1.1^)'; 
echo $chck62.TabIndex = 61; 
echo $chck62.Checked = $false; 
echo $form.controls.add^($chck62^); 

echo $chck63 = New-Object Windows.Forms.Checkbox; 
echo $chck63.Location = New-Object Drawing.Point 595,570; 
echo $chck63.Size = New-Object Drawing.Point 270,25; 
echo $chck63.Text = 'Scan for Adware ^(AdwCleaner^)'; 
echo $chck63.TabIndex = 62; 
echo $chck63.Checked = $false; 
echo $form.controls.add^($chck63^); 

echo $groupBox1 = New-Object System.Windows.Forms.GroupBox
echo $groupBox1.Location = '10,30' 
echo $groupBox1.size = '570,405'
echo $groupBox1.text = 'Performance Tweaks'
echo $groupBox1.Visible = $true
echo $groupBox1.Font = New-Object System.Drawing.Font^('Consolas',11,[System.Drawing.FontStyle]::Bold^); 
echo $groupBox1.ForeColor = [System.Drawing.ColorTranslator]::FromHtml^('#eeeeee'^)
echo $form.Controls.Add^($groupBox1^) 

echo $groupBox2 = New-Object System.Windows.Forms.GroupBox
echo $groupBox2.Location = '585,30' 
echo $groupBox2.size = '285,455'
echo $groupBox2.text = 'Privacy'
echo $groupBox2.Visible = $true
echo $groupBox2.Font = New-Object System.Drawing.Font^('Consolas',11,[System.Drawing.FontStyle]::Bold^); 
echo $groupBox2.ForeColor = [System.Drawing.ColorTranslator]::FromHtml^('#eeeeee'^)
echo $form.Controls.Add^($groupBox2^) 

echo $groupBox3 = New-Object System.Windows.Forms.GroupBox
echo $groupBox3.Location = '10,435' 
echo $groupBox3.size = '285,180'
echo $groupBox3.text = 'Visual Tweaks'
echo $groupBox3.Visible = $true
echo $groupBox3.Font = New-Object System.Drawing.Font^('Consolas',11,[System.Drawing.FontStyle]::Bold^); 
echo $groupBox3.ForeColor = [System.Drawing.ColorTranslator]::FromHtml^('#eeeeee'^)
echo $form.Controls.Add^($groupBox3^) 

echo function About {
echo $aboutForm = New-Object System.Windows.Forms.Form; 
echo $aboutFormExit = New-Object System.Windows.Forms.Button; 
echo $aboutFormNameLabel = New-Object System.Windows.Forms.Label; 
echo $aboutFormText = New-Object System.Windows.Forms.Label; 
echo $aboutFormText2 = New-Object System.Windows.Forms.Label; 
echo $aboutForm.MinimizeBox = $false; 
echo $aboutForm.MaximizeBox = $false; 
echo $aboutForm.TopMost = $true; 
echo $aboutForm.FlatStyle = 'Flat'
echo $aboutForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml^('#252525'^)
echo $aboutForm.ForeColor = [System.Drawing.ColorTranslator]::FromHtml^('#eeeeee'^)
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
echo $aboutFormNameLabel.Font = New-Object Drawing.Font^('Consolas', 9, [System.Drawing.FontStyle]::Bold^); 
echo $aboutFormNameLabel.Location = '110, 10'; 
echo $aboutFormNameLabel.Size = '200, 18'; 
echo $aboutFormNameLabel.Text = '  E.T. All in One'; 
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
echo $aboutFormExit.FlatStyle = 'Flat'
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
echo $extraFormB11 = New-Object System.Windows.Forms.Button; 
echo $extraForm.MinimizeBox = $false; 
echo $extraForm.MaximizeBox = $false; 
echo $extraForm.TopMost = $true; 
echo $extraForm.AutoSizeMode = 'GrowAndShrink'; 
echo $extraForm.FormBorderStyle = 'FixedDialog'; 
echo $extraForm.AcceptButton = $extraFormExit; 
echo $extraForm.CancelButton = $extraFormExit; 
echo $extraForm.ClientSize = '200, 360'; 
echo $extraForm.ShowInTaskBar = $false; 
echo $extraForm.FlatStyle = 'Flat'
echo $extraForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml^('#252525'^)
echo $extraForm.ForeColor = [System.Drawing.ColorTranslator]::FromHtml^('#eeeeee'^)

echo $extraForm.Location = ^(30,30^);
echo $extraForm.Text = 'Extras'; 
echo $extraForm.Font = $font;

echo $extraFormB1.Location = '25, 15'; 
echo $extraFormB1.Size = New-Object Drawing.Point 150,25;
echo $extraFormB1.Text = 'Disk Defragmenter'; 
echo $extraFormB1.add_click^({dfrgui.exe}^);
echo $extraFormB1.FlatStyle = 'Flat'
echo $extraForm.Controls.Add^($extraFormB1^); 
echo $extraFormB1.add_MouseHover^({
echo $tooltipEB1 = New-Object System.Windows.Forms.ToolTip
echo $tooltipEB1.SetToolTip^($extraFormB1, 'Optimize your drives to help your computer run more efficienlty.'^)
echo }^)

echo $extraFormB2.Location = '25, 45'; 
echo $extraFormB2.Size = New-Object Drawing.Point 150,25;
echo $extraFormB2.Text = 'Cleanmgr'; 
echo $extraFormB2.add_click^({cleanmgr.exe}^);
echo $extraFormB2.FlatStyle = 'Flat'
echo $extraForm.Controls.Add^($extraFormB2^); 
echo $extraFormB2.add_MouseHover^({
echo $tooltipEB2 = New-Object System.Windows.Forms.ToolTip
echo $tooltipEB2.SetToolTip^($extraFormB2, 'Clears unnecessary files from your computer hard disk.'^)
echo }^)

echo $extraFormB3.Location = '25, 75'; 
echo $extraFormB3.Size = New-Object Drawing.Point 150,25;
echo $extraFormB3.Text = 'Msconfig'; 
echo $extraFormB3.add_click^({msconfig}^);
echo $extraFormB3.FlatStyle = 'Flat'
echo $extraForm.Controls.Add^($extraFormB3^); 
echo $extraFormB3.add_MouseHover^({
echo $tooltipEB3 = New-Object System.Windows.Forms.ToolTip
echo $tooltipEB3.SetToolTip^($extraFormB3, 'Utility designed to troubleshoot and configure Windows startup process.'^)
echo }^)

echo $extraFormB4.Location = '25, 105'; 
echo $extraFormB4.Size = New-Object Drawing.Point 150,25;
echo $extraFormB4.Text = 'Control Panel'; 
echo $extraFormB4.add_click^({control.exe}^);
echo $extraFormB4.FlatStyle = 'Flat'
echo $extraForm.Controls.Add^($extraFormB4^); 

echo $extraFormB5.Location = '25, 135'; 
echo $extraFormB5.Size = New-Object Drawing.Point 150,25;
echo $extraFormB5.Text = 'Device Manager'; 
echo $extraFormB5.add_click^({devmgmt.msc}^);
echo $extraFormB5.FlatStyle = 'Flat'
echo $extraForm.Controls.Add^($extraFormB5^); 

echo $extraFormB6.Location = '25, 165'; 
echo $extraFormB6.Size = New-Object Drawing.Point 150,25;
echo $extraFormB6.Text = 'UAC Settings'; 
echo $extraFormB6.add_click^({UserAccountControlSettings.exe}^);
echo $extraFormB6.FlatStyle = 'Flat'
echo $extraForm.Controls.Add^($extraFormB6^); 

echo $extraFormB7.Location = '25, 195'; 
echo $extraFormB7.Size = New-Object Drawing.Point 150,25;
echo $extraFormB7.Text = 'Msinfo32'; 
echo $extraFormB7.add_click^({msinfo32}^);
echo $extraFormB7.FlatStyle = 'Flat'
echo $extraForm.Controls.Add^($extraFormB7^); 
echo $extraFormB7.add_MouseHover^({
echo $tooltipEB7 = New-Object System.Windows.Forms.ToolTip
echo $tooltipEB7.SetToolTip^($extraFormB7, 'This tool gathers information about your computer.'^)
echo }^)

echo $extraFormB8.Location = '25, 225'; 
echo $extraFormB8.Size = New-Object Drawing.Point 150,25;
echo $extraFormB8.Text = 'Services'; 
echo $extraFormB8.add_click^({services.msc}^);
echo $extraFormB8.FlatStyle = 'Flat'
echo $extraForm.Controls.Add^($extraFormB8^); 

echo $extraFormB9.Location = '25, 255'; 
echo $extraFormB9.Size = New-Object Drawing.Point 150,25;
echo $extraFormB9.Text = 'Remote Desktop'; 
echo $extraFormB9.add_click^({mstsc}^);
echo $extraFormB9.FlatStyle = 'Flat'
echo $extraForm.Controls.Add^($extraFormB9^); 

echo $extraFormB10.Location = '25, 285'; 
echo $extraFormB10.Size = New-Object Drawing.Point 150,25;
echo $extraFormB10.Text = 'Event Viewer'; 
echo $extraFormB10.add_click^({eventvwr.msc}^);
echo $extraFormB10.FlatStyle = 'Flat'
echo $extraForm.Controls.Add^($extraFormB10^); 

echo $extraFormB11.Location = '25, 315'; 
echo $extraFormB11.Size = New-Object Drawing.Point 150,25;
echo $extraFormB11.Text = 'Reset Network'; 
echo $extraFormB11.add_click^({start %programdata%\restart-network-settings.bat}^);
echo $extraFormB11.FlatStyle = 'Flat'
echo $extraForm.Controls.Add^($extraFormB11^); 
echo $extraFormB11.add_MouseHover^({
echo $tooltipEB11 = New-Object System.Windows.Forms.ToolTip
echo $tooltipEB11.SetToolTip^($extraFormB11, 'This option will reset any internet settings on your device.'^)
echo }^)

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
echo [scriptblock]$donate= {start https://www.paypal.com/paypalme/rikey}; 
echo [scriptblock]$extras= {Extras}; 
echo ^(addMenuItem -ParentItem ^([ref]$mainMenu^) -ItemName 'mnuFile' -ItemText 'Backup' -ScriptBlock $backup^); 
echo ^(addMenuItem -ParentItem ^([ref]$mainMenu^) -ItemName 'mnuFile' -ItemText 'Restore' -ScriptBlock $restore^); 
echo ^(addMenuItem -ParentItem ^([ref]$mainMenu^) -ItemName 'mnuFile' -ItemText 'Extras' -ScriptBlock $extras^);
echo ^(addMenuItem -ParentItem ^([ref]$mainMenu^) -ItemName 'mnuFile' -ItemText 'About' -ScriptBlock $about^);  
echo ^(addMenuItem -ParentItem ^([ref]$mainMenu^) -ItemName 'mnuFile' -ItemText 'Donate' -ScriptBlock $donate^);  
echo ^(addMenuItem -ParentItem ^([ref]$mainMenu^) -ItemName 'mnuFile' -ItemText 'Exit' -ScriptBlock $exit^); 
echo $form.ShowDialog^(^);
)>%programdata%\GUI.ps1

:: Restart Network Settings Module (Extras)
echo netsh winsock reset > %programdata%\restart-network-settings.bat
echo netsh int ipv4 reset >> %programdata%\restart-network-settings.bat
echo netsh int ipv6 reset >> %programdata%\restart-network-settings.bat
echo ipconfig /release >> %programdata%\restart-network-settings.bat
echo ipconfig /renew >> %programdata%\restart-network-settings.bat
echo ipconfig /flushdns >> %programdata%\restart-network-settings.bat

echo for /f "tokens=3,*" %%i in ('netsh int show interface^|find "Connected"') do ( >> %programdata%\restart-network-settings.bat
echo	netsh int set interface name="%%j" admin="disabled" >> %programdata%\restart-network-settings.bat
echo	netsh int set interface name="%%j" admin="enabled" >> %programdata%\restart-network-settings.bat
echo ) >> %programdata%\restart-network-settings.bat

:: Force PS authorization for scripts
Powershell -Command "set-executionpolicy remotesigned"
cls
echo Selection window has been initiated
Powershell -Command "%programdata%\GUI.ps1 %version%" >nul 2>nul

:: Cleaning GUI windows form file after usage
if exist GUI.ps1 del GUI.ps1 /F /Q>nul 2>nul
if exist %programdata%\GUI.ps1 del %programdata%\GUI.ps1 /F /Q>nul 2>nul

:: Cleaning Restart Network Settings Module file after usage
if exist restart-network-settings.bat del restart-network-settings.bat /F /Q>nul 2>nul
if exist %programdata%\restart-network-settings.bat del %programdata%\restart-network-settings.bat /F /Q>nul 2>nul

if not exist %programdata%\ET\*.lbool exit.
:: if not chosen any option = no .lbool files in programdata = exit

:: counting amount to do value
dir /a:-d /s /b "%programdata%\ET" | find /c ":" > %programdata%\todo.lbool
set /p alltodo=<%programdata%\todo.lbool
if exist %programdata%\todo.lbool del %programdata%\todo.lbool >nul 2>nul

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
cls
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

::menu loop checking for every checkbox and go to goto func
for /l %%x in (1, 1, 63) do (
if exist %programdata%\ET\chck%%x.lbool goto chck%%x
)

goto Done

:VisualTweaks

:chck48
if exist %programdata%\ET\chck48.lbool del %programdata%\ET\chck48.lbool
:: Show file extensions in Explorer
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Show file extensions in Explorer ' -F blue -B black"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t  REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck49
if exist %programdata%\ET\chck49.lbool del %programdata%\ET\chck49.lbool
:: Disable Transparency in taskbar, menu start etc
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Disable Transparency in taskbar/menu start ' -F blue -B black"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck50
if exist %programdata%\ET\chck50.lbool del %programdata%\ET\chck50.lbool
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
goto Start

:chck51
if exist %programdata%\ET\chck51.lbool del %programdata%\ET\chck51.lbool
:: Disable MRU lists (jump lists) of XAML apps in Start Menu
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul 
powershell -Command "Write-Host ' [Disable] MRU lists (jump lists) of XAML apps in Start Menu ' -F darkgray -B black"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck52
if exist %programdata%\ET\chck52.lbool del %programdata%\ET\chck52.lbool
::  Hide the search box from taskbar. You can still search by pressing the Win key and start typing what you're looking for 
:: 0 = hide completely, 1 = show only icon, 2 = show long search box
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Hide the search box from taskbar. ' -F blue -B black"
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f >nul 2>nul
goto Start

:chck53
if exist %programdata%\ET\chck53.lbool del %programdata%\ET\chck53.lbool
:: Windows Explorer to start on This PC instead of Quick Access 
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Windows Explorer to start on This PC instead of Quick Access ' -F blue -B black" 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul 2>nul
goto Start

:PerformanceTweaks

:chck1
if exist %programdata%\ET\chck1.lbool del %programdata%\ET\chck1.lbool
::  Disable Edge WebWidget
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Edge WebWidget ' -F darkgray -B black"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v WebWidgetAllowed /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck2
if exist %programdata%\ET\chck2.lbool del %programdata%\ET\chck2.lbool
::  Setting power option to high for best performance
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Power option to high for best performance ' -F blue -B black"
powercfg -setactive scheme_min
goto Start

:chck3
if exist %programdata%\ET\chck3.lbool del %programdata%\ET\chck3.lbool
::  Enable All (Logical) Cores (Boot Advanced Options)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Enable All (Logical) Cores (Boot Advanced Options) ' -F blue -B black"
wmic cpu get NumberOfLogicalProcessors | findstr /r "[0-9]" > NumLogicalCores.txt
set /P NOLP=<NumLogicalCores.txt
bcdedit /set {current} numproc %NOLP% >nul 2>nul
if exist NumLogicalCores.txt del NumLogicalCores.txt
goto Start

:chck4
if exist %programdata%\ET\chck4.lbool del %programdata%\ET\chck4.lbool
:: Dual boot timeout 3sec
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Dual boot timeout 3sec ' -F blue -B black"
bcdedit /set timeout 3 >nul 2>nul
goto Start

:chck5
if exist %programdata%\ET\chck5.lbool del %programdata%\ET\chck5.lbool
:: Disable Hibernation/Fast startup in Windows to free RAM from "C:\hiberfil.sys"
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Hibernation/Fast startup in Windows ' -F darkgray -B black"
powercfg -hibernate off >nul 2>nul
goto Start

:chck6
if exist %programdata%\ET\chck6.lbool del %programdata%\ET\chck6.lbool
:: Disable windows insider experiments
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Windows Insider experiments ' -F darkgray -B black"
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f >nul 2>nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t "REG_DWORD" /d "0" /f >nul 2>nul
goto Start

:chck7
if exist %programdata%\ET\chck7.lbool del %programdata%\ET\chck7.lbool
:: Disable app launch tracking
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] App launch tracking ' -F darkgray -B black"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /d "0" /t REG_DWORD /f >nul 2>nul
goto Start

:chck8
if exist %programdata%\ET\chck8.lbool del %programdata%\ET\chck8.lbool
:: Disable powerthrottling (Intel 6gen and higher)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Powerthrottling (Intel 6gen and higher) ' -F darkgray -B black"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f >nul 2>nul
goto Start

:chck9
if exist %programdata%\ET\chck9.lbool del %programdata%\ET\chck9.lbool
:: Turn Off Background Apps
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Turn Off Background Apps ' -F blue -B black"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled  /t REG_DWORD /d 1 /f >nul 2>nul
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v BackgroundAppGlobalToggle /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck10
if exist %programdata%\ET\chck10.lbool del %programdata%\ET\chck10.lbool
:: Disable Sticky Keys prompt
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Sticky Keys prompt ' -F darkgray -B black"
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d 506 /f >nul 2>nul
goto Start

:chck11
if exist %programdata%\ET\chck11.lbool del %programdata%\ET\chck11.lbool
:: Disable Activity History
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Activity History ' -F darkgray -B black"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck12
if exist %programdata%\ET\chck12.lbool del %programdata%\ET\chck12.lbool
:: Disable Automatic Updates for Microsoft Store apps
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Automatic Updates for Microsoft Store apps ' -F darkgray -B black"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul 2>nul
goto Start

:chck13
if exist %programdata%\ET\chck13.lbool del %programdata%\ET\chck13.lbool
::  SmartScreen Filter for Store Apps: Disable
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] SmartScreen Filter for Store Apps ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck14
if exist %programdata%\ET\chck14.lbool del %programdata%\ET\chck14.lbool
::  Let websites provide locally...
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Let websites provide locally ' -F blue -B black"
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f >nul 2>nul
goto Start

:chck15
if exist %programdata%\ET\chck15.lbool del %programdata%\ET\chck15.lbool
::  Microsoft Edge settings
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Microsoft Edge settings for privacy ' -F blue -B black"
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v DoNotTrack /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\User\Default\SearchScopes" /v ShowSearchSuggestionsGlobal /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\FlipAhead" /v FPEnabled /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck16
if exist %programdata%\ET\chck16.lbool del %programdata%\ET\chck16.lbool
::  Disable location sensor
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Location sensor ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v SensorPermissionState /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck17
if exist %programdata%\ET\chck17.lbool del %programdata%\ET\chck17.lbool
:: WiFi Sense: HotSpot Sharing: Disable
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] WiFi Sense: HotSpot Sharing ' -F darkgray -B black"
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v value /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck18
if exist %programdata%\ET\chck18.lbool del %programdata%\ET\chck18.lbool
:: WiFi Sense: Shared HotSpot Auto-Connect: Disable
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] WiFi Sense: Shared HotSpot Auto-Connect ' -F darkgray -B black"
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v value /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck19
if exist %programdata%\ET\chck19.lbool del %programdata%\ET\chck19.lbool
:: Change Windows Updates to "Notify to schedule restart"
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Windows Updates to Notify to schedule restart ' -F blue -B black"
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v UxOption /t REG_DWORD /d 1 /f >nul 2>nul
goto Start

:chck20
if exist %programdata%\ET\chck20.lbool del %programdata%\ET\chck20.lbool
:: Disable P2P Update downloads outside of local network
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] P2P Update downloads outside of local network ' -F darkgray -B black"
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck21
if exist %programdata%\ET\chck21.lbool del %programdata%\ET\chck21.lbool
:: Setting Lower Shutdown time
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Lower Shutdown time ' -F blue -B black"
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d 2000 /f >nul 2>nul
goto Start

:chck22
if exist %programdata%\ET\chck22.lbool del %programdata%\ET\chck22.lbool
:: Remove Old Device Drivers
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Remove] Old Device Drivers ' -F red -B black"
SET DEVMGR_SHOW_NONPRESENT_DEVICES=1
goto Start

:chck23
if exist %programdata%\ET\chck23.lbool del %programdata%\ET\chck23.lbool
:: Disable Get Even More Out of Windows Screen /W10
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Get Even More Out of Windows Screen ' -F darkgray -B black"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314559Enabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314563Enabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck24
if exist %programdata%\ET\chck24.lbool del %programdata%\ET\chck24.lbool
:: Disable automatically installing suggested apps /W10
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Automatically installing suggested apps ' -F darkgray -B black"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "FeatureManagementEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContentEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck25
if exist %programdata%\ET\chck25.lbool del %programdata%\ET\chck25.lbool
:: Disable Start Menu Ads/Suggestions /W10
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Start Menu Ads/Suggestions ' -F darkgray -B black"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck26
if exist %programdata%\ET\chck26.lbool del %programdata%\ET\chck26.lbool
:: Disable Allowing Suggested Apps In WindowsInk Workspace
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Allowing Suggested Apps In WindowsInk Workspace ' -F darkgray -B black"
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WindowsInkWorkspace\AllowSuggestedAppsInWindowsInkWorkspace" /v "value" /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck27
if exist %programdata%\ET\chck27.lbool del %programdata%\ET\chck27.lbool
:: Disables several unnecessary components
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Unnecessary components ' -F darkgray -B black"
set components=Printing-PrintToPDFServices-Features Printing-XPSServices-Features Xps-Foundation-Xps-Viewer
(for %%a in (%components%) do ( 
   PowerShell -Command " disable-windowsoptionalfeature -online -featureName %%a -NoRestart " >nul 2>nul
))
goto Start

:chck28
if exist %programdata%\ET\chck28.lbool del %programdata%\ET\chck28.lbool
:: Setting Windows Defender Scheduled Scan from highest to normal privileges (CPU % high usage)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Windows Defender Scheduled Scan from highest to normal privileges ' -F blue -B black"
schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /RL LIMITED >nul 2>nul
goto Start

:chck29
if exist %programdata%\ET\chck29.lbool del %programdata%\ET\chck29.lbool
::  Disabling Process Mitigation
:: Audit exploit mitigations for increased process security or for converting existing Enhanced Mitigation Experience Toolkit
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Process Mitigation ' -F darkgray -B black"
powershell.exe -command "Set-ProcessMitigation -System -Disable CFG"
for /f "tokens=3 skip=2" %%i in ('reg query "HKLM\System\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions"') do set mitigation_mask=%%i
for /l %%i in (0,1,9) do set mitigation_mask=!mitigation_mask:%%i=2!
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationOptions" /t REG_BINARY /d "!mitigation_mask!" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions" /t REG_BINARY /d "!mitigation_mask!" /f >nul 2>&1
goto Start

:chck30
if exist %programdata%\ET\chck30.lbool del %programdata%\ET\chck30.lbool
:: Defragmenting the File Indexing Service database file
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Defragment Database Indexing Service File ' -F blue -B black" 
net stop wsearch /y >nul 2>nul
esentutl /d C:\ProgramData\Microsoft\Search\Data\Applications\Windows\Windows.edb >nul 2>nul
net start wsearch >nul 2>nul
goto Start

:Telemetry

:chck31
if exist %programdata%\ET\chck31.lbool del %programdata%\ET\chck31.lbool
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
schtasks /Change /TN "CCleaner Update" /Disable >nul 2>nul
schtasks /Change /TN "CCleanerSkipUAC - %username%" /Disable >nul 2>nul
schtasks /Change /TN "Adobe Acrobat Update Task" /Disable >nul 2>nul
schtasks /Change /TN "AMDLinkUpdate" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Office\Office Automatic Updates 2.0" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Office\Office Feature Updates" /Disable >nul 2>nul
schtasks /Change /TN "Microsoft\Office\Office Feature Updates Logon" /Disable >nul 2>nul
schtasks /Change /TN "GoogleUpdateTaskMachineCore" /Disable >nul 2>nul
schtasks /Change /TN "GoogleUpdateTaskMachineUA" /Disable >nul 2>nul
goto Start

:chck32
if exist %programdata%\ET\chck32.lbool del %programdata%\ET\chck32.lbool
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
goto Start

:chck33
if exist %programdata%\ET\chck33.lbool del %programdata%\ET\chck33.lbool
:: Disable PowerShell Telemetry
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] PowerShell Telemetry ' -F darkgray -B black"
setx POWERSHELL_TELEMETRY_OPTOUT 1 >nul 2>nul
goto Start

:chck34
if exist %programdata%\ET\chck34.lbool del %programdata%\ET\chck34.lbool
:: Disable Skype Telemetry
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Skype Telemetry ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW" /v "TraceLevelThreshold" /t REG_DWORD /d "0" /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype" /v "EnableTracing" /t REG_DWORD /d "0" /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW" /v "EnableTracing" /t REG_DWORD /d "0" /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype" /v "WPPFilePath" /t REG_SZ /d "%%SYSTEMDRIVE%%\TEMP\Tracing\WPPMedia" /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW" /v "WPPFilePath" /t REG_SZ /d "%%SYSTEMDRIVE%%\TEMP\WPPMedia" /f >nul 2>nul
goto Start

:chck35
if exist %programdata%\ET\chck35.lbool del %programdata%\ET\chck35.lbool
:: Disable windows media player usage reports
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Windows media player usage reports ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d "0" /f >nul 2>nul
goto Start

:chck36
if exist %programdata%\ET\chck36.lbool del %programdata%\ET\chck36.lbool
:: Disable mozilla telemetry
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Mozilla telemetry ' -F darkgray -B black"
reg add HKLM\SOFTWARE\Policies\Mozilla\Firefox /v "DisableTelemetry" /t REG_DWORD /d "2" /f >nul 2>nul
goto Start

:chck37
if exist %programdata%\ET\chck37.lbool del %programdata%\ET\chck37.lbool
:: Settings -> Privacy -> General -> Let apps use my advertising ID...
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Let apps use my advertising ID ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck38
if exist %programdata%\ET\chck38.lbool del %programdata%\ET\chck38.lbool
::  Send Microsoft info about how I write to help us improve typing and writing in the future
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Send Microsoft info about how I write ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck39
if exist %programdata%\ET\chck39.lbool del %programdata%\ET\chck39.lbool
::  Handwriting recognition personalization
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Handwriting recognition personalization ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f >nul 2>nul
goto Start

:chck40
if exist %programdata%\ET\chck40.lbool del %programdata%\ET\chck40.lbool
:: Disable watson malware reports
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Watson malware reports ' -F darkgray -B black"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "DisableGenericReports" /t REG_DWORD /d "2" /f >nul 2>nul
goto Start

:chck41
if exist %programdata%\ET\chck41.lbool del %programdata%\ET\chck41.lbool
:: Disable malware diagnostic data 
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Malware diagnostic data ' -F darkgray -B black" 
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d "2" /f >nul 2>nul
goto Start

:chck42
if exist %programdata%\ET\chck42.lbool del %programdata%\ET\chck42.lbool
:: Disable  setting override for reporting to Microsoft MAPS
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Setting override for reporting to Microsoft MAPS ' -F darkgray -B black"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "LocalSettingOverrideSpynetReporting" /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck43
if exist %programdata%\ET\chck43.lbool del %programdata%\ET\chck43.lbool
:: Disable spynet Defender reporting
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Spynet Defender reporting ' -F darkgray -B black"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck44
if exist %programdata%\ET\chck44.lbool del %programdata%\ET\chck44.lbool
:: Do not send malware samples for further analysis
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Do not send malware samples for further analysis ' -F blue -B black"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "2" /f >nul 2>nul
goto Start

:chck45
if exist %programdata%\ET\chck45.lbool del %programdata%\ET\chck45.lbool
::  Prevents sending speech, inking and typing samples to MS (so Cortana can learn to recognise you)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Sending speech, inking and typing samples to MS ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck46
if exist %programdata%\ET\chck46.lbool del %programdata%\ET\chck46.lbool
::  Prevents sending contacts to MS (so Cortana can compare speech etc samples)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Sending contacts to MS ' -F darkgray -B black"
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v HarvestContacts /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:chck47
if exist %programdata%\ET\chck47.lbool del %programdata%\ET\chck47.lbool
::  Immobilise Cortana 
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Cortana ' -F darkgray -B black"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:WindowsGameBar

:chck54
if exist %programdata%\ET\chck54.lbool del %programdata%\ET\chck54.lbool
:: Removing Windows Game Bar 
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul 2>nul
powershell -Command "Write-Host ' [Remove] Windows Game Bar ' -F red -B black"
PowerShell -Command "Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *XboxGameOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage"
goto Start

:RemoveWidgets

:chck59
if exist %programdata%\ET\chck59.lbool del %programdata%\ET\chck59.lbool
:: Remove News and Interests/Widgets from Win 11 (even if not shown on taskbar, that takes RAM/CPU running in background)
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Remove] News and Interests/Widgets' -F red -B black"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul 2>nul

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul 2>nul
winget uninstall "windows web experience pack" --accept-source-agreements >nul 2>nul
goto Start

:Services

:chck55
if exist %programdata%\ET\chck55.lbool del %programdata%\ET\chck55.lbool
:: Disable
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Services to: Disable Mode ' -F blue -B black"
set toDisable=DiagTrack diagnosticshub.standardcollector.service dmwappushservice RemoteRegistry RemoteAccess SCardSvr SCPolicySvc fax WerSvc NvTelemetryContainer gadjservice AdobeARMservice PSI_SVC_2 lfsvc WalletService RetailDemo SEMgrSvc diagsvc AJRouter
(for %%a in (%toDisable%) do ( 
   sc stop %%a >nul 2>nul
   sc config %%a start= disabled  >nul 2>nul
))

:: Manuall
powershell -Command "Write-Host ' [Setting] Services to: Manuall Mode ' -F blue -B black"
set toManuall=BITS SamSs TapiSrv seclogon wuauserv PhoneSvc lmhosts iphlpsvc gupdate gupdatem edgeupdate edgeupdatem MapsBroker PnkBstrA brave bravem asus asusm adobeupdateservice adobeflashplayerupdatesvc WSearch
(for %%a in (%toManuall%) do ( 
   sc config %%a start= demand >nul 2>nul
))
goto Start

:Bloatware

:chck56
if exist %programdata%\ET\chck56.lbool del %programdata%\ET\chck56.lbool
:: Remove Bloatware Apps (Preinstalled) 69 apps
powershell -Command "Write-Host ' [Remove] Bloatware Apps ' -F red -B black"

set listofbloatware=3DBuilder Automate Appconnector Microsoft3DViewer MicrosoftPowerBIForWindows MicrosoftPowerBIForWindows Print3D XboxApp GetHelp WindowsFeedbackHub BingFoodAndDrink BingHealthAndFitness BingTravel WindowsReadingList MixedReality.Portal ScreenSketch YourPhone PicsArt-PhotoStudio EclipseManager PolarrPhotoEditorAcademicEdition Wunderlist LinkedInforWindows AutodeskSketchBook Twitter DisneyMagicKingdoms MarchofEmpires ActiproSoftwareLLC Plex iHeartRadio FarmVille2CountryEscape Duolingo CyberLinkMediaSuiteEssentials DolbyAccess DrawboardPDF FitbitCoach Flipboard Asphalt8Airborne Keeper BingNews COOKINGFEVER PandoraMediaInc CaesarsSlotsFreeCasino Shazam PhototasticCollage TuneInRadio WinZipUniversal XING RoyalRevolt2 CandyCrushSodaSaga BubbleWitch3Saga CandyCrushSaga Getstarted bing MicrosoftOfficeHub OneNote WindowsPhone SkypeApp windowscommunicationsapps WindowsMaps Sway CommsPhone ConnectivityStore Hotspot Sketchable Clipchamp Prime TikTok ToDo Family NewVoiceNote SamsungNotes SamsungFlux StudioPlus SamsungWelcome SamsungQuickSearch SamsungPCCleaner SamsungCloudBluetoothSync PCGallery OnlineSupportSService 
(for %%a in (%listofbloatware%) do ( 
	set /a insidecount+=1 >nul 2>nul
	title %version% [%counter%/%alltodo%] [!insidecount!/79]
   PowerShell -Command "Get-AppxPackage -allusers *%%a* | Remove-AppxPackage"
))

set /a counter+=1 >nul 2>nul
goto Start

:StartUp

:chck57
if exist %programdata%\ET\chck57.lbool del %programdata%\ET\chck57.lbool
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

goto Start

:Cleaning

:chck58
if exist %programdata%\ET\chck58.lbool del %programdata%\ET\chck58.lbool
::  TEMP/Logs/Cache/Prefetch/Updates Cleaning
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Clean] Temp ' -F yellow -B black"
powershell -Command "Get-ChildItem -Path $env:TEMP -Include *.* -Exclude *.bat, *.lbool -File -Recurse | foreach { $_.Delete()}" >nul 2>nul
Del /S /F /Q %Windir%\Temp >nul 2>nul

powershell -Command "Write-Host ' [Clean] Windows Prefetch/Cache/Logs ' -F yellow -B black"
Del /S /F /Q %windir%\Prefetch >nul 2>nul

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

del %localappdata%\Yarn\Cache /F /Q /S >nul 2>nul

del %appdata%\Microsoft\Teams\Cache /F /Q /S >nul 2>nul

del %programdata%\GOG.com\Galaxy\webcache /F /Q /S >nul 2>nul
del %programdata%\GOG.com\Galaxy\logs /F /Q /S >nul 2>nul

del %localappdata%\Microsoft\Windows\WebCache /F /Q /S >nul 2>nul

del "%SystemDrive%\*.log" /F /Q >nul 2>nul
del "%WinDir%\Directx.log" /F /Q >nul 2>nul
del "%WinDir%\SchedLgU.txt" /F /Q >nul 2>nul
del "%WinDir%\*.log" /F /Q >nul 2>nul
del "%WinDir%\security\logs\*.old" /F /Q >nul 2>nul
del "%WinDir%\security\logs\*.log" /F /Q >nul 2>nul
del "%WinDir%\Debug\*.log" /F /Q >nul 2>nul
del "%WinDir%\Debug\UserMode\*.bak" /F /Q >nul 2>nul
del "%WinDir%\Debug\UserMode\*.log" /F /Q >nul 2>nul
del "%WinDir%\*.bak" /F /Q >nul 2>nul
del "%WinDir%\system32\wbem\Logs\*.log" /F /Q >nul 2>nul
del "%WinDir%\OEWABLog.txt" /F /Q >nul 2>nul
del "%WinDir%\setuplog.txt" /F /Q >nul 2>nul
del "%WinDir%\Logs\DISM\*.log" /F /Q >nul 2>nul
del "%WinDir%\*.log.txt" /F /Q >nul 2>nul
del "%WinDir%\APPLOG\*.*" /F /Q >nul 2>nul
del "%WinDir%\system32\wbem\Logs\*.log" /F /Q >nul 2>nul
del "%WinDir%\system32\wbem\Logs\*.lo_" /F /Q >nul 2>nul
del "%WinDir%\Logs\DPX\*.log" /F /Q >nul 2>nul
del "%WinDir%\ServiceProfiles\NetworkService\AppData\Local\Temp\*.log" /F /Q >nul 2>nul
del "%WinDir%\Logs\*.log" /F /Q >nul 2>nul
del "%LocalAppData%\Microsoft\Windows\WindowsUpdate.log" /F /Q >nul 2>nul
del "%LocalAppData%\Microsoft\Windows\WebCache\*.log" /F /Q >nul 2>nul
del "%WinDir%\Panther\cbs.log" /F /Q >nul 2>nul
del "%WinDir%\Panther\DDACLSys.log" /F /Q >nul 2>nul
del "%WinDir%\repair\setup.log" /F /Q >nul 2>nul
del "%WinDir%\Panther\UnattendGC\diagerr.xml" /F /Q >nul 2>nul
del "%WinDir%\Panther\UnattendGC\diagwrn.xml" /F /Q >nul 2>nul
del "%WinDir%\inf\setupapi.offline.log" /F /Q >nul 2>nul
del "%WinDir%\inf\setupapi.app.log" /F /Q >nul 2>nul
del "%WinDir%\debug\WIA\*.log" /F /Q >nul 2>nul
del "%SystemDrive%\PerfLogs\System\Diagnostics\*.*" /F /Q >nul 2>nul
del "%WinDir%\Logs\CBS\*.cab" /F /Q >nul 2>nul
del "%WinDir%\Logs\CBS\*.cab" /F /Q >nul 2>nul
del "%WinDir%\Logs\WindowsBackup\*.etl" /F /Q >nul 2>nul
del "%WinDir%\System32\LogFiles\HTTPERR\*.*" /F /Q >nul 2>nul
del "%WinDir%\SysNative\SleepStudy\*.etl" /F /Q >nul 2>nul
del "%WinDir%\SysNative\SleepStudy\ScreenOn\*.etl" /F /Q >nul 2>nul
del "%WinDir%\System32\SleepStudy\*.etl" /F /Q >nul 2>nul
del "%WinDir%\System32\SleepStudy\ScreenOn\*.etl" /F /Q >nul 2>nul
del "%WinDir%\Logs" /F /Q >nul 2>nul
del "%WinDir%\DISM" /F /Q >nul 2>nul
del "%WinDir%\System32\catroot2\*.chk" /F /Q >nul 2>nul
del "%WinDir%\System32\catroot2\*.log" /F /Q >nul 2>nul
del "%WinDir%\System32\catroot2\.jrs" /F /Q >nul 2>nul
del "%WinDir%\System32\catroot2\*.txt" /F /Q >nul 2>nul

:: Cleaning Disk - cleanmgr
start cleanmgr.exe /autoclean

:: Cleaning Disk - CCleaner
if not exist "%programfiles%\CCleaner\CCleaner.exe" goto NoCC
if not exist "%programfiles%\CCleaner\CCleaner64.exe" goto NoCC
start CCleaner.exe /AUTO

:NoCC

powershell -Command "Write-Host ' [Clean] Games Platforms Cache/Logs ' -F yellow -B black"

del %localappdata%\EpicGamesLauncher\Saved\Logs /F /Q /S >nul 2>nul
del %localappdata%\CrashReportClient\Saved\Logs /F /Q /S >nul 2>nul

del "%localappdata%\Steam\htmlcache\Code Cache" /F /Q /S >nul 2>nul
del %localappdata%\Steam\htmlcache\GPUCache /F /Q /S >nul 2>nul
del %localappdata%\Steam\htmlcache\Cache /F /Q /S >nul 2>nul

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

powershell -Command "Write-Host ' [Clean] Web Browsers Cache/Logs ' -F yellow -B black"

del "%LocalAppData%\Google\Chrome\User Data\Default\Cache" /F /Q /S >nul 2>nul
del "%LocalAppData%\Google\Chrome\User Data\Default\Media Cache" /F /Q /S >nul 2>nul
del "%LocalAppData%\Google\Chrome\User Data\Default\GPUCache" /F /Q /S >nul 2>nul
del "%LocalAppData%\Google\Chrome\User Data\Default\Storage\ext" /F /Q /S >nul 2>nul
del "%LocalAppData%\Google\Chrome\User Data\Default\Service Worker" /F /Q /S >nul 2>nul
del "%LocalAppData%\Google\Chrome\User Data\ShaderCache" /F /Q /S >nul 2>nul


del "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache" /F /Q /S >nul 2>nul
del "%LocalAppData%\Microsoft\Edge\User Data\Default\Media Cache" /F /Q /S >nul 2>nul
del "%LocalAppData%\Microsoft\Edge\User Data\Default\GPUCache" /F /Q /S >nul 2>nul
del "%LocalAppData%\Microsoft\Edge\User Data\Default\Storage\ext" /F /Q /S >nul 2>nul
del "%LocalAppData%\Microsoft\Edge\User Data\Default\Service Worker" /F /Q /S >nul 2>nul
del "%LocalAppData%\Microsoft\Edge\User Data\ShaderCache" /F /Q /S >nul 2>nul
del "%LocalAppData%\Microsoft\Edge SxS\User Data\Default\Cache" /F /Q /S >nul 2>nul
del "%LocalAppData%\Microsoft\Edge SxS\User Data\Default\Media Cache" /F /Q /S >nul 2>nul
del "%LocalAppData%\Microsoft\Edge SxS\User Data\Default\GPUCache" /F /Q /S >nul 2>nul
del "%LocalAppData%\Microsoft\Edge SxS\User Data\Default\Storage\ext" /F /Q /S >nul 2>nul
del "%LocalAppData%\Microsoft\Edge SxS\User Data\Default\Service Worker" /F /Q /S >nul 2>nul
del "%LocalAppData%\Microsoft\Edge SxS\User Data\ShaderCache" /F /Q /S >nul 2>nul

del "%LocalAppData%\Opera Software\Opera Stable\cache" /F /Q /S >nul 2>nul
del "%AppData%\Opera Software\Opera Stable\GPUCache" /F /Q /S >nul 2>nul
del "%AppData%\Opera Software\Opera Stable\ShaderCache" /F /Q /S >nul 2>nul
del "%AppData%\Opera Software\Opera Stable\Jump List Icons" /F /Q /S >nul 2>nul
del "%AppData%\Opera Software\Opera Stable\Jump List IconsOld\Jump List Icons" /F /Q /S >nul 2>nul

del "%LocalAppData%\Vivaldi\User Data\Default\Cache" /F /Q /S >nul 2>nul

powershell -Command "Write-Host ' [Clean] Windows Defender Cache/Logs ' -F yellow -B black"

del "%ProgramData%\Microsoft\Windows Defender\Network Inspection System\Support\*.log" /F /Q /S >nul 2>nul
del "%ProgramData%\Microsoft\Windows Defender\Scans\History\CacheManager" /F /Q /S >nul 2>nul
del "%ProgramData%\Microsoft\Windows Defender\Scans\History\ReportLatency\Latency" /F /Q /S >nul 2>nul
del "%ProgramData%\Microsoft\Windows Defender\Scans\History\Service\*.log" /F /Q /S >nul 2>nul
del "%ProgramData%\Microsoft\Windows Defender\Scans\MetaStore" /F /Q /S >nul 2>nul
del "%ProgramData%\Microsoft\Windows Defender\Support" /F /Q /S >nul 2>nul
del "%ProgramData%\Microsoft\Windows Defender\Scans\History\Results\Quick" /F /Q /S >nul 2>nul
del "%ProgramData%\Microsoft\Windows Defender\Scans\History\Results\Resource" /F /Q /S >nul 2>nul

powershell -Command "Write-Host ' [Clean] Windows Font Cache ' -F yellow -B black"

net stop FontCache >nul 2>nul
net stop FontCache3.0.0.0 >nul 2>nul
del "%WinDir%\ServiceProfiles\LocalService\AppData\Local\FontCache\*.dat" /F /Q /S >nul 2>nul
del "%WinDir%\SysNative\FNTCACHE.DAT" /F /Q /S >nul 2>nul
del "%WinDir%\System32\FNTCACHE.DAT" /F /Q /S >nul 2>nul
net start FontCache >nul 2>nul
net start FontCache3.0.0.0 >nul 2>nul

powershell -Command "Write-Host ' [Clean] Windows Icon Cache ' -F yellow -B black"

%WinDir%\SysNative\ie4uinit.exe -show >nul 2>nul
%WinDir%\System32\ie4uinit.exe -show >nul 2>nul
del %LocalAppData%\IconCache.db /F /Q /S >nul 2>nul
del "%LocalAppData%\Microsoft\Windows\Explorer\iconcache_*.db" /F /Q /S >nul 2>nul
goto Start

:OneDrive

:chck60
if exist %programdata%\ET\chck60.lbool del %programdata%\ET\chck60.lbool
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Remove] Microsoft OneDrive ' -F red -B black"
taskkill /F /IM "OneDrive.exe" >nul 2>nul
%systemroot\SysWOW64\OneDriveSetup.exe /uninstall >nul 2>nul
%systemroot\System32\OneDriveSetup.exe /uninstall >nul 2>nul

PowerShell -Command "Get-AppxPackage -allusers *Microsoft.OneDriveSync* | Remove-AppxPackage"

rd "%UserProfile%\OneDrive" /Q /S 1>NUL 2>NUL
rd "%LocalAppData%\Microsoft\OneDrive" /Q /S 1>NUL 2>NUL
rd "%ProgramData%\Microsoft OneDrive" /Q /S 1>NUL 2>NUL
rd "%systemdrive%\OneDriveTemp" /Q /S 1>NUL 2>NUL

::Remove OneDrive leftovers in explorer left side panel
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>nul
goto Start

:XboxServices

:chck61
if exist %programdata%\ET\chck61.lbool del %programdata%\ET\chck61.lbool
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Disable] Xbox Services ' -F darkgray -B black"
sc config XblAuthManager start= disabled >nul 2>nul
sc config XboxNetApiSvc start= disabled >nul 2>nul
sc config XblGameSave start= disabled >nul 2>nul
goto Start

:DNSOne

:chck62
if exist %programdata%\ET\chck62.lbool del %programdata%\ET\chck62.lbool
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Setting] Fast/Secure DNS 1.1.1.1 ' -F blue -B black"
ipconfig /flushdns >nul 2>nul

:: Custom DNS can couse problems with connection mostly becouse of Internet Service Provider (blocking custom DNS)
:: or could not connect into website (extremely rare case)

netsh interface ipv4 add dnsservers "Ethernet" address=1.1.1.1 index=1 >nul 2>nul
netsh interface ipv4 add dnsservers "Ethernet" address=8.8.8.8 index=2 >nul 2>nul

netsh interface ipv4 add dnsservers "Wi-Fi" address=1.1.1.1 index=1 >nul 2>nul
netsh interface ipv4 add dnsservers "Wi-Fi" address=8.8.8.8 index=2 >nul 2>nul
goto Start

:AdwCleaner

:chck63
if exist %programdata%\ET\chck63.lbool del %programdata%\ET\chck63.lbool
title %version% [%counter%/%alltodo%] && set /a counter+=1 >nul 2>nul
powershell -Command "Write-Host ' [Scanning] AdwCleaner ' -F darkgreen -B black"
Powershell -Command "wget https://downloads.malwarebytes.com/file/adwcleaner -o %programdata%\adwcleaner.exe" >nul 2>nul
if exist %programdata%\adwcleaner.exe start /WAIT %programdata%\adwcleaner.exe /eula /clean /noreboot >nul 2>nul

del %programdata%\adwcleaner.exe >nul 2>nul

goto Start

:Done
del %programdata%\ET\*.lbool >nul 2>nul

echo ------------------------------------------------------------------------

set announcement=Everything has been done. Reboot is recommended.
echo  %announcement%
echo  Donate with PayPal button if you want :)
powershell (New-Object -ComObject Wscript.Shell).Popup("""%announcement%""",0,"""%version%""",0x40 + 4096) >nul 2>nul
exit
