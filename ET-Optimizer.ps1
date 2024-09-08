#Check for admin
param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($Elevated) {
        # tried to elevate, did not work, aborting
		#MsgBox information
		Add-Type -AssemblyName PresentationCore,PresentationFramework
		$msgBody = "Run the script as an Administrator or type command: Set-ExecutionPolicy RemoteSigned"
		$msgTitle = "E.T. Permission Error"
		$msgButton = 'OK'
		$msgImage = 'Error'
		$Result = [System.Windows.MessageBox]::Show($msgBody,$msgTitle,$msgButton,$msgImage)
    } else {
		if (Test-Path $Env:programdata\Run-ET.log) {
			Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
		} 
		else 
		{
		#Start-Process powershell.exe "set-executionpolicy remotesigned" -Verb RunAs 
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
		}
    }
    exit
}
elseif (!(Test-Path $Env:programdata\Run-ET.log))
{
    # speeds up powershell startup time by 10x
    Write-Host "Loading please wait..."
    Write-Host ""
    $env:path = "$([Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory());" + $env:path
    [AppDomain]::CurrentDomain.GetAssemblies().Location | ? {$_} | % {
        Write-Host "NGENing: $(Split-Path $_ -Leaf)"
        ngen install $_ | Out-Null
    }
}

# Window CLI size
[console]::WindowWidth=80
[console]::WindowHeight=23
[console]::BufferWidth = [console]::WindowWidth


#Window CLI-Console show/hide
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
    # Hide = 0,
    # ShowNormal = 1,
    # ShowMinimized = 2,
    # ShowMaximized = 3,
    # Maximize = 3,
    # ShowNormalNoActivate = 4,
    # Show = 5,
    # Minimize = 6,
    # ShowMinNoActivate = 7,
    # ShowNoActivate = 8,
    # Restore = 9,
    # ShowDefault = 10,
    # ForceMinimized = 11

# [Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 0) | Out-Null

#Check for Language 
$langos = (Get-WinUserLanguageList)[0].LocalizedName

#Window CLI color
$Host.UI.RawUI.BackgroundColor = ($bckgrnd = 'Black')
cls

# System Information function
$ProcessorType=Get-WMIObject win32_Processor | select Name | findstr /c:AMD /c:Intel
$ProcessorType = $ProcessorType.Replace('(R)','').Replace('(TM)','')
$licensekey=wmic path softwarelicensingservice get OA3xOriginalProductKey | findstr /c:'-'
$RAMGet=Get-WMIObject -Computername localhost -class win32_ComputerSystem | Select-Object -Expand TotalPhysicalMemory
$RAMGet=$RAMGet/1024/1024/1024

# Cleaning help files
if (Test-Path $Env:programdata\*.lbool) {Remove-Item $Env:programdata\*.lbool}
if (Test-Path $Env:programdata\ET\*.lbool) {Remove-Item $Env:programdata\ET\*.lbool}
if (Test-Path $Env:programdata\*.lbool) {Remove-Item $Env:programdata\ET\*.lbool}
if (Test-Path $Env:programdata\ET\) {
}
else
{
    #Create directory if not exists
    New-Item $Env:programdata\ET\ -ItemType Directory
}

# Using UTF-8 Encoding + special characters
chcp 65001
$PSDefaultParameterValues['*:Encoding'] = 'utf8'

# Created by Rikey
# https://github.com/semazurek/ET-Optimizer
# https://www.paypal.com/paypalme/rikey

$versionPS="E.T. ver 5.4   -   "+$ProcessorType+" "+[math]::round($RAMGet)+" GB RAM";
$versionRAW="E.T. ver 5.4"
$HOST.UI.RAWUI.WINDOWTITLE = $versionRAW
[reflection.assembly]::LoadWithPartialName( 'System.Windows.Forms'); 
[reflection.assembly]::loadwithpartialname('System.Drawing'); 
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

# Continue if error
$ErrorActionPreference= "SilentlyContinue";

$mainforecolor="#eeeeee"
$mainbackcolor="#252525"
$menubackcolor="#323232"
$selectioncolor="#3498db"
$selectioncolor2="#246c9d"
$unselectionc="#ecf0f1"
$expercolor="#e74c3c"
function count_p {
$c_p = 0;
Foreach ($control in $panel1.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){$c_p++;$control.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor)}
		Else {$control.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)}
   }
If ($c_p -eq 34) { $groupbox1.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor);$panel1.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor); $B_performanceall.Visible = $false; $B_performanceoff.Visible = $true; }
Else { $groupbox1.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor); $B_performanceall.Visible = $true; $B_performanceoff.Visible = $false; }
}
function count_v {
$c_v = 0;
Foreach ($control in $panel3.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){$c_v++;$control.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor)}
		Else {$control.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)}
   }
If ($c_v -eq 6) { $groupbox3.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor); $B_visualoff.Visible = $true; $B_visualall.Visible = $false; }
Else { $groupbox3.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor); $B_visualoff.Visible = $false; $B_visualall.Visible = $true; }
}
function count_s {
$c_s = 0;
Foreach ($control in $panel2.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){$c_s++;$control.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor)}
		Else {$control.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)}
   }
If ($c_s -eq 17) { $groupBox2.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor); $B_privacyoff.Visible = $true; $B_privacyall.Visible = $false; }
Else { $groupbox2.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor); $B_privacyoff.Visible = $false; $B_privacyall.Visible = $true; }
}
function count_o {
$c_o = 0;
Foreach ($control in $panel4.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){$c_o++;$control.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor)}
		Else {$control.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)}
   }
If ($c_o -eq 6) { $groupbox4.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor); }
Else { $groupbox4.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor); }
}
function do_start { 
Foreach ($control in $panel1.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){ echo True > $Env:programdata\ET\chck$tempval.lbool}
   }
Foreach ($control in $panel2.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){ echo True > $Env:programdata\ET\chck$tempval.lbool}
   }
Foreach ($control in $panel3.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){ echo True > $Env:programdata\ET\chck$tempval.lbool}
   }
Foreach ($control in $panel4.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){ echo True > $Env:programdata\ET\chck$tempval.lbool}
   }
Foreach ($control in $groupBox5.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){ echo True > $Env:programdata\ET\chck$tempval.lbool}
   }
$form.close()
}; 

function New-CheckBox {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Location,
        [Parameter(Mandatory=$true)]
        [string]$Size,
        [Parameter(Mandatory=$false)]
        [string]$Text = '',
        [Parameter(Mandatory=$true)]
        [string]$TabID,
        [Parameter(Mandatory=$false)]
        [string]$Check
    )

    $o = New-Object Windows.Forms.CheckBox
    $o.Location = $Location
    $o.Size     = $Size
    $o.Text     = $Text
    $o.TabIndex = $TabID 
    $o.Checked = $Check 
    $o.Font = $Font

    return $o
}

$form= New-Object Windows.Forms.Form; 
$form.Size = New-Object System.Drawing.Size(895,500); 
$form.StartPosition = 'CenterScreen'; 
$form.FormBorderStyle = 'FixedDialog'; 
$form.Text = $versionPS; 
$form.AutoSizeMode = 'GrowAndShrink'; 
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen; 
$form.MinimizeBox = $false; 
$form.MaximizeBox = $false; 
$Font = New-Object System.Drawing.Font('Consolas',9,[System.Drawing.FontStyle]::Regular); 
$ButtonFont = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$form.BackColor = [System.Drawing.ColorTranslator]::FromHtml($mainbackcolor)
$form.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)
$form.Font = $Font; 
$base64IconString = "AAABAAEAICAAAAEAIACoEAAAFgAAACgAAAAgAAAAQAAAAAEAIAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAD7/f8B////AAAAhwBZpf4DLo/+CS6Q/glWrv4DAADaAP///wD7/f8B+vv/Af///wH///8B////Af///wH///8B////Af///wH///8BHhsAALe2qQSrqpw1q6qbhquqm56sq5x0rKucQq+unxf///8AFBEAAP7+/gH///8B////ATmV/gAdhv8FIon/EyWK/ygni/8+KYj/Pi6A/yg4dv8TVYX/BQAA+wD//xQA+/z/Afj6/wH///8B////Af///wH///4B////AP///wCwr6EMrKucJquqm1yrqpuiq6qbtquqm5Gsq5xZrq2eH////wBfXUAA/v7+Af///wH///8BACb/AC2P/hMpjP46KIv+bimK/p8qhv6fLXv+bjNv/js7cP4TAAD/AAAA/wD6+/0B+/z+Af///wH///8B////Af///wH///8Au7quBKyrnCarqptmq6qbpauqm9Srqpveq6qbv6uqm36trJ0sAAAAAIB+ZwD9/f0B/v7+Af///wGz3P8cc7f/OlSk/3RBlPayNIbs4zF95+M0cuSyOGrldjhr8js6d/8UYrL/BAAAAAAAAAAA////Aff4+gH///8A////AbKxpAmsq50frKucVayrm6Osq5zZrKuc7KyrnN2sq5ywraydb7CvoCZYV04Ap6WYALm3rACmpJUAe3hiAKfQ/1OMwv52c7L5t12c5+dGf8z6O23A+jxnwuc8Zcy6OGfjeTNr/z45c/8UAAAAAAAAuwD+//8B+/v8AUdFJAD///8ArayeGquqm06rqpuPq6qbz6uqm+6rqpvjrKubs6yrnGmurZ0ws7KjD////wB1c18AAAAAAP///wD///8AkbXfjoOs3axxoNjiX4zE/0tvpf8/XZf/PVqc/ztaqec2Wry1MVfBfTBMnkUyOlwePTQ4Cf//AAD///8AcW9UAP///wCurZ4kq6qbaKmoma6mpZfloqGU9JybkNmTk4mdfn56T0hIUB0tLTwOlZSWE8rJwyLV1M0m1tXOG9XVzhV6lru/bouy0Ft6ovBNaZD/Q1d6/z1Nb/87SnH/OEp8+jRLjecwSI7FLz91ky03XFkuNVQfmGcsAQAAAABwblUA////AK+unySsq5tppaSWrpybkOWRkIfzfn561mloaadMTFRvKys6RDAwPy2Tk5Q7yMfCZdTTzG3V1M1R1NPMP2V7nMFZbo7RR1p57j1Naf87Rl7/OUFW/zc/Vf81P17/MkBt/zA/b/EvOmLPLjhdkS1Ed0EudeEQUrr/BGFnWwAAAAAAsrGiIK2snV+gn5OjkpGI4YB/e/VlZWfhTU1Vwj4+SqM8PEqDV1dhbJmYmXvGxcCo1dTNrtXUzY3U08x4RlNtmD9NaLM2RGDjM0BZ/zU9Uv81O07/NDpN/zM5UP8xOVb/MDdW/i82VPEuO1+/LVKSbSx56i81j/8PR11rAAAJhgC0s6McraydU5ybj5eKiYLcdHRy/FdXXfZDQ07oPj5L20tLV8ttbHS/nJucx8TDv97V1M3b1tXNv9TTzK0sMEN7LDNJmyw2T9UuOFD5MTlP/zI5Tf8zOEv/MjZJ/zA0SP8vM0j/LjRM/y0/Zd0rXaeaKX3tVS2K/xxIYnIAGlmgAKKgjB6cmohbkI+Cn4OBe99ubm3/UlJa/0FBTv5BQU77UlJc9nRzefKcm5zzwsG99dXUzd7W1c6y1NPMmissO3QrLkCSLDFFyS00S+8uOFD6MDlR/jI5Tf8zOEr/MjZJ/zA1Sv8uN1D/LEZx7SpntcMpget+LIn5LA9JfgD//wAAi4hxLYqHcXiGhHS7f3516W5tbP9TU1v/Q0NQ/0REUP9VVV//c3N5/ZiYmfe/vrrn1dTNtdfWz2vU08xDLS07cS0tPY0sL0DBLDFF5S02TfIuOlT4Mj5Z/TlGX/9DT2f/RVNs/0FScv88XYv1OHK42TWB15Q4ht00kINfC4l+XCOIhW5cjIlzpYuJedqGhX3zc3Jy/VRUXPxCQk/6Q0NP+1JSXPttbXP3jo2P4Le2s7XV1M123NvTMNXUzQssLDtwLC08jC0tPb4sL0DfLDFF5i05VO4xRmv4QluB/l51lv9pgaP/Y4Cp/1p/rfZTgbHdUIKzmleDrD6Ef2YqhIBmZYyKdKSXlYLWmpiL8ZSTjfV6en30U1Nc8jw8SvI9PUvzS0tW8WBgaOV4d3y2n56ebNfWzzHt7OIQ5eXhAiwsO24sLDuKLS08vC0tPNssLj/fLTZP5TBEaO9CW4H3YHeY+nGKq/p0krj2dZS48HiSq+N6j5y0fYiEcYaDbGyMiXOnmJaC2Kelle2pp5zqmJiV2HR0etNKSlbfNjZE6Dc3RelAQEzjTk5Yz1taY5RubXM86ejfCf///wH///8BLCw7aiwsO4ctLTy7LS082i0tPdwtMUPeLzdP5DhDXOtHU2vwWmd/7XCAmOKIlqfjmqOm7Zygl+ONjnzHiohyxpaUgOCoppXsu7mt4re2r8WOjo6fVlZgoDk5R8YwMD/fMDA/4DQ0QtQ5OUa6PT1Kf0RDUC3///8BAAAAAP///wEsLDtnLCw7hC0tPLotLTzaLS082y0tPNkuLj7cLzFC4TQ3SOdCRlfcXmNyxIiLkMeop5/jq6mZ9ZqYhfeUkX76m5mG/KupmeTEwre0v766iHh4fWw3N0R/LS08uC0tPNstLTzbLS08ziwsO7IsLDt4Ly8+KQAAAAAAAAEAAAAAACwsO2UsLDuDLS08ui0tPNotLTzbLS082S0tPNotLT3dLy8/3jM0RMlCRFKkc3N1pKGflsuwrp/qq6ma+aSikf+em4n9oZ6My7SypHWlpKNIUlJdTy4uPXosLDu3LS082i0tPNssLDvQKys7uCsrOn4tLTwsAAAAAAAAAAD///8ALCw7YywsO4EtLTy5Li482y8vPt8xMT/eMjJA3TU1Qtk4OEXQOztFukJCSJ5qaWakmZeLy7Gvoem6uKv2tLKl/qSik/2Vk4TMfXxzeEtKUVExMT9iLCw7jCwsPL4tLTzaLS082y0tPNMsLDvCLCw7kC4uPEcyMkAbNDRCFTQ0QhUsLDthLCw7gC0tPLovLz7fNDRB5zg4ROg8O0fkQ0NN109PVsJXV1m2XlxXtXVzaMaUkoTkrqyf8sLAtu7BwLbxrKqg+Y6NheZhYWG7OjpDoC8vPJ8sLDyvLS08yi0tPNotLTzaLS081iwsO8wsLDuqLCw7di0tPFItLTxDLS08PSoqOl0tLTx/MDA+vjQ0Qec4OEXxPT1I8kBAS+9ISFHhVFRazVtaXMheXFnTbm1m44qJf+6mpJrgwsG4vsfGv7iurabPh4aE4FhYXOM7O0TcMjI/0S8vPc8vLz3XLi493C0tPNstLTzYLCw70ywsO8EsLDukLCw7iCwsO3MsLDtpLCw8XDExQII2NkPHOTlG8z09SPo/P0r7QEBL+kNDTfRHR1DtSEhQ7EpKUPFbWl7wenl545WUkbOzsq1swcG7W6WkoYR7eny2UlFZ4j49R/Q3NkLtNDNA5jMyQOQxMT/hLy893i0tPNstLTzYLS080i0tPMgtLTy2LCw7niwsO5JHR1ByQkJMlT09SdU9PUj8Pj5K/z8/Sv8/P0r/Pz9K/z8/S/8/P0v/QEBM/01NV/FnZ27PfHyAjIyMjjimpqUfjIyOSmZlbI5JSFPXPT1I/Do5RPw3N0L1NjZC8DQ0QesyMkDmMDA+4i0tPN0sLDvcLS083C0tPM8tLTu3LCw7qWNjZZhWVluyRUVP4j4+Sv09PUn9PT1I+Ts7SPc8PEn5Pz9L/kFBTf9DQ0//SUlV6VZWYbliYmt0aGhwKHFxeA1eXmYrSUlUbj4+S8Q8PEn2Pj1J/j4+Sfw9PUj6PDxH9zo6RvQ2NkPsMDA/4i0tPN0tLTzcLS08zi0tO7ctLTuqbW1tkWBgY6tQUFfYRkZQ6j8/Sts5OUbPODhFzDw8SdNGRlHgT09a8FdXYPpdXWbmZGNss2lpcW5tbXQmKCg5BiMjMxc4OEZQQEBNo0pKVd5XVmD3XVxl/1xcZP9YWGD/U1JZ/E1MVPNGRk/jPT1I0TIyQL4sLDupLCw7li0tO4xtbW1eaGhpfWJhZLJYWF2+REROnDMzQYUyMkCDQkJOkVpaY61ubnXQfXyB74aFieqMjI69kpGTd5SUlSkAAAACAAAVCkZGUjRXV2F1bW10tYSEiOeOjpH/j46R/4iHif97enr/cnFw9mxsbONgYGO9RUVOiisrO2gqKjlbLS07Vm1sbS5vbm9Ib29vc2ZmaHpLS1NZKio5QygoOEJZWGJbhYSIjJuam8CnpqXrrayq7rCvrcazsq+BtbSxLQAAAAAAAAADW1tkG29vdUSPj5F/qainw7Szsu65uLf9srGu/6Ggm/+VlI36j4+H6oaFf7hra2tqPDxIOS0tPC0tLTwpc3JzD3V0dBl0dHQoa2tsKlFRWB4lJTUVOTlHGJuamz67ureFxcTAxMrJxO3LysXuysnExsnIw4DKycMt7ueSAP///wBWVmEId3d8F6yrqkTBwLyLzMvHx9PSz+7Pzsn/v763/7Gwpv+nppr5oJ+Tw5aVi2V6encoVVVcFDQ0Qw3///8B////AAAAAAAlJCAAAAAAAN/e1grX1s8j2tnSV9zb1aDc29XW29vU7NrZ09vX1s+k1NPMYtTTzCH///8ArqygAJSTiQAAAAAA1tXOG9XUzVDb2tSL397awtva1ObQz8f3w8K4/7i3qv+ysaPRr66gc66tni2zsqQNAAAAAAAAAAAAAAAAFxcXAHh4dQAmJiwA3dzTHdfWz1jc2tSX4eDbz+Hg2+vd3dfj2trTs9nY0WXW1c4r19bPDf///wEAAAAAAAAAAAAAAAD29OoH3dzUG9zb1EPc29V82djRsdTTy9zMy8L4w8K4/728sNe2taiFrq2fQLKxohQAAAAA/v7+Af7+/gH9/fwBtbOmAP///wDT0ssi1NPMZNnY0qXe3djW397Z3Nzb1bPZ2dF119fQMdbVzgnh39sC////Af///wH+/v0B/f39AZmWhQA/OhoA1dTOFdTTzD7U08xs1NPMl9DPx7jKycDHw8K4rbm4rG+sq503q6qbEv///wD///8B////Af7+/gGHhHAA////ANXUzRbU08xC1tXPfNjX0bTZ2NKt2djSadjY0TDY2NER5eTgAv///wD///8B////Af39/QH+/v4BAAAAAKqomwDY19EF09LLFNTTzCXV1M040tHJUc7NxWnKycBfwL+1NK6toBSuraAG////Af///wH///8B////AQAAAAD///8B1tXPD9TTzC3U08xj1NPMn9TTzJLU08xA1NPMC+Pi3gL///8B////Af///wH///8B////Af///wH+/v4B/v7+Af///wEAAAAA////ANfWzwTU080Y1dTNNdXUzTPY19ETAAAAAF1aPwD+/v0BAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
$iconimageBytes = [Convert]::FromBase64String($base64IconString)
$ims = New-Object IO.MemoryStream($iconimageBytes, 0, $iconimageBytes.Length)
$ims.Write($iconimageBytes, 0, $iconimageBytes.Length); 
$Icon = [System.Drawing.Image]::FromStream($ims, $true)
$form.Icon = [System.Drawing.Icon]::FromHandle((new-object System.Drawing.Bitmap -argument $ims).GetHIcon())
$B_close = New-Object Windows.Forms.Button; 
$B_close.text = 'Start'; 
$B_close.FlatStyle = 'Flat'
$B_close.Location = New-Object Drawing.Point 660,400; 
$B_close.Size = New-Object Drawing.Point 120,50;
$B_close.BackColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)
$B_close.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainbackcolor)
$B_close.Font = $ButtonFont
$B_close.add_click({do_start}); $form.controls.add($B_close); 
$B_checkall = New-Object Windows.Forms.Button; 
$B_checkall.text = 'Select All'; 
if ($langos -eq 'Polski') {$B_checkall.text = 'Zaznacz Wszystko'; }
$B_checkall.Location = New-Object Drawing.Point 510,400; 
$B_checkall.Size = New-Object Drawing.Point 140,50;
$B_checkall.FlatStyle = 'Flat'
$B_checkall.BackColor = [System.Drawing.ColorTranslator]::FromHtml($unselectionc);
$B_checkall.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainbackcolor);
$B_checkall.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_checkall.add_click({
Foreach ($control in $panel1.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
Foreach ($control in $panel2.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
Foreach ($control in $panel3.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
Foreach ($control in $panel4.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.TabIndex -ne 60 -and $control.TabIndex -ne 61 -and $control.TabIndex -ne 59 -and $control.TabIndex -ne 65 -and $control.TabIndex -ne 66){
           $control.checked = $true
       }
   }
$B_checkall.Visible = $false;
$B_uncheckall.Visible = $true;
$B_performanceoff.Visible = $true;
$B_performanceall.Visible = $false;
$B_visualoff.Visible = $true;
$B_visualall.Visible = $false;
$B_privacyoff.Visible = $true;
$B_privacyall.Visible = $false;
count_p;
count_v;
count_s;
count_o;
}); 
$form.controls.add($B_checkall);
$B_uncheckall = New-Object Windows.Forms.Button; 
$B_uncheckall.text = 'Unselect All'; 
if ($langos -eq 'Polski') {$B_uncheckall.text = 'Odznacz Wszystko'; }
$B_uncheckall.BackColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor2);
$B_uncheckall.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor);
$B_uncheckall.FlatAppearance.BorderSize = 0;
$B_uncheckall.Location = New-Object Drawing.Point 510,400; 
$B_uncheckall.Size = New-Object Drawing.Point 140,50;
$B_uncheckall.FlatStyle = 'Flat'
$B_uncheckall.Font = $ButtonFont
$B_uncheckall.add_click({
Foreach ($control in $panel1.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
Foreach ($control in $panel2.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
Foreach ($control in $panel3.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
Foreach ($control in $panel4.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
Foreach ($control in $groupBox5.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
$B_checkall.Visible = $true;
$B_uncheckall.Visible = $false;
$B_performanceoff.Visible = $false;
$B_performanceall.Visible = $true;
$B_visualoff.Visible = $false;
$B_visualall.Visible = $true;
$B_privacyoff.Visible = $false;
$B_privacyall.Visible = $true;
count_p;
count_v;
count_s;
count_o;
}); 
$form.controls.add($B_uncheckall);
$B_performanceall = New-Object Windows.Forms.Button; 
$B_performanceall.text = 'Performance'; 
if ($langos -eq 'Polski') {$B_performanceall.text = 'Wydajnosc'; }
$B_performanceall.Location = New-Object Drawing.Point 110,400; 
$B_performanceall.Size = New-Object Drawing.Point 130,50;
$B_performanceall.FlatStyle = 'Flat'
$B_performanceall.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor);
$B_performanceall.BackColor = [System.Drawing.ColorTranslator]::FromHtml($unselectionc);
$B_performanceall.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainbackcolor);
$B_performanceall.Font = $ButtonFont
$B_performanceall.add_click({
Foreach ($control in $panel1.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
count_p;
$B_performanceoff.Visible = $true;
$B_performanceall.Visible = $false;
}); 
$form.controls.add($B_performanceall); 
$B_performanceoff = New-Object Windows.Forms.Button; 
$B_performanceoff.text = 'Performance'; 
if ($langos -eq 'Polski') {$B_performanceoff.text = 'Wydajnosc'; }
$B_performanceoff.Location = New-Object Drawing.Point 110,400; 
$B_performanceoff.Size = New-Object Drawing.Point 130,50;
$B_performanceoff.BackColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor2);
$B_performanceoff.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor);
$B_performanceoff.FlatAppearance.BorderSize = 0;
$B_performanceoff.FlatStyle = 'Flat'
$B_performanceoff.Font = $ButtonFont
$B_performanceoff.add_click({
Foreach ($control in $panel1.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
count_p;
$B_performanceoff.Visible = $false;
$B_performanceall.Visible = $true;
}); 
$form.controls.add($B_performanceoff); 
$B_visualall = New-Object Windows.Forms.Button; 
$B_visualall.text = 'Visual'; 
if ($langos -eq 'Polski') {$B_visualall.text = 'Wizualne'; }
$B_visualall.Location = New-Object Drawing.Point 250,400; 
$B_visualall.Size = New-Object Drawing.Point 120,50;
$B_visualall.FlatStyle = 'Flat'
$B_visualall.BackColor = [System.Drawing.ColorTranslator]::FromHtml($unselectionc);
$B_visualall.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainbackcolor);
$B_visualall.Font = $ButtonFont
$B_visualall.add_click({
Foreach ($control in $panel3.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
$B_visualoff.Visible = $true;
$B_visualall.Visible = $false;
count_v;
}); 
$form.controls.add($B_visualall); 
$B_visualoff = New-Object Windows.Forms.Button; 
$B_visualoff.text = 'Visual'; 
if ($langos -eq 'Polski') {$B_visualoff.text = 'Wizualne'; }
$B_visualoff.Location = New-Object Drawing.Point 250,400; 
$B_visualoff.Size = New-Object Drawing.Point 120,50;
$B_visualoff.FlatStyle = 'Flat'
$B_visualoff.BackColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor2);
$B_visualoff.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor);
$B_visualoff.FlatAppearance.BorderSize = 0;
$B_visualoff.Font = $ButtonFont
$B_visualoff.add_click({
Foreach ($control in $panel3.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
$B_visualoff.Visible = $false;
$B_visualall.Visible = $true;
count_v;
}); 
$form.controls.add($B_visualoff); 
$B_privacyall = New-Object Windows.Forms.Button; 
$B_privacyall.text = 'Privacy'; 
if ($langos -eq 'Polski') {$B_privacyall.text = 'Prywatnosc'; }
$B_privacyall.Location = New-Object Drawing.Point 380,400; 
$B_privacyall.Size = New-Object Drawing.Point 120,50;
$B_privacyall.FlatStyle = 'Flat'
$B_privacyall.BackColor = [System.Drawing.ColorTranslator]::FromHtml($unselectionc);
$B_privacyall.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainbackcolor);
$B_privacyall.Font = $ButtonFont
$B_privacyall.add_click({
Foreach ($control in $panel2.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
$B_privacyoff.Visible = $true;
$B_privacyall.Visible = $false;
count_s;
}); 
$form.controls.add($B_privacyall); 
$B_privacyoff = New-Object Windows.Forms.Button; 
$B_privacyoff.text = 'Privacy'; 
if ($langos -eq 'Polski') {$B_privacyoff.text = 'Prywatnosc'; }
$B_privacyoff.Location = New-Object Drawing.Point 380,400; 
$B_privacyoff.Size = New-Object Drawing.Point 120,50;
$B_privacyoff.FlatStyle = 'Flat'
$B_privacyoff.BackColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor2);
$B_privacyoff.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor);
$B_privacyoff.FlatAppearance.BorderSize = 0;
$B_privacyoff.Font = $ButtonFont
$B_privacyoff.add_click({
Foreach ($control in $panel2.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
$B_privacyoff.Visible = $false;
$B_privacyall.Visible = $true;
count_s;
}); 
$form.controls.add($B_privacyoff);
$B_uncheckall.Visible = $false;
$B_performanceall.Visible = $false;
$B_visualall.Visible = $false;
$B_privacyall.Visible = $false;
count_p;
count_v;
count_s;
count_o;
$groupBox1 = New-Object System.Windows.Forms.GroupBox
$groupBox1.Location = '10,30' 
$groupBox1.size = '570,180'
$groupBox1.text = 'Performance Tweaks (34)'
if ($langos -eq 'Polski') {$groupBox1.text = 'Poprawki Wydajnosci (34)'; }
$groupBox1.Visible = $true
$groupBox1.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$groupBox1.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)
$form.controls.Add($groupBox1) 
$groupBox1.add_click({count_p})
$panel1 = New-Object System.Windows.Forms.Panel
$panel1.Dock = DockStyle.Fill
$panel1.AutoScroll = $true
$panel1.VerticalScroll.Enabled = $false
$panel1.VerticalScroll.Visible = $false
$panel1.size = '576,153'
$panel1.FlatStyle = 'Flat'
$panel1.Location = '10,20'
$groupbox1.controls.Add($panel1) 
$groupBox2 = New-Object System.Windows.Forms.GroupBox
$groupBox2.Location = '585,30' 
$groupBox2.size = '285,180'
$groupBox2.text = 'Privacy (17)'
if ($langos -eq 'Polski') {$groupBox2.text = 'Prywatnosc (17)'; }
$groupBox2.Visible = $true
$groupBox2.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$groupBox2.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)
$form.Controls.Add($groupBox2) 
$groupBox2.add_click({count_s})
$panel2 = New-Object System.Windows.Forms.Panel
$panel2.Dock = DockStyle.Fill
$panel2.AutoScroll = $true
$panel2.VerticalScroll.Enabled = $false
$panel2.VerticalScroll.Visible = $false
$panel2.size = '291,153'
$panel2.FlatStyle = 'Flat'
$panel2.Location = '10,20'
$groupBox2.controls.Add($panel2) 
$groupBox3 = New-Object System.Windows.Forms.GroupBox
$groupBox3.Location = '10,210' 
$groupBox3.size = '285,180'
$groupBox3.text = 'Visual Tweaks (6)'
if ($langos -eq 'Polski') {$groupBox3.text = 'Poprawki Wizualne (6)'; }
$groupBox3.Visible = $true
$groupBox3.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$groupBox3.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)
$form.Controls.Add($groupBox3) 
$groupBox3.add_click({count_v})
$panel3 = New-Object System.Windows.Forms.Panel
$panel3.Dock = DockStyle.Fill
$panel3.AutoScroll = $true
$panel3.VerticalScroll.Enabled = $false
$panel3.VerticalScroll.Visible = $false
$panel3.size = '291,153'
$panel3.FlatStyle = 'Flat'
$panel3.Location = '10,20'
$groupBox3.controls.Add($panel3) 
$groupBox4 = New-Object System.Windows.Forms.GroupBox
$groupBox4.Location = '302,210' 
$groupBox4.size = '278,180'
$groupBox4.text = 'Other (6)'
if ($langos -eq 'Polski') {$groupBox4.text = 'Inne (6)'; }
$groupBox4.Visible = $true
$groupBox4.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$groupBox4.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)
$form.Controls.Add($groupBox4) 
$panel4 = New-Object System.Windows.Forms.Panel
$panel4.Dock = DockStyle.Fill
$panel4.AutoScroll = $true
$panel4.VerticalScroll.Enabled = $false
$panel4.VerticalScroll.Visible = $false
$panel4.size = '284,153'
$panel4.FlatStyle = 'Flat'
$panel4.Location = '10,20'
$groupBox4.controls.Add($panel4) 
$groupBox5 = New-Object System.Windows.Forms.GroupBox
$groupBox5.Location = '585,210' 
$groupBox5.size = '285,180'
$groupBox5.text = 'Expert Mode (4)'
if ($langos -eq 'Polski') {$groupBox5.text = 'Tryb Eksperta (4)'; }
$groupBox5.Visible = $true
$groupBox5.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$groupBox5.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($expercolor)
$form.Controls.Add($groupBox5) 
$groupBox5.add_MouseHover({
$tooltipg5 = New-Object System.Windows.Forms.ToolTip
$tooltipg5.SetToolTip($groupBox5, 'Non recommended or unstable. May need to be done in safe mode.');
if ($langos -eq 'Polski') {$tooltipg5.SetToolTip($groupBox5, 'Niezalecane lub niestabilne. Mozliwa potrzeba wykonania w trybie awaryjnym.');}
})

$chck1 = New-CheckBox -Location '0,5' -Size '270,25' -Text 'Disable Edge WebWidget' -TabID '0' -Check '$true'
$chck1.add_click({count_p})
$panel1.controls.add($chck1);

$chck2 = New-CheckBox -Location '0,30' -Size '270,25' -Text 'Power Option to Ultimate Performance' -TabID '1' -Check '$true'
$chck2.add_MouseHover({
$tooltip2 = New-Object System.Windows.Forms.ToolTip
$tooltip2.SetToolTip($chck2, 'Setting power option to high/ultimate for best CPU performance')
})
$chck2.add_click({count_p})
$panel1.controls.add($chck2); 

$chck4 = New-CheckBox -Location '0,55' -Size '270,25' -Text 'Dual Boot Timeout 3sec' -TabID '3' -Check '$true'
$chck4.add_click({count_p})
$panel1.controls.add($chck4); 

$chck5 = New-CheckBox -Location '0,80' -Size '270,25' -Text 'Disable Hibernation/Fast Startup' -TabID '4' -Check '$true'
$chck5.add_click({count_p})
$panel1.controls.add($chck5); 
$chck5.add_MouseHover({
$tooltip5 = New-Object System.Windows.Forms.ToolTip
$tooltip5.SetToolTip($chck5, 'Disable Hibernation/Fast startup in Windows to free RAM from hiberfil.sys')
})

$chck6 = New-CheckBox -Location '0,105' -Size '280,25' -Text 'Disable Windows Insider Experiments' -TabID '5' -Check '$true'
$chck6.add_click({count_p})
$panel1.controls.add($chck6); 

$chck7 = New-CheckBox -Location '0,130' -Size '270,25' -Text 'Disable App Launch Tracking' -TabID '6' -Check '$true'
$chck7.add_click({count_p})
$panel1.controls.add($chck7); 

$chck8 = New-CheckBox -Location '0,155' -Size '270,25' -Text 'Disable Powerthrottling (Intel 6gen+)' -TabID '7' -Check '$true'
$chck8.add_click({count_p})
$panel1.controls.add($chck8); 

$chck9 = New-CheckBox -Location '0,180' -Size '270,25' -Text 'Turn Off Background Apps' -TabID '8' -Check '$true'
$chck9.add_click({count_p})
$panel1.controls.add($chck9); 

$chck10 = New-CheckBox -Location '0,205' -Size '270,25' -Text 'Disable Sticky Keys Prompt' -TabID '9' -Check '$true'
$chck10.add_click({count_p})
$panel1.controls.add($chck10); 

$chck11 = New-CheckBox -Location '0,230' -Size '270,25' -Text 'Disable Activity History' -TabID '10' -Check '$true'
$chck11.add_click({count_p})
$panel1.controls.add($chck11); 

$chck12 = New-CheckBox -Location '0,255' -Size '280,25' -Text 'Disable Updates for MS Store Apps' -TabID '11' -Check '$true'
$chck12.add_click({count_p})
$panel1.controls.add($chck12); 
$chck12.add_MouseHover({
$tooltip12 = New-Object System.Windows.Forms.ToolTip
$tooltip12.SetToolTip($chck12, 'Disable Automatic Updates for Microsoft Store apps')
})

$chck13 = New-CheckBox -Location '0,280' -Size '270,25' -Text 'SmartScreen Filter for Apps: Disable' -TabID '12' -Check '$true'
$chck13.add_click({count_p})
$panel1.controls.add($chck13); 

$chck14 = New-CheckBox -Location '0,305' -Size '270,25' -Text 'Let Websites Provide Locally' -TabID '13' -Check '$true'
$chck14.add_click({count_p})
$panel1.controls.add($chck14); 

$chck15 = New-CheckBox -Location '0,330' -Size '270,25' -Text 'Fix Microsoft Edge Settings' -TabID '14' -Check '$true'
$chck15.add_click({count_p})
$panel1.controls.add($chck15); 

$chck64 = New-CheckBox -Location '0,355' -Size '270,25' -Text 'Disable Nagle''s Alg. (Delayed ACKs)' -TabID '63' -Check '$true'
$chck64.add_click({count_p})
$panel1.controls.add($chck64); 

$chck65 = New-CheckBox -Location '0,380' -Size '270,25' -Text 'CPU Priority Tweaks' -TabID '64' -Check '$true'
$chck65.add_click({count_p})
$panel1.controls.add($chck65); 

$chck16 = New-CheckBox -Location '285,05' -Size '270,25' -Text 'Disable Location Sensor' -TabID '15' -Check '$true'
$chck16.add_click({count_p})
$panel1.controls.add($chck16); 

$chck17 = New-CheckBox -Location '285,30' -Size '270,25' -Text 'Disable WiFi HotSpot Auto-Sharing' -TabID '16' -Check '$true'
$chck17.add_click({count_p})
$panel1.controls.add($chck17); 

$chck18 = New-CheckBox -Location '285,55' -Size '270,25' -Text 'Disable Shared HotSpot Connect' -TabID '17' -Check '$true'
$chck18.add_click({count_p})
$panel1.controls.add($chck18); 

$chck19 = New-CheckBox -Location '285,80' -Size '270,25' -Text 'Updates Notify to Schedule Restart' -TabID '18' -Check '$true'
$chck19.add_click({count_p})
$panel1.controls.add($chck19); 
$chck19.add_MouseHover({
$tooltip19 = New-Object System.Windows.Forms.ToolTip
$tooltip19.SetToolTip($chck19, 'Change Windows Updates to: Notify to schedule restart')
})

$chck20 = New-CheckBox -Location '285,105' -Size '270,25' -Text 'P2P Update Setting to LAN (local)' -TabID '19' -Check '$true'
$chck20.add_click({count_p})
$panel1.controls.add($chck20); 
$chck20.add_MouseHover({
$tooltip20 = New-Object System.Windows.Forms.ToolTip
$tooltip20.SetToolTip($chck20, 'Disable P2P Update downloads outside of local network')
})

$chck21 = New-CheckBox -Location '285,130' -Size '270,25' -Text 'Set Lower Shutdown Time (2sec)' -TabID '20' -Check '$true'
$chck21.add_click({count_p})
$panel1.controls.add($chck21); 

$chck22 = New-CheckBox -Location '285,155' -Size '270,25' -Text 'Remove Old Device Drivers' -TabID '21' -Check '$true'
$chck22.add_click({count_p})
$panel1.controls.add($chck22); 

$chck23 = New-CheckBox -Location '285,180' -Size '270,25' -Text 'Disable Get Even More Out of...' -TabID '22' -Check '$true'
$chck23.add_click({count_p})
$panel1.controls.add($chck23); 
$chck23.add_MouseHover({
$tooltip23 = New-Object System.Windows.Forms.ToolTip
$tooltip23.SetToolTip($chck23, 'Disable Get Even More Out of Windows Screen')
})

$chck24 = New-CheckBox -Location '285,205' -Size '270,25' -Text 'Disable Installing Suggested Apps' -TabID '23' -Check '$true'
$chck24.add_click({count_p})
$panel1.controls.add($chck24); 
$chck24.add_MouseHover({
$tooltip24 = New-Object System.Windows.Forms.ToolTip
$tooltip24.SetToolTip($chck23, 'Disable automatically installing suggested apps')
})

$chck25 = New-CheckBox -Location '285,230' -Size '270,25' -Text 'Disable Start Menu Ads/Suggestions' -TabID '24' -Check '$true'
$chck25.add_click({count_p})
$panel1.controls.add($chck25); 

$chck26 = New-CheckBox -Location '285,255' -Size '274,25' -Text 'Disable Suggest Apps WindowsInk' -TabID '25' -Check '$true'
$chck26.add_click({count_p})
$panel1.controls.add($chck26); 

$chck27 = New-CheckBox -Location '285,280' -Size '270,25' -Text 'Disable Unnecessary Components' -TabID '26' -Check '$true'
$chck27.add_click({count_p})
$panel1.controls.add($chck27); 
$chck27.add_MouseHover({
$tooltip27 = New-Object System.Windows.Forms.ToolTip
$tooltip27.SetToolTip($chck27, 'PrintToPDFServices, Printing-XPSServices, Xps-Viewer')
})

$chck28 = New-CheckBox -Location '285,305' -Size '270,25' -Text 'Defender Scheduled Scan Nerf' -TabID '27' -Check '$true'
$chck28.add_click({count_p})
$panel1.controls.add($chck28); 
$chck28.add_MouseHover({
$tooltip28 = New-Object System.Windows.Forms.ToolTip
$tooltip28.SetToolTip($chck28, 'Setting Windows Defender Scheduled Scan from highest to normal privileges')
})

$chck29 = New-CheckBox -Location '285,330' -Size '270,25' -Text 'Disable Process Mitigation' -TabID '28' -Check '$true'
$chck29.add_click({count_p})
$panel1.controls.add($chck29); 
$chck29.add_MouseHover({
$tooltip29 = New-Object System.Windows.Forms.ToolTip
$tooltip29.SetToolTip($chck29, 'Audit exploit mitigations for increased process security or for converting existing Enhanced Mitigation Experience Toolkit')
})

$chck30 = New-CheckBox -Location '285,355' -Size '270,25' -Text 'Defragment Indexing Service File' -TabID '29' -Check '$true'
$chck30.add_click({count_p})
$chck30.add_MouseHover({
$tooltip30 = New-Object System.Windows.Forms.ToolTip
$tooltip30.SetToolTip($chck30, 'Defragmenting the Indexing Service database file')
}) 
$panel1.Controls.Add($chck30)

$chck66 = New-CheckBox -Location '10,100' -Size '270,25' -Text 'Disable Spectre/Meltdown Protection' -TabID '65'
$groupBox5.controls.add($chck66); 
$chck66.add_MouseHover({
$tooltip66 = New-Object System.Windows.Forms.ToolTip
$tooltip66.SetToolTip($chck66, 'These are important secure patches although it decrease system performance.')
})

$chck31 = New-CheckBox -Location '0,5' -Size '270,25' -Text 'Disable Telemetry Scheduled Tasks' -TabID '30' -Check '$true'
$chck31.add_click({count_s})
$panel2.controls.add($chck31); 

$chck32 = New-CheckBox -Location '0,30' -Size '270,25' -Text 'Remove Telemetry/Data Collection' -TabID '31' -Check '$true'
$chck32.add_click({count_s})
$panel2.controls.add($chck32); 

$chck33 = New-CheckBox -Location '0,55' -Size '270,25' -Text 'Disable PowerShell Telemetry' -TabID '32' -Check '$true'
$chck33.add_click({count_s})
$panel2.controls.add($chck33); 

$chck34 = New-CheckBox -Location '0,80' -Size '270,25' -Text 'Disable Skype Telemetry' -TabID '33' -Check '$true'
$chck34.add_click({count_s})
$panel2.controls.add($chck34); 

$chck35 = New-CheckBox -Location '0,105' -Size '270,25' -Text 'Disable Media Player Usage Reports' -TabID '34' -Check '$true'
$chck35.add_click({count_s})
$panel2.controls.add($chck35); 

$chck36 = New-CheckBox -Location '0,130' -Size '270,25' -Text 'Disable Mozilla Telemetry' -TabID '35' -Check '$true'
$chck36.add_click({count_s})
$panel2.controls.add($chck36); 

$chck37 = New-CheckBox -Location '0,155' -Size '270,25' -Text 'Disable Apps Use My Advertising ID' -TabID '35' -Check '$true'
$chck37.add_click({count_s})
$panel2.controls.add($chck37); 

$chck38 = New-CheckBox -Location '0,180' -Size '270,25' -Text 'Disable Send Info About How I Write' -TabID '37' -Check '$true'
$chck38.add_click({count_s})
$panel2.controls.add($chck38); 

$chck39 = New-CheckBox -Location '0,205' -Size '270,25' -Text 'Disable Handwriting Recognition' -TabID '38' -Check '$true'
$chck39.add_click({count_s})
$panel2.controls.add($chck39); 

$chck40 = New-CheckBox -Location '0,230' -Size '270,25' -Text 'Disable Watson Malware Reports' -TabID '39' -Check '$true'
$chck40.add_click({count_s})
$panel2.controls.add($chck40); 

$chck41 = New-CheckBox -Location '0,255' -Size '270,25' -Text 'Disable Malware Diagnostic Data' -TabID '40' -Check '$true'
$chck41.add_click({count_s})
$panel2.controls.add($chck41); 

$chck42 = New-CheckBox -Location '0,280' -Size '270,25' -Text 'Disable Reporting to MS MAPS' -TabID '41' -Check '$true'
$chck42.add_click({count_s})
$panel2.controls.add($chck42); 

$chck43 = New-CheckBox -Location '0,305' -Size '270,25' -Text 'Disable Spynet Defender Reporting' -TabID '42' -Check '$true'
$chck43.add_click({count_s})
$panel2.controls.add($chck43); 

$chck44 = New-CheckBox -Location '0,330' -Size '270,25' -Text 'Do Not Send Malware Samples' -TabID '43' -Check '$true'
$chck44.add_click({count_s})
$panel2.controls.add($chck44); 

$chck45 = New-CheckBox -Location '0,355' -Size '270,25' -Text 'Disable Sending Typing Samples' -TabID '44' -Check '$true'
$chck45.add_click({count_s})
$panel2.controls.add($chck45); 

$chck46 = New-CheckBox -Location '0,380' -Size '270,25' -Text 'Disable Sending Contacts to MS' -TabID '45' -Check '$true'
$chck46.add_click({count_s})
$panel2.controls.add($chck46); 

$chck47 = New-CheckBox -Location '0,405' -Size '270,25' -Text 'Disable Cortana' -TabID '46' -Check '$true'
$chck47.add_click({count_s})
$panel2.controls.add($chck47); 

$chck48 = New-CheckBox -Location '0,5' -Size '270,25' -Text 'Show File Extensions in Explorer' -TabID '47' -Check '$true'
$chck48.add_click({count_v})
$panel3.controls.add($chck48); 

$chck49 = New-CheckBox -Location '0,30' -Size '270,25' -Text 'Disable Transparency on Taskbar' -TabID '48' -Check '$true'
$chck49.add_click({count_v})
$panel3.controls.add($chck49); 

$chck50 = New-CheckBox -Location '0,55' -Size '270,25' -Text 'Disable Windows Animations' -TabID '49' -Check '$true'
$chck50.add_click({count_v})
$panel3.controls.add($chck50); 

$chck51 = New-CheckBox -Location '0,80' -Size '270,25' -Text 'Disable MRU lists (jump lists)' -TabID '50' -Check '$true'
$chck51.add_click({count_v})
$panel3.controls.add($chck51); 

$chck52 = New-CheckBox -Location '0,105' -Size '270,25' -Text 'Set Search Box to Icon Only' -TabID '51' -Check '$true'
$chck52.add_click({count_v})
$panel3.controls.add($chck52);

$chck53 = New-CheckBox -Location '0,130' -Size '270,25' -Text 'Explorer on Start on This PC' -TabID '52' -Check '$true'
$chck53.add_click({count_v})
$panel3.controls.add($chck53); 

$chck54 = New-CheckBox -Location '0,05' -Size '250,25' -Text 'Remove Windows Game Bar/DVR' -TabID '53' -Check '$true'
$chck54.add_click({count_o})
$panel4.controls.add($chck54);  

$chck55 = New-CheckBox -Location '0,405' -Size '270,25' -Text 'Enable Service Tweaks' -TabID '54' -Check '$true'
$chck55.add_click({count_p})
$panel1.controls.add($chck55); 
$chck55.add_MouseHover({
$tooltip55 = New-Object System.Windows.Forms.ToolTip
$tooltip55.SetToolTip($chck55, 'More details on github.com/semazurek ')
})

$chck56 = New-CheckBox -Location '285,380' -Size '270,25' -Text 'Remove Bloatware (Preinstalled)' -TabID '55' -Check '$true'
$chck56.add_click({count_p})
$panel1.controls.add($chck56);
$chck56.add_MouseHover({
$tooltip56 = New-Object System.Windows.Forms.ToolTip
$tooltip56.SetToolTip($chck56, 'More details on github.com/semazurek ')
})

$chck57 = New-CheckBox -Location '285,405' -Size '270,25' -Text 'Disable Unnecessary Startup Apps' -TabID '56' -Check '$true'
$chck57.add_click({count_p})
$panel1.controls.add($chck57); 
$chck57.add_MouseHover({
$tooltip57 = New-Object System.Windows.Forms.ToolTip
$tooltip57.SetToolTip($chck57, "Java Update Checker x64 `n Mini Partition Tool Wizard Updater `n Teams Machine Installer `n Cisco Meeting Daemon `n Adobe Reader Speed Launcher `n CCleaner Smart Cleaning/Monitor `n Spotify Web Helper `n Gaijin.Net Updater `n Microsoft Teams Update `n Google Update `n Microsoft Edge Update `n BitTorrent Bleep `n Skype `n Adobe Update Startup Utility `n iTunes Helper `n CyberLink Update Utility `n MSI Live Update `n Wondershare Helper Compact `n Cisco AnyConnect Secure Mobility Agent `n Wargaming.net Game Center `n Skype for Desktop `n Gog Galaxy `n Epic Games Launcher `n Origin `n Steam `n Opera Browser Assistant `n uTorrent `n Skype for Business `n Google Chrome Installer `n Microsoft Edge Installer `n Discord Update `n Blitz")
})

$chck58 = New-CheckBox -Location '0,30' -Size '250,25' -Text 'Clean Temp/Cache/Prefetch/Logs' -TabID '57' -Check '$true'
$chck58.add_click({count_o})
$panel4.controls.add($chck58); 

$chck59 = New-CheckBox -Location '0,130' -Size '250,25' -Text 'Remove News and Interests/Widgets' -TabID '58'
$chck59.add_click({count_o})
$panel4.controls.add($chck59); 

$chck60 = New-CheckBox -Location '10,75' -Size '270,25' -Text 'Remove Microsoft OneDrive' -TabID '59'
$groupBox5.controls.add($chck60); 

$chck61 = New-CheckBox -Location '10,25' -Size '270,25' -Text 'Disable Xbox Services' -TabID '60'
$groupBox5.controls.add($chck61); 

$chck62 = New-CheckBox -Location '10,50' -Size '270,25' -Text 'Enable Fast/Secure DNS (1.1.1.1)' -TabID '61'
$groupBox5.controls.add($chck62); 

$chck63 = New-CheckBox -Location '0,80' -Size '250,25' -Text 'Scan for Adware (AdwCleaner)' -TabID '62'
$chck63.add_click({count_o})
$panel4.controls.add($chck63); 

$chck68 = New-CheckBox -Location '0,105' -Size '250,25' -Text 'Clean WinSxS Folder' -TabID '67'
$chck68.add_click({count_o})
$panel4.controls.add($chck68); 

$chck3 = New-CheckBox -Location '0,55' -Size '250,25' -Text 'Split Threshold for Svchost' -TabID '2' -Check '$true'
$chck3.add_click({count_o})
$panel4.controls.add($chck3); 

count_p;
count_v;
count_s;
count_o;

# Arguments off ET.ps1 /auto
$param1=$args[0]
if ($param1 -eq "/auto" -or $param1 -like "*auto") {do_start;}

function About {
$aboutForm = New-Object System.Windows.Forms.Form; 
$aboutFormExit = New-Object System.Windows.Forms.Button; 
$aboutFormNameLabel = New-Object System.Windows.Forms.Label; 
$aboutFormText = New-Object System.Windows.Forms.Label; 
$aboutFormText2 = New-Object System.Windows.Forms.Label; 
$aboutForm.MinimizeBox = $false; 
$aboutForm.MaximizeBox = $false; 
$aboutForm.TopMost = $true; 
$aboutForm.FlatStyle = 'Flat'
$aboutForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml($mainbackcolor)
$aboutForm.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)
$aboutForm.AutoSizeMode = 'GrowAndShrink'; 
$aboutForm.FormBorderStyle = 'FixedDialog'; 
$aboutForm.AcceptButton = $aboutFormExit; 
$aboutForm.CancelButton = $aboutFormExit; 
$aboutForm.ClientSize = '350, 110'; 
$aboutForm.ControlBox = $false; 
$aboutForm.ShowInTaskBar = $false; 
$aboutForm.StartPosition = 'CenterParent'; 
$aboutForm.Text = 'About'; 
$aboutForm.Add_Load($aboutForm_Load); 
$aboutFormNameLabel.Font = New-Object Drawing.Font('Consolas', 9, [System.Drawing.FontStyle]::Bold); 
$aboutFormNameLabel.Location = '110, 10'; 
$aboutFormNameLabel.Size = '200, 18'; 
$aboutFormNameLabel.Text = '  E.T. Optimizer'; 
$aboutForm.Controls.Add($aboutFormNameLabel); 
$aboutFormText.Location = '100, 30'; 
$aboutFormText.Size = '300, 20'; $aboutFormText.Text = '         Sebastian Mazurek'; 
$aboutForm.Controls.Add($aboutFormText); 
$aboutFormText2.Location = '100, 50'; 
$aboutFormText2.Size = '300, 20';  
$aboutFormText2.Text = '       github.com/semazurek'; 
$aboutFormText2.add_click({start http://github.com/semazurek});
$aboutForm.Controls.Add($aboutFormText2); 
$aboutFormExit.Location = '138, 75'; 
$aboutFormExit.Text = 'OK'; 
$aboutFormExit.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainbackcolor);
$aboutFormExit.BackColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor);
$aboutFormExit.FlatStyle = 'Flat'
$aboutForm.Icon = [System.Drawing.Icon]::FromHandle((new-object System.Drawing.Bitmap -argument $ims).GetHIcon())
$aboutForm.Controls.Add($aboutFormExit); 
[void]$aboutForm.ShowDialog()
}; 

function addMenuItem { param([ref]$ParentItem, [string]$ItemName='', [string]$ItemText='', [scriptblock]$ScriptBlock=$null ) [System.Windows.Forms.ToolStripMenuItem]$private:menuItem=` New-Object System.Windows.Forms.ToolStripMenuItem;
$private:menuItem.Name =$ItemName; 
$private:menuItem.Text =$ItemText; 
if ($ScriptBlock -ne $null) { $private:menuItem.add_Click(([System.EventHandler]$handler=` $ScriptBlock));}; 
if (($ParentItem.Value) -is [System.Windows.Forms.MenuStrip]) { ($ParentItem.Value).Items.Add($private:menuItem);} 
if (($ParentItem.Value) -is [System.Windows.Forms.ToolStripItem]) 
{ ($ParentItem.Value).DropDownItems.Add($private:menuItem); } 
return $private:menuItem; }; 
function Backup{[Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 1) | Out-Null;Enable-ComputerRestore -Drive $env:systemdrive; Checkpoint-Computer -Description "ET-RestorePoint" -RestorePointType "MODIFY_SETTINGS"; reg export HKLM $env:systemdrive\RegBackup-ET.reg; [Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 0) | Out-Null}; 
[System.Windows.Forms.MenuStrip]$mainMenu=New-Object System.Windows.Forms.MenuStrip; $form.Controls.Add($mainMenu); 
$mainMenu.BackColor = [System.Drawing.ColorTranslator]::FromHtml($menubackcolor);
$mainMenu.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor);
[scriptblock]$exit= {$form.Close()}; 
[scriptblock]$backup= {Backup}; 
[scriptblock]$restore= {rstrui.exe}; 
[scriptblock]$about= {About}; 
[scriptblock]$donate= {start https://www.buymeacoffee.com/semazurek}; 
[scriptblock]$ex1= {dfrgui.exe};
[scriptblock]$ex2= {cleanmgr.exe};
[scriptblock]$ex3= {msconfig};
[scriptblock]$ex4= {control.exe};
[scriptblock]$ex5= {devmgmt.msc};
[scriptblock]$ex6= {UserAccountControlSettings.exe};
[scriptblock]$ex7= {msinfo32};
[scriptblock]$ex8= {services.msc};
[scriptblock]$ex9= {mstsc};
[scriptblock]$ex10= {eventvwr.msc};
[scriptblock]$ex11= {netsh winsock reset;netsh int ipv4 reset;netsh int ipv6 reset;ipconfig /release;ipconfig /renew;ipconfig /flushdns};
[scriptblock]$ex12= {$jobwinget = Start-Job -Name jobwinget -ScriptBlock {Winget upgrade --all}};
[scriptblock]$ex13= {echo Windows_License_Key: $licensekey > C:\ProgramData\verwin.txt;start notepad C:\ProgramData\verwin.txt};
[scriptblock]$ex14= {shutdown /r /fw /t 1};
if ($langos -eq 'Polski') {
$mnuBackupT = 'Kopia Zapasowa'
$mnuRestoreT = 'Przywracanie'
$mnuExtrasT = 'Dodatki'
$mnuE1T = 'Defragmentacja Dysku'
$mnuE2T = 'Cleanmgr'
$mnuE3T = 'Msconfig'
$mnuE4T = 'Panel Sterowania'
$mnuE5T = 'Menedzer Urzadzen'
$mnuE6T = 'UAC Ustawienia'
$mnuE7T = 'Msinfo32'
$mnuE8T = 'Uslugi'
$mnuE9T = 'Pulpit Zdalny'
$mnuE10T = 'Podglad Zdarzen'
$mnuE11T = 'Reset Sieci'
$mnuE12T = 'Aktualizuj Aplikacje'
$mnuE13T = 'Klucz Licencyjny Windowsa'
$mnuE14T = 'Restart do BIOSu'
$mnuAboutT = 'O mnie'
$mnuDonateT = 'Wsparcie'  
$mnuExitT = 'Wyjdz'
}
else {
$mnuBackupT = 'Backup'
$mnuRestoreT = 'Restore'
$mnuExtrasT = 'Extras'
$mnuE1T = 'Disk Defragmenter'
$mnuE2T = 'Cleanmgr'
$mnuE3T = 'Msconfig'
$mnuE4T = 'Control Panel'
$mnuE5T = 'Device Manager'
$mnuE6T = 'UAC Settings'
$mnuE7T = 'Msinfo32'
$mnuE8T = 'Services'
$mnuE9T = 'Remote Desktop'
$mnuE10T = 'Event Viewer'
$mnuE11T = 'Reset Network'
$mnuE12T = 'Update Applications'
$mnuE13T = 'Windows License Key'
$mnuE14T = 'Reboot to BIOS'
$mnuAboutT = 'About'
$mnuDonateT = 'Donate'  
$mnuExitT = 'Exit'
}
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuBackup' -ItemText $mnuBackupT -ScriptBlock $backup); 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuRestore' -ItemText $mnuRestoreT -ScriptBlock $restore); 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuExtras' -ItemText $mnuExtrasT -ScriptBlock $null) | %{
$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuE1' -ItemText $mnuE1T -ScriptBlock $ex1;
$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuE2' -ItemText $mnuE2T -ScriptBlock $ex2;
$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuE3' -ItemText $mnuE3T -ScriptBlock $ex3;
$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuE4' -ItemText $mnuE4T -ScriptBlock $ex4;
$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuE5' -ItemText $mnuE5T -ScriptBlock $ex5;
$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuE6' -ItemText $mnuE6T -ScriptBlock $ex6;
$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuE7' -ItemText $mnuE7T -ScriptBlock $ex7;
$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuE8' -ItemText $mnuE8T -ScriptBlock $ex8;
$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuE9' -ItemText $mnuE9T -ScriptBlock $ex9;
$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuE10' -ItemText $mnuE10T -ScriptBlock $ex10;
$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuE11' -ItemText $mnuE11T -ScriptBlock $ex11;
$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuE12' -ItemText $mnuE12T -ScriptBlock $ex12;
$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuE13' -ItemText $mnuE13T -ScriptBlock $ex13;
$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuE14' -ItemText $mnuE14T -ScriptBlock $ex14;	} | Out-Null;
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuAbout' -ItemText $mnuAboutT -ScriptBlock $about);  
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuDonate' -ItemText $mnuDonateT -ScriptBlock $donate);  
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuExit' -ItemText $mnuExitT -ScriptBlock $exit); 
# Hello World
cls
$versionShort = $versionRAW.substring(9)
Write-Host '';Write-Host '';Write-Host '';Write-Host '';Write-Host '';
Write-Host '                                    ______  ______'
Write-Host '                                   / ____/ /_  __/'
Write-Host '                                  / __/     / /      '
Write-Host '                                 / /___    / /    '
Write-Host '                                /_____/   /_/     '
Write-Host ''
Write-Host '                          [-] Version: '$versionShort
Write-Host '                          [-] Build: Public                          '
Write-Host '                          [-] Created by: Rikey                      '
Write-Host '                          [-] Last update: 08.09.2024                '
Write-Host ''
Write-Host '                        - Always have a backup plan. - '
Write-Host '';Write-Host '';Write-Host '';Write-Host '';Write-Host ''

#Force backup at first use of script
if (!(Test-Path $Env:programdata\Run-ET.log))
{
	Enable-ComputerRestore -Drive $env:systemdrive >$null 2>$null
	$OriginalPref = $ProgressPreference # Default is 'Continue'
	$ProgressPreference = "SilentlyContinue"
	Checkpoint-Computer -Description "ET-RestorePoint" -RestorePointType "MODIFY_SETTINGS" -WarningAction SilentlyContinue
    #reg export HKLM $env:systemdrive\RegBackup-ET.reg >$null 2>$null
	$ProgressPreference = $OriginalPref
}

Write-Output "The script has already been initialized once" > $Env:programdata\Run-ET.log
[Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 0) | Out-Null
$form.ShowDialog();

# Counter of tasks
$counter=1
# All options to use: 67
$alltodo = (Get-ChildItem -Path $Env:programdata\ET\ | Measure-Object).Count

# VisualTweaks

function chck48 {
CleanFlag $MyInvocation.MyCommand
:: Show file extensions in Explorer
$counter++;
Write-Host ' [Setting] Show file extensions in Explorer ' -F blue -B black
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t  REG_DWORD /d 0 /f | Out-Null
engine;
};

function chck49 {
CleanFlag $MyInvocation.MyCommand
:: Disable Transparency in taskbar, menu start etc
$counter++;
Write-Host ' [Setting] Disable Transparency in taskbar/menu start ' -F blue -B black
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f | Out-Null
engine;
};

function chck50 {
CleanFlag $MyInvocation.MyCommand
::  Disable windows animations, menu Start animations.
$counter++;
Write-Host ' [Disable] Windows animations, menu Start animations ' -F darkgray -B black
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting  /t REG_DWORD /d 3 /f | Out-Null

REG ADD "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012078010000000 /f | Out-Null
REG ADD "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f | Out-Null

REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\AnimateMinMax" /v DefaultApplied  /t REG_DWORD /d 0 /f | Out-Null
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ComboBoxAnimation" /v DefaultApplied  /t REG_DWORD /d 0 /f | Out-Null
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ControlAnimations" /v DefaultApplied  /t REG_DWORD /d 0 /f | Out-Null
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\MenuAnimation" /v DefaultApplied  /t REG_DWORD /d 0 /f | Out-Null
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TaskbarAnimation" /v DefaultApplied  /t REG_DWORD /d 0 /f | Out-Null
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TooltipAnimation" /v DefaultApplied  /t REG_DWORD /d 0 /f | Out-Null
engine;
};

function chck51 {
CleanFlag $MyInvocation.MyCommand
# Disable MRU lists (jump lists) of XAML apps in Start Menu
$counter++;
Write-Host ' [Disable] MRU lists (jump lists) of XAML apps in Start Menu ' -F darkgray -B black
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f | Out-Null
engine;
};

function chck52 {
CleanFlag $MyInvocation.MyCommand
#  Hide the search box from taskbar. You can still search by pressing the Win key and start typing what you're looking for 
# 0 = hide completely, 1 = show only icon, 2 = show long search box
$counter++;
Write-Host ' [Setting] Hide the search box from taskbar. ' -F blue -B black
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f | Out-Null
engine;
};

function chck53 {
CleanFlag $MyInvocation.MyCommand
# Windows Explorer to start on This PC instead of Quick Access 
$counter++;
Write-Host ' [Setting] Windows Explorer to start on This PC instead of Quick Access ' -F blue -B black
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f | Out-Null
engine;
};


# PerformanceTweaks

function chck1{
CleanFlag $MyInvocation.MyCommand
# Disable Edge WebWidget
$counter++;
Write-Host ' [Disable] Edge WebWidget ' -F darkgray -B black
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v WebWidgetAllowed /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck2{
CleanFlag $MyInvocation.MyCommand
# Setting power option to high/ultimate performance
$counter++;
Write-Host ' [Setting] Power option to ultimate performance ' -F blue -B black
cmd /c powercfg -setactive scheme_min >$null 2>$null
cmd /c powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >$null 2>$null
cmd /c powercfg /S ceb6bfc7-d55c-4d56-ae37-ff264aade12d >$null 2>$null
cmd /c powercfg /X standby-timeout-ac 0 >$null 2>$null
cmd /c powercfg /X standby-timeout-dc 0 >$null 2>$null

powercfg -setactive scheme_min >$null 2>$null
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >$null 2>$null
powercfg /S ceb6bfc7-d55c-4d56-ae37-ff264aade12d >$null 2>$null
powercfg /X standby-timeout-ac 0 >$null 2>$null
powercfg /X standby-timeout-dc 0 >$null 2>$null

engine;};

function chck4{
CleanFlag $MyInvocation.MyCommand
# Dual boot timeout 3sec
$counter++;
Write-Host ' [Setting] Dual boot timeout 3sec ' -F blue -B black
bcdedit /set timeout 3 | Out-Null
bcdedit /timeout 3 | Out-Null
engine;};

function chck5{
CleanFlag $MyInvocation.MyCommand
# Disable Hibernation/Fast startup in Windows to free RAM from "C:\hiberfil.sys"
$counter++;
Write-Host ' [Disable] Hibernation/Fast startup in Windows ' -F darkgray -B black
powercfg -hibernate off | Out-Null
engine;};

function chck6{
CleanFlag $MyInvocation.MyCommand
# Disable windows insider experiments
$counter++;
Write-Host ' [Disable] Windows Insider experiments ' -F darkgray -B black
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t "REG_DWORD" /d "0" /f | Out-Null
engine;};

function chck7{
CleanFlag $MyInvocation.MyCommand
# Disable app launch tracking
$counter++;
Write-Host ' [Disable] App launch tracking ' -F darkgray -B black
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /d "0" /t REG_DWORD /f | Out-Null
engine;};

function chck8{
CleanFlag $MyInvocation.MyCommand
# Disable powerthrottling (Intel 6gen and higher)
$counter++;
Write-Host ' [Disable] Powerthrottling (Intel 6gen and higher) ' -F darkgray -B black
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f | Out-Null
engine;};

function chck9{
CleanFlag $MyInvocation.MyCommand
# Turn Off Background Apps
$counter++;
Write-Host ' [Setting] Turn Off Background Apps ' -F blue -B black
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled  /t REG_DWORD /d 1 /f | Out-Null
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v BackgroundAppGlobalToggle /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck10{
CleanFlag $MyInvocation.MyCommand
# Disable Sticky Keys prompt
$counter++;
Write-Host ' [Disable] Sticky Keys prompt ' -F darkgray -B black
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d 506 /f | Out-Null
engine;};

function chck11{
CleanFlag $MyInvocation.MyCommand
# Disable Activity History
$counter++;
Write-Host ' [Disable] Activity History ' -F darkgray -B black
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck12{
CleanFlag $MyInvocation.MyCommand
# Disable Automatic Updates for Microsoft Store apps
$counter++;
Write-Host ' [Disable] Automatic Updates for Microsoft Store apps ' -F darkgray -B black
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f | Out-Null
engine;};

function chck13{
CleanFlag $MyInvocation.MyCommand
# SmartScreen Filter for Store Apps: Disable
$counter++;
Write-Host ' [Disable] SmartScreen Filter for Store Apps ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck14{
CleanFlag $MyInvocation.MyCommand
# Let websites provide locally...
$counter++;
Write-Host ' [Setting] Let websites provide locally ' -F blue -B black
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f | Out-Null
engine;};

function chck15{
CleanFlag $MyInvocation.MyCommand
# Microsoft Edge settings
$counter++;
Write-Host ' [Setting] Microsoft Edge settings for privacy ' -F blue -B black
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v DoNotTrack /t REG_DWORD /d 1 /f | Out-Null
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\User\Default\SearchScopes" /v ShowSearchSuggestionsGlobal /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\FlipAhead" /v FPEnabled /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck64{
CleanFlag $MyInvocation.MyCommand
#	Disable Nagle's Algorithm (Delayed ACKs)
$counter++;
Write-Host ' [Disable] Nagle''s Algorithm (Delayed ACKs) ' -F darkgray -B black
$errpref = $ErrorActionPreference 
#save actual preference
$ErrorActionPreference = "silentlycontinue"
$NetworkIDS = @(
(Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\*").PSChildName
)
foreach ($NetworkID in $NetworkIDS) {
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$NetworkID" -Name "TcpAckFrequency" -Type DWord -Value 1
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$NetworkID" -Name "TCPNoDelay" -Type DWord -Value 1
}
$ErrorActionPreference = $errpref 
#restore previous preference
engine;};

function chck65{
CleanFlag $MyInvocation.MyCommand
#CPU Tweaks
$counter++;
Write-Host ' [Setting] CPU Priority Tweaks ' -F blue -B black

# Thread Priority
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\usbxhci\Parameters" /v ThreadPriority /t REG_DWORD /d 31 /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v ThreadPriority /t REG_DWORD /d 31 /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NDIS\Parameters" /v ThreadPriority /t REG_DWORD /d 31 /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v ThreadPriority /t REG_DWORD /d 31 /f | Out-Null

#All Logical Cores Enabled
$NOLP = wmic cpu get NumberOfLogicalProcessors | findstr /r "[0-9]"

cmd /c "bcdedit /set {current} numproc $NOLP" | Out-Null

# AMD/Intel CPU Priority
if (wmic cpu get name | findstr /r "Intel") {

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Affinity /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f | Out-Null
}
else
{
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f | Out-Null
}
engine;};

function chck66{
CleanFlag $MyInvocation.MyCommand
#	Disable Spectre/Meltdown Protection
$counter++;
Write-Host ' [Disable] Spectre/Meltdown Protection' -F darkgray -B black
	reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 3 /f | Out-Null
	reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f | Out-Null
engine;};

function chck16{
CleanFlag $MyInvocation.MyCommand
# Disable location sensor
$counter++;
Write-Host ' [Disable] Location sensor ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v SensorPermissionState /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck17{
CleanFlag $MyInvocation.MyCommand
# WiFi Sense: HotSpot Sharing: Disable
$counter++;
Write-Host ' [Disable] WiFi Sense: HotSpot Sharing ' -F darkgray -B black
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v value /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck18{
CleanFlag $MyInvocation.MyCommand
# WiFi Sense: Shared HotSpot Auto-Connect: Disable
$counter++;
Write-Host ' [Disable] WiFi Sense: Shared HotSpot Auto-Connect ' -F darkgray -B black
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v value /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck19{
CleanFlag $MyInvocation.MyCommand
# Change Windows Updates to "Notify to schedule restart"
$counter++;
Write-Host ' [Setting] Windows Updates to Notify to schedule restart ' -F blue -B black
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v UxOption /t REG_DWORD /d 1 /f | Out-Null
engine;};

function chck20{
CleanFlag $MyInvocation.MyCommand
# Disable P2P Update downloads outside of local network
$counter++;
Write-Host ' [Disable] P2P Update downloads outside of local network ' -F darkgray -B black
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck21{
CleanFlag $MyInvocation.MyCommand
# Setting Lower Shutdown time
$counter++;
Write-Host ' [Setting] Lower Shutdown time ' -F blue -B black
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d 2000 /f | Out-Null
engine;};

function chck22{
CleanFlag $MyInvocation.MyCommand
# Remove Old Device Drivers
$counter++;
Write-Host ' [Remove] Old Device Drivers ' -F red -B black
SET DEVMGR_SHOW_NONPRESENT_DEVICES=1
engine;};

function chck23{
CleanFlag $MyInvocation.MyCommand
# Disable Get Even More Out of Windows Screen /W10
$counter++;
Write-Host ' [Disable] Get Even More Out of Windows Screen ' -F darkgray -B black
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314559Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314563Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck24{
CleanFlag $MyInvocation.MyCommand
# Disable automatically installing suggested apps /W10
$counter++;
Write-Host ' [Disable] Automatically installing suggested apps ' -F darkgray -B black
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "FeatureManagementEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContentEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKLM\Software\Policies\Microsoft\PushToInstall" /v "DisablePushToInstall" /t REG_DWORD /d "1" /f | Out-Null
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions" /f >$null 2>$null
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /f >$null 2>$null
engine;};

function chck25{
CleanFlag $MyInvocation.MyCommand
# Disable Start Menu Ads/Suggestions /W10
$counter++;
Write-Host ' [Disable] Start Menu Ads/Suggestions ' -F darkgray -B black
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck26{
CleanFlag $MyInvocation.MyCommand
# Disable Allowing Suggested Apps In WindowsInk Workspace
$counter++;
Write-Host ' [Disable] Allowing Suggested Apps In WindowsInk Workspace ' -F darkgray -B black
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WindowsInkWorkspace\AllowSuggestedAppsInWindowsInkWorkspace" /v "value" /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck27{
CleanFlag $MyInvocation.MyCommand
# Disables several unnecessary components
$counter++;
Write-Host ' [Disable] Unnecessary components ' -F darkgray -B black
$components = @('Printing-PrintToPDFServices-Features','Printing-XPSServices-Features','Xps-Foundation-Xps-Viewer')
foreach ($a in $components) {
disable-windowsoptionalfeature -online -featureName $a -NoRestart | Out-Null
}
engine;};

function chck28{
CleanFlag $MyInvocation.MyCommand
# Setting Windows Defender Scheduled Scan from highest to normal privileges (CPU % high usage)
$counter++;
Write-Host ' [Setting] Windows Defender Scheduled Scan from highest to normal privileges ' -F blue -B black
cmd /c schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /RL LIMITED >$null 2>$null
engine;};

function chck29{
CleanFlag $MyInvocation.MyCommand
# Disabling Process Mitigation
# Audit exploit mitigations for increased process security or for converting existing Enhanced Mitigation Experience Toolkit
$counter++;
Write-Host ' [Disable] Process Mitigation ' -F darkgray -B black
Set-ProcessMitigation -System -Disable CFG
engine;};

function chck30{
CleanFlag $MyInvocation.MyCommand
# Defragmenting the File Indexing Service database file
$counter++;
Write-Host ' [Setting] Defragment Database Indexing Service File ' -F blue -B black 
net stop wsearch /y >$null 2>$null
esentutl /d C:\ProgramData\Microsoft\Search\Data\Applications\Windows\Windows.edb >$null 2>$null
net start wsearch >$null 2>$null
engine;};

#Telemetry

function chck31{
CleanFlag $MyInvocation.MyCommand
# SCHEDULED TASKS tweaks (Updates, Telemetry etc)
$counter++;
Write-Host ' [Disable] SCHEDULED TASKS tweaks (Updates, Telemetry etc) ' -F darkgray -B black
cmd /c schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvent" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyUpload" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack2016" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn2016" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Office\Office 16 Subscription Heartbeat" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "NIUpdateServiceStartupTask" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "CCleaner Update" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "CCleanerCrashReportings" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "CCleanerSkipUAC - $env:username" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "updater" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Adobe Acrobat Update Task" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "MicrosoftEdgeUpdateTaskMachineCore" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "MicrosoftEdgeUpdateTaskMachineUA" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "MiniToolPartitionWizard" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "AMDLinkUpdate" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Office\Office Automatic Updates 2.0" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Office\Office Feature Updates" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "Microsoft\Office\Office Feature Updates Logon" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "GoogleUpdateTaskMachineCore" /Disable >$null 2>$null
cmd /c schtasks /Change /TN "GoogleUpdateTaskMachineUA" /Disable >$null 2>$null
cmd /c schtasks /DELETE /TN "AMDInstallLauncher" /f >$null 2>$null
cmd /c schtasks /DELETE /TN "AMDLinkUpdate" /f >$null 2>$null
cmd /c schtasks /DELETE /TN "AMDRyzenMasterSDKTask" /f >$null 2>$null
cmd /c schtasks /DELETE /TN "DUpdaterTask" /f >$null 2>$null
cmd /c schtasks /DELETE /TN "ModifyLinkUpdate" /f >$null 2>$null
engine;};

function chck32{
CleanFlag $MyInvocation.MyCommand
# Remove Telemetry & Data Collection 
$counter++;
Write-Host ' [Disable] Telemetry/Data Collection ' -F darkgray -B black 

del /q "%temp%\NVIDIA Corporation\NV_Cache\*" >$null 2>$null
del /q "%programdata%\NVIDIA Corporation\NV_Cache\*" >$null 2>$null

REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v OptInOrOutPreference /t REG_DWORD /d 0 /f | Out-Null
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\NVIDIA Corporation\Global\FTS" /v EnableRID44231 /t REG_DWORD /d 0 /f | Out-Null
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\NVIDIA Corporation\Global\FTS" /v EnableRID64640 /t REG_DWORD /d 0 /f | Out-Null
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\NVIDIA Corporation\Global\FTS" /v EnableRID66610 /t REG_DWORD /d 0 /f | Out-Null
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NvTelemetryContainer" /v Start /t REG_DWORD /d 4 /f | Out-Null

REG ADD "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoInstrumentation /t REG_DWORD /d 1 /f | Out-Null
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoInstrumentation /t REG_DWORD /d 1 /f | Out-Null
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v PreventHandwritingErrorReports /t REG_DWORD /d 1 /f | Out-Null
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f | Out-Null
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowDeviceNameInTelemetry /t REG_DWORD /d 0 /f | Out-Null
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v SmartScreenEnabled /t REG_SZ /d "Off" /f | Out-Null
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f | Out-Null
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v HideRecentlyAddedApps /t REG_DWORD /d 1 /f | Out-Null
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v NoActiveHelp /t REG_DWORD /d 1 /f | Out-Null

REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl\StorageTelemetry" /v DeviceDumpEnabled /t REG_DWORD /d 0 /f | Out-Null | Out-Null
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CompatTelRunner.exe" /v Debugger /t REG_SZ /d "%windir%\System32\taskkill.exe" /f | Out-Null
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DeviceCensus.exe" /v Debugger /t REG_SZ /d "%windir%\System32\taskkill.exe" /f | Out-Null

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f | Out-Null
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\SYSTEM\ControlSet001\Services\dmwappushservice" /v "Start" /t REG_DWORD /d 4 /f | Out-Null
reg add "HKLM\SYSTEM\ControlSet001\Services\DiagTrack" /v "Start" /t REG_DWORD /d 4 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" /v "DisableTelemetry" /t REG_DWORD /d 1 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" /v "DisableTelemetry" /t REG_DWORD /d 1 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\17.0\Common\ClientTelemetry" /v "DisableTelemetry" /t REG_DWORD /d 1 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" /v "VerboseLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" /v "VerboseLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" /v "EnableLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" /v "EnableLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" /v "EnableCalendarLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" /v "EnableCalendarLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Word\Options" /v "EnableLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Word\Options" /v "EnableLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\17.0\Word\Options" /v "EnableLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" /v "EnableLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" /v "EnableLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\17.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Common\Feedback" /v "Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Feedback" /v "Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Common" /v "QMEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common" /v "QMEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\17.0\Common" /v "QMEnabled" /t REG_DWORD /d 0 /f | Out-Null
# VStudio Code Telemetry
cmd /c sc stop VSStandardCollectorService150 | Out-Null
cmd /c sc config VSStandardCollectorService150 start= disabled  | Out-Null
reg add "HKLM\Software\Wow6432Node\Microsoft\VSCommon\14.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Wow6432Node\Microsoft\VSCommon\15.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Wow6432Node\Microsoft\VSCommon\16.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Wow6432Node\Microsoft\VSCommon\17.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Microsoft\VSCommon\14.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Microsoft\VSCommon\15.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Microsoft\VSCommon\16.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Microsoft\VSCommon\17.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Microsoft\VisualStudio\Telemetry" /v "TurnOffSwitch" /t REG_DWORD /d 1 /f | Out-Null
reg add "HKLM\Software\Policies\Microsoft\VisualStudio\Feedback" /v "DisableFeedbackDialog" /t REG_DWORD /d 1 /f | Out-Null
reg add "HKLM\Software\Policies\Microsoft\VisualStudio\Feedback" /v "DisableEmailInput" /t REG_DWORD /d 1 /f | Out-Null
reg add "HKLM\Software\Policies\Microsoft\VisualStudio\Feedback" /v "DisableScreenshotCapture" /t REG_DWORD /d 1 /f | Out-Null
# Chrome Software Reporter Tool
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "MetricsReportingEnabled" /t REG_SZ /d 0 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "ChromeCleanupEnabled" /t REG_SZ /d 0 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "ChromeCleanupReportingEnabled" /t REG_SZ /d 0 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "MetricsReportingEnabled" /t REG_SZ /d 0 /f | Out-Null
# CCleaner Health Check / Monitoring etc
cmd /c taskkill /f /im ccleaner.exe >$null 2>$null
cmd /c taskkill /f /im ccleaner64.exe >$null 2>$null
reg add "HKCU\Software\Piriform\CCleaner" /v "HomeScreen" /t REG_SZ /d 2 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "Monitoring" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "HelpImproveCCleaner" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "SystemMonitoring" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "UpdateAuto" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "UpdateCheck" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "CheckTrialOffer" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "(Cfg)HealthCheck" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "(Cfg)QuickClean" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "(Cfg)QuickCleanIpm" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "(Cfg)SoftwareUpdater" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "(Cfg)SoftwareUpdaterIpm" /t REG_DWORD /d 0 /f | Out-Null

engine;};

function chck33{
CleanFlag $MyInvocation.MyCommand
# Disable PowerShell Telemetry
$counter++;
Write-Host ' [Disable] PowerShell Telemetry ' -F darkgray -B black
setx POWERSHELL_TELEMETRY_OPTOUT 1 | Out-Null
engine;};

function chck34{
CleanFlag $MyInvocation.MyCommand
# Disable Skype Telemetry
$counter++;
Write-Host ' [Disable] Skype Telemetry ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW" /v "TraceLevelThreshold" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype" /v "EnableTracing" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW" /v "EnableTracing" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype" /v "WPPFilePath" /t REG_SZ /d "%%SYSTEMDRIVE%%\TEMP\Tracing\WPPMedia" /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW" /v "WPPFilePath" /t REG_SZ /d "%%SYSTEMDRIVE%%\TEMP\WPPMedia" /f | Out-Null
engine;};

function chck35{
CleanFlag $MyInvocation.MyCommand
# Disable windows media player usage reports
$counter++;
Write-Host ' [Disable] Windows media player usage reports ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d "0" /f | Out-Null
engine;};

function chck36{
CleanFlag $MyInvocation.MyCommand
# Disable mozilla telemetry
$counter++;
Write-Host ' [Disable] Mozilla telemetry ' -F darkgray -B black
reg add HKLM\SOFTWARE\Policies\Mozilla\Firefox /v "DisableTelemetry" /t REG_DWORD /d "2" /f | Out-Null
engine;};

function chck37{
CleanFlag $MyInvocation.MyCommand
# Settings -> Privacy -> General -> Let apps use my advertising ID...
$counter++;
Write-Host ' [Disable] Let apps use my advertising ID ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\AdvertisingInfo" /v "Value" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /t REG_SZ /d "Deny" /f | Out-Null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /t REG_SZ /d "Deny" /f | Out-Null
engine;};

function chck38{
CleanFlag $MyInvocation.MyCommand
# Send Microsoft info about how I write to help us improve typing and writing in the future
$counter++;
Write-Host ' [Disable] Send Microsoft info about how I write ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck39{
CleanFlag $MyInvocation.MyCommand
# Handwriting recognition personalization
$counter++;
Write-Host ' [Disable] Handwriting recognition personalization ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f | Out-Null
engine;};

function chck40{
CleanFlag $MyInvocation.MyCommand
# Disable watson malware reports
$counter++;
Write-Host ' [Disable] Watson malware reports ' -F darkgray -B black
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "DisableGenericReports" /t REG_DWORD /d "2" /f | Out-Null
engine;};

function chck41{
CleanFlag $MyInvocation.MyCommand
# Disable malware diagnostic data 
$counter++;
Write-Host ' [Disable] Malware diagnostic data ' -F darkgray -B black 
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d "2" /f | Out-Null
engine;};

function chck42{
CleanFlag $MyInvocation.MyCommand
# Disable  setting override for reporting to Microsoft MAPS
$counter++;
Write-Host ' [Disable] Setting override for reporting to Microsoft MAPS ' -F darkgray -B black
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "LocalSettingOverrideSpynetReporting" /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck43{
CleanFlag $MyInvocation.MyCommand
# Disable spynet Defender reporting
$counter++;
Write-Host ' [Disable] Spynet Defender reporting ' -F darkgray -B black
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck44{
CleanFlag $MyInvocation.MyCommand
# Do not send malware samples for further analysis
$counter++;
Write-Host ' [Setting] Do not send malware samples for further analysis ' -F blue -B black
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "2" /f | Out-Null
engine;};

function chck45{
CleanFlag $MyInvocation.MyCommand
# Prevents sending speech, inking and typing samples to MS (so Cortana can learn to recognise you)
$counter++;
Write-Host ' [Disable] Sending speech, inking and typing samples to MS ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck46{
CleanFlag $MyInvocation.MyCommand
# Prevents sending contacts to MS (so Cortana can compare speech etc samples)
$counter++;
Write-Host ' [Disable] Sending contacts to MS ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v HarvestContacts /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck47{
CleanFlag $MyInvocation.MyCommand
# Immobilise Cortana 
$counter++;
Write-Host ' [Disable] Cortana ' -F darkgray -B black
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f | Out-Null
engine;};

#WindowsGameBar

function chck54{
CleanFlag $MyInvocation.MyCommand
# Removing Windows Game Bar 
$counter++;
Write-Host ' [Remove] Windows Game Bar ' -F red -B black
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f | Out-Null
Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage
Get-AppxPackage *XboxGameOverlay* | Remove-AppxPackage
Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage
engine;};

#RemoveWidgets

function chck59{
CleanFlag $MyInvocation.MyCommand
# Remove News and Interests/Widgets from Win 11 (even if not shown on taskbar, that takes RAM/CPU running in background)
$counter++;
Write-Host ' [Remove] News and Interests/Widgets' -F red -B black
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f | Out-Null

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f | Out-Null
winget uninstall "windows web experience pack" --accept-source-agreements | Out-Null

engine;};

#Services

function chck55{
CleanFlag $MyInvocation.MyCommand
# Disable
$counter++;
Write-Host ' [Setting] Services to: Disable Mode ' -F blue -B black
$toDisable = @('DiagTrack','diagnosticshub.standardcollector.service','dmwappushservice','RemoteRegistry','RemoteAccess','SCardSvr','SCPolicySvc','fax','WerSvc','NvTelemetryContainer','gadjservice','AdobeARMservice','PSI_SVC_2','lfsvc','WalletService','RetailDemo','SEMgrSvc','diagsvc','AJRouter','amdfendr','amdfendrmgr')
foreach ($b in $toDisable) {
   cmd /c sc stop $b | Out-Null
   cmd /c sc config $b start= disabled | Out-Null
}
#Disable Network Diagnostic Usage Service
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Ndu" /v "Start" /t REG_DWORD /d 4 /f | Out-Null

# Manuall
Write-Host ' [Setting] Services to: Manuall Mode ' -F blue -B black
$toManuall = @('BITS','SamSs','TapiSrv','seclogon','wuauserv','PhoneSvc','lmhosts','iphlpsvc','gupdate','gupdatem','edgeupdate','edgeupdatem','MapsBroker','PnkBstrA','brave','bravem','asus','asusm','adobeupdateservice','adobeflashplayerupdatesvc','WSearch','CCleanerPerformanceOptimizerService')
foreach ($c in $toManuall) {
   cmd /c sc config $c start= demand | Out-Null
}
engine;};

:Bloatware

function chck56{
CleanFlag $MyInvocation.MyCommand
# Remove Bloatware Apps (Preinstalled) 108 apps
Write-Host ' [Remove] Bloatware Apps ' -F red -B black
$counter++;
$whitelistapps = @(
    # Whitelist apps
"Microsoft.MicrosoftOfficeHub"
"Microsoft.Office.OneNote"
"Microsoft.WindowsAlarms"
"Microsoft.WindowsCalculator"
"Microsoft.WindowsCamera"
"microsoft.windowscommunicationsapps"
"Microsoft.NET.Native.Framework.2.2"
"Microsoft.NET.Native.Framework.2.0"
"Microsoft.NET.Native.Runtime.2.2"
"Microsoft.NET.Native.Runtime.2.0"
"Microsoft.UI.Xaml.2.7"
"Microsoft.UI.Xaml.2.0"
"Microsoft.WindowsAppRuntime.1.3"
"Microsoft.NET.Native.Framework.1.7"
"MicrosoftWindows.Client.Core"
"Microsoft.LockApp"
"Microsoft.ECApp"
"Microsoft.Windows.ContentDeliveryManager"
"Microsoft.Windows.Search"
"Microsoft.Windows.OOBENetworkCaptivePortal"    
"Microsoft.Windows.SecHealthUI"
"Microsoft.SecHealthUI"
"Microsoft.WindowsAppRuntime.CBS"
"Microsoft.VCLibs.140.00.UWPDesktop"
"Microsoft.VCLibs.120.00.UWPDesktop"
"Microsoft.VCLibs.110.00.UWPDesktop"
"Microsoft.DirectXRuntime"
"Microsoft.XboxGameOverlay"
"Microsoft.XboxGamingOverlay"
"Microsoft.GamingApp"
"Microsoft.GamingServices"
"Microsoft.XboxIdentityProvider"
"Microsoft.Xbox.TCUI"
"Microsoft.AccountsControl"
"Microsoft.WindowsStore"
"Microsoft.StorePurchaseApp"
"Microsoft.VP9VideoExtensions"
"Microsoft.RawImageExtension"
"Microsoft.HEIFImageExtension"
"Microsoft.HEIFImageExtension"
"Microsoft.WebMediaExtensions"
"RealtekSemiconductorCorp.RealtekAudioControl"
"Microsoft.MicrosoftEdge"
"Microsoft.MicrosoftEdge.Stable"
"MicrosoftWindows.Client.FileExp"
"NVIDIACorp.NVIDIAControlPanel"
"AppUp.IntelGraphicsExperience"
"Microsoft.Paint"
"Microsoft.Messaging"
"Microsoft.AsyncTextService"
"Microsoft.CredDialogHost"
"Microsoft.Win32WebViewHost"
"Microsoft.MicrosoftEdgeDevToolsClient"
"Microsoft.Windows.OOBENetworkConnectionFlow"
"Microsoft.Windows.PeopleExperienceHost"
"Microsoft.Windows.PinningConfirmationDialog"
"Microsoft.Windows.SecondaryTileExperience"
"Microsoft.Windows.SecureAssessmentBrowser"
"Microsoft.Windows.ShellExperienceHost"
"Microsoft.Windows.StartMenuExperienceHost"
"Microsoft.Windows.XGpuEjectDialog"
"Microsoft.XboxGameCallableUI"
"MicrosoftWindows.UndockedDevKit"
"NcsiUwpApp"
"Windows.CBSPreview"
"Windows.MiracastView"
"Windows.ContactSupport"
"Windows.PrintDialog"
"c5e2524a-ea46-4f67-841f-6a9465d9d515"
"windows.immersivecontrolpanel"
"WinRAR.ShellExtension"
"Microsoft.WindowsNotepad"
"MicrosoftWindows.Client.WebExperience"
"Microsoft.ZuneMusic"
"Microsoft.ZuneVideo"
"Microsoft.OutlookForWindows"
"MicrosoftWindows.Ai.Copilot.Provider"
"Microsoft.WindowsTerminal"
"Microsoft.Windows.Terminal"
"WindowsTerminal"
"Microsoft.Winget.Source"
"Microsoft.DesktopAppInstaller"
"Microsoft.Services.Store.Engagement"
"Microsoft.HEVCVideoExtension"
"Microsoft.WebpImageExtension"
"MicrosoftWindows.CrossDevice"
"NotepadPlusPlus"
"MicrosoftCorporationII.WinAppRuntime.Main.1.5"
"Microsoft.WindowsAppRuntime.1.5"
"MicrosoftCorporationII.WinAppRuntime.Singleton"
"Microsoft.WindowsSoundRecorder"
"MicrosoftCorporationII.WinAppRuntime.Main.1.4"
"MicrosoftWindows.Client.LKG"
"MicrosoftWindows.Client.CBS"
"Microsoft.VCLibs.140.00"
"Microsoft.Windows.CloudExperienceHost"
 "SpotifyAB.SpotifyMusic"
 "Microsoft.SkypeApp"
 "5319275A.WhatsAppDesktop"
 "FACEBOOK.317180B0BB486"
 "TelegramMessengerLLP.TelegramDesktop"
 "4DF9E0F8.Netflix"
 "Discord"
 "Paint"
 "mspaint"
 "Microsoft.Windows.Paint"
)

$RemoveAppPkgs = (Get-AppxPackage -AllUsers).Name

ForEach($TargetApp in $RemoveAppPkgs)
{
    If($whitelistapps -notcontains $TargetApp)
    {

        Get-AppxPackage -Name $TargetApp -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue

        Get-AppXProvisionedPackage -Online |
            Where-Object DisplayName -EQ $TargetApp |
            Remove-AppxProvisionedPackage -Online | Out-Null
    }
}

engine;};

#StartUp

function chck57{
CleanFlag $MyInvocation.MyCommand
# Disabling unnecessary applications at startup
$counter++;
Write-Host ' [Disable] Unnecessary applications at startup ' -F darkgray -B black

# Java Update Checker x64
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "SunJavaUpdateSched" /f >$null 2>$null
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SunJavaUpdateSched" /f >$null 2>$null


# Mini Partition Tool Wizard Updater
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MTPW" /f >$null 2>$null

# Teams Machine Installer
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "TeamsMachineInstaller" /f >$null 2>$null
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TeamsMachineInstaller" /f >$null 2>$null


# Cisco Meeting Daemon
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "CiscoMeetingDaemon" /f >$null 2>$null

# Adobe Reader Speed Launcher
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Adobe Reader Speed Launcher" /f >$null 2>$null
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Adobe Reader Speed Launcher" /f >$null 2>$null


# CCleaner Smart Cleaning/Monitor
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "CCleaner Smart Cleaning" /f >$null 2>$null
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "CCleaner Monitor" /f >$null 2>$null

# Spotify Web Helper
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Spotify Web Helper" /f >$null 2>$null

# Gaijin.Net Updater
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Gaijin.Net Updater" /f >$null 2>$null

# Microsoft Teams Update
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "com.squirrel.Teams.Teams" /f >$null 2>$null

# Google Update
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Google Update" /f >$null 2>$null

# BitTorrent Bleep
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "BitTorrent Bleep" /f >$null 2>$null

# Skype
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Skype" /f >$null 2>$null

# Adobe Update Startup Utility
cmd /c reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "adobeAAMUpdater-1.0" /f >$null 2>$null
cmd /c reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "AdobeAAMUpdater" /f >$null 2>$null

# iTunes Helper
cmd /c reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "iTunesHelper" /f >$null 2>$null

# CyberLink Update Utility
cmd /c reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "UpdatePPShortCut" /f >NUL 2>nul

# MSI Live Update
cmd /c reg delete "HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Live Update" /f >$null 2>$null
cmd /c reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "Live Update" /f >$null 2>$null


# Wondershare Helper Compact
cmd /c reg delete "HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Wondershare Helper Compact" /f >$null 2>$null
cmd /c reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "Wondershare Helper Compact" /f >$null 2>$null


# Cisco AnyConnect Secure Mobility Agent
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Cisco AnyConnect Secure Mobility Agent for Windows" /f >$null 2>$null
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Cisco AnyConnect Secure Mobility Agent for Windows" /f >$null 2>$null


# Opera Browser Assistant (Update/Tray)
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Opera Browser Assistant" /f >$null 2>$null

# Steam Autorun
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Steam" /f >$null 2>$null

# Origin Autorun
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "EADM" /f >$null 2>$null

# Epic Games Launcher Autorun
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "EpicGamesLauncher" /f >$null 2>$null

# Gog Galaxy Autorun
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "GogGalaxy" /f >$null 2>$null

# Skype for Desktop Autorun
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Skype for Desktop" /f >$null 2>$null

# Wargaming.net Game Center
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Wargaming.net Game Center" /f >$null 2>$null

# uTorrent Autorun
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "ut" /f >$null 2>$null

# Lync - Skype for Business Autorun
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Lync" /f >$null 2>$null

# Google Chrome Installer (Update)
cmd /c reg delete "HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components" /v "Google Chrome" /f >$null 2>$null

# Microsoft Edge Installer (Update)
cmd /c reg delete "HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components" /v "Microsoft Edge" /f >$null 2>$null
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch_E9C49D8E9BDC4095F482C844743B9E82" /f >$null 2>$null
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch_D3AB3F7FBB44621987441AECEC1156AD" /f >$null 2>$null
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch" /f >$null 2>$null
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Microsoft Edge Update" /f >$null 2>$null
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch_31CF12C7FD715D87B15C2DF57BBF8D3E" /f >$null 2>$null

# Discord Update
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Discord" /f >$null 2>$null

# Ubisoft Game Launcher
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Ubisoft Game Launcher" /f >$null 2>$null

# Bliz - Autorun (League of Legends Tool)
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "com.blitz.app" /f >$null 2>$null

engine;};

#Cleaning

function chck58{
CleanFlag $MyInvocation.MyCommand
# TEMP/Logs/Cache/Prefetch/Updates Cleaning
$counter++;

Write-Host ' [Clean] Temp ' -F yellow -B black
Get-ChildItem -Path $env:TEMP -Include *.* -Exclude *.bat, *.lbool -File -Recurse | foreach { $_.Delete()} | Out-Null
cmd /c Del /S /F /Q %Windir%\Temp >$null 2>$null

Write-Host ' [Clean] Windows Prefetch/Cache/Logs ' -F yellow -B black

cmd /c del /q "%temp%\NVIDIA Corporation\NV_Cache\*"  >$null 2>$null
cmd /c del /q "%programdata%\NVIDIA Corporation\NV_Cache\*" >$null 2>$null

del /s /f /q "%userprofile%\Recent\*.*" >$null 2>$null

erase /f /s /q "%systemdrive%\Windows\SoftwareDistribution\*.*" >$null 2>$null
rmdir /s /q "%systemdrive%\Windows\SoftwareDistribution" >$null 2>$null

cmd /c Del /S /F /Q %windir%\Prefetch >$null 2>$null

cmd /c Del %AppData%\vstelemetry >$null 2>$null
cmd /c Del %LocalAppData%\Microsoft\VSApplicationInsights /F /Q /S >$null 2>$null
cmd /c Del %ProgramData%\Microsoft\VSApplicationInsights  /F /Q /S >$null 2>$null
cmd /c Del %Temp%\Microsoft\VSApplicationInsights /F /Q /S >$null 2>$null
cmd /c Del %Temp%\VSFaultInfo /F /Q /S >$null 2>$null
cmd /c Del %Temp%\VSFeedbackPerfWatsonData /F /Q /S >$null 2>$null
cmd /c Del %Temp%\VSFeedbackVSRTCLogs /F /Q /S >$null 2>$null
cmd /c Del %Temp%\VSRemoteControl /F /Q /S >$null 2>$null
cmd /c Del %Temp%\VSTelem /F /Q /S >$null 2>$null
cmd /c Del %Temp%\VSTelem.Out /F /Q /S >$null 2>$null

cmd /c Del %localappdata%\Yarn\Cache /F /Q /S >$null 2>$null

cmd /c Del %appdata%\Microsoft\Teams\Cache /F /Q /S >$null 2>$null

cmd /c Del %programdata%\GOG.com\Galaxy\webcache /F /Q /S >$null 2>$null
cmd /c Del %programdata%\GOG.com\Galaxy\logs /F /Q /S >$null 2>$null

cmd /c Del %localappdata%\Microsoft\Windows\WebCache /F /Q /S >$null 2>$null

cmd /c Del "%SystemDrive%\*.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\Directx.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\SchedLgU.txt" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\*.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\security\logs\*.old" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\security\logs\*.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\Debug\*.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\Debug\UserMode\*.bak" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\Debug\UserMode\*.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\*.bak" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\system32\wbem\Logs\*.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\OEWABLog.txt" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\setuplog.txt" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\Logs\DISM\*.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\*.log.txt" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\APPLOG\*.*" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\system32\wbem\Logs\*.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\system32\wbem\Logs\*.lo_" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\Logs\DPX\*.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\ServiceProfiles\NetworkService\AppData\Local\Temp\*.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\Logs\*.log" /F /Q >$null 2>$null
cmd /c Del "%LocalAppData%\Microsoft\Windows\WindowsUpdate.log" /F /Q >$null 2>$null
cmd /c Del "%LocalAppData%\Microsoft\Windows\WebCache\*.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\Panther\cbs.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\Panther\DDACLSys.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\repair\setup.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\Panther\UnattendGC\diagerr.xml" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\Panther\UnattendGC\diagwrn.xml" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\inf\setupapi.offline.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\inf\setupapi.app.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\debug\WIA\*.log" /F /Q >$null 2>$null
cmd /c Del "%SystemDrive%\PerfLogs\System\Diagnostics\*.*" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\Logs\CBS\*.cab" /F /Q  >$null 2>$null
cmd /c Del "%WinDir%\Logs\CBS\*.cab" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\Logs\WindowsBackup\*.etl" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\System32\LogFiles\HTTPERR\*.*" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\SysNative\SleepStudy\*.etl" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\SysNative\SleepStudy\ScreenOn\*.etl" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\System32\SleepStudy\*.etl" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\System32\SleepStudy\ScreenOn\*.etl" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\Logs" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\DISM" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\System32\catroot2\*.chk" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\System32\catroot2\*.log" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\System32\catroot2\.jrs" /F /Q >$null 2>$null
cmd /c Del "%WinDir%\System32\catroot2\*.txt" /F /Q >$null 2>$null

# Cleaning Disk - cleanmgr
start cleanmgr.exe /sagerun:5

Write-Host ' [Clean] Games Platforms Cache/Logs ' -F yellow -B black

cmd /c Del %localappdata%\EpicGamesLauncher\Saved\Logs /F /Q /S >$null 2>$null
cmd /c Del %localappdata%\CrashReportClient\Saved\Logs /F /Q /S >$null 2>$null

cmd /c Del "%localappdata%\Steam\htmlcache\Code Cache" /F /Q /S >$null 2>$null
cmd /c Del %localappdata%\Steam\htmlcache\GPUCache /F /Q /S >$null 2>$null
cmd /c Del %localappdata%\Steam\htmlcache\Cache /F /Q /S >$null 2>$null

cmd /c Del %AppData%\Origin\Telemetry /F /Q /S >$null 2>$null
cmd /c Del %AppData%\Origin\Logs /F /Q /S >$null 2>$null
cmd /c Del %AppData%\Origin\NucleusCache /F /Q /S >$null 2>$null
cmd /c Del %AppData%\Origin\ConsolidatedCache /F /Q /S >$null 2>$null
cmd /c Del %AppData%\Origin\CatalogCache /F /Q /S >$null 2>$null
cmd /c Del %localAppData%\Origin\ThinSetup /F /Q /S >$null 2>$null
cmd /c Del %AppData%\Origin\Telemetry /F /Q /S >$null 2>$null
cmd /c Del %localAppData%\Origin\Logs /F /Q /S >$null 2>$null

cmd /c Del %localAppData%\Battle.net\Cache /F /Q /S >$null 2>$null
cmd /c Del %AppData%\Battle.net\Logs /F /Q /S >$null 2>$null
cmd /c Del %AppData%\Battle.net\Errors /F /Q /S >$null 2>$null

Write-Host ' [Clean] Web Browsers Cache/Logs ' -F yellow -B black

cmd /c Del "%LocalAppData%\Google\Chrome\User Data\Default\Cache" /F /Q /S >$null 2>$null
cmd /c Del "%LocalAppData%\Google\Chrome\User Data\Default\Media Cache" /F /Q /S >$null 2>$null
cmd /c Del "%LocalAppData%\Google\Chrome\User Data\Default\GPUCache" /F /Q /S >$null 2>$null
cmd /c Del "%LocalAppData%\Google\Chrome\User Data\Default\Storage\ext" /F /Q /S >$null 2>$null
cmd /c Del "%LocalAppData%\Google\Chrome\User Data\Default\Service Worker" /F /Q /S >$null 2>$null
cmd /c Del "%LocalAppData%\Google\Chrome\User Data\ShaderCache" /F /Q /S >$null 2>$null


cmd /c Del "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache" /F /Q /S >$null 2>$null
cmd /c Del "%LocalAppData%\Microsoft\Edge\User Data\Default\Media Cache" /F /Q /S >$null 2>$null
cmd /c Del "%LocalAppData%\Microsoft\Edge\User Data\Default\GPUCache" /F /Q /S >$null 2>$null
cmd /c Del "%LocalAppData%\Microsoft\Edge\User Data\Default\Storage\ext" /F /Q /S >$null 2>$null
cmd /c Del "%LocalAppData%\Microsoft\Edge\User Data\Default\Service Worker" /F /Q /S >$null 2>$null
cmd /c Del "%LocalAppData%\Microsoft\Edge\User Data\ShaderCache" /F /Q /S >$null 2>$null
cmd /c Del "%LocalAppData%\Microsoft\Edge SxS\User Data\Default\Cache" /F /Q /S >$null 2>$null
cmd /c Del "%LocalAppData%\Microsoft\Edge SxS\User Data\Default\Media Cache" /F /Q /S >$null 2>$null
cmd /c Del "%LocalAppData%\Microsoft\Edge SxS\User Data\Default\GPUCache" /F /Q /S >$null 2>$null
cmd /c Del "%LocalAppData%\Microsoft\Edge SxS\User Data\Default\Storage\ext" /F /Q /S >$null 2>$null
cmd /c Del "%LocalAppData%\Microsoft\Edge SxS\User Data\Default\Service Worker" /F /Q /S >$null 2>$null
cmd /c Del "%LocalAppData%\Microsoft\Edge SxS\User Data\ShaderCache" /F /Q /S >$null 2>$null

cmd /c Del "%LocalAppData%\Opera Software\Opera Stable\cache" /F /Q /S >$null 2>$null
cmd /c Del "%AppData%\Opera Software\Opera Stable\GPUCache" /F /Q /S >$null 2>$null
cmd /c Del "%AppData%\Opera Software\Opera Stable\ShaderCache" /F /Q /S >$null 2>$null
cmd /c Del "%AppData%\Opera Software\Opera Stable\Jump List Icons" /F /Q /S >$null 2>$null
cmd /c Del "%AppData%\Opera Software\Opera Stable\Jump List IconsOld\Jump List Icons" /F /Q /S >$null 2>$null

cmd /c Del "%LocalAppData%\Vivaldi\User Data\Default\Cache" /F /Q /S >$null 2>$null

Write-Host ' [Clean] Windows Font Cache ' -F yellow -B black

cmd /c net stop FontCache >$null 2>$null
cmd /c net stop FontCache3.0.0.0 >$null 2>$null
cmd /c Del "%WinDir%\ServiceProfiles\LocalService\AppData\Local\FontCache\*.dat" /F /Q /S >$null 2>$null
cmd /c Del "%WinDir%\SysNative\FNTCACHE.DAT" /F /Q /S >$null 2>$null
cmd /c Del "%WinDir%\System32\FNTCACHE.DAT" /F /Q /S >$null 2>$null
cmd /c net start FontCache >$null 2>$null
cmd /c net start FontCache3.0.0.0 >$null 2>$null

Write-Host ' [Clean] Windows Icon Cache ' -F yellow -B black

%WinDir%\SysNative\ie4uinit.exe -show >$null 2>$null
%WinDir%\System32\ie4uinit.exe -show >$null 2>$null
cmd /c Del %LocalAppData%\IconCache.db /F /Q /S >$null 2>$null
cmd /c Del "%LocalAppData%\Microsoft\Windows\Explorer\iconcache_*.db" /F /Q /S >$null 2>$null

engine;};

# Remove OneDrive
function chck60{
CleanFlag $MyInvocation.MyCommand
$counter++;
Write-Host ' [Remove] Microsoft OneDrive ' -F red -B black
cmd /c taskkill /F /IM "OneDrive.exe" >$null 2>$null
cmd /c $env:systemroot\SysWOW64\OneDriveSetup.exe /uninstall >$null 2>$null
cmd /c $env:systemroot\System32\OneDriveSetup.exe /uninstall >$null 2>$null

Get-AppxPackage -allusers *Microsoft.OneDriveSync* | Remove-AppxPackage

cmd /c rd "%UserProfile%\OneDrive" /Q /S >$null 2>$null
cmd /c rd "%LocalAppData%\Microsoft\OneDrive" /Q /S >$null 2>$null
cmd /c rd "%ProgramData%\Microsoft OneDrive" /Q /S >$null 2>$null
cmd /c rd "%systemdrive%\OneDriveTemp" /Q /S >$null 2>$null

::Remove OneDrive leftovers in explorer left side panel
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >$null 2>$null
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f | Out-Null
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >$null 2>$null
engine;};

# Disable Xbx Services (Minecraft Luncher wont login into MS)
function chck61{
CleanFlag $MyInvocation.MyCommand
$counter++;
Write-Host ' [Disable] Xbox Services ' -F darkgray -B black
cmd /c sc config XblAuthManager start= disabled | Out-Null
cmd /c sc config XboxNetApiSvc start= disabled | Out-Null
cmd /c sc config XblGameSave start= disabled | Out-Null
engine;};

# Safe/Fast DNS 1.1.1.1
function chck62{
CleanFlag $MyInvocation.MyCommand
$counter++;
Write-Host ' [Setting] Fast/Secure DNS 1.1.1.1 ' -F blue -B black
ipconfig /flushdns | Out-Null

# Custom DNS can couse problems with connection mostly becouse of Internet Service Provider (blocking custom DNS)
# or could not connect into website (extremely rare case)

netsh interface ipv4 add dnsservers "Ethernet" address=1.1.1.1 index=1 | Out-Null
netsh interface ipv4 add dnsservers "Ethernet" address=8.8.8.8 index=2 | Out-Null

netsh interface ipv4 add dnsservers "Wi-Fi" address=1.1.1.1 index=1 | Out-Null
netsh interface ipv4 add dnsservers "Wi-Fi" address=8.8.8.8 index=2 | Out-Null
engine;};

# Scan of Adware/Malware
function chck63 {
CleanFlag $MyInvocation.MyCommand
$counter++;
Write-Host ' [Scanning] AdwCleaner ' -F darkgreen -B black
wget https://downloads.malwarebytes.com/file/adwcleaner -o $Env:programdata\adwcleaner.exe | Out-Null
cmd /c if exist $Env:programdata\adwcleaner.exe start /WAIT $Env:programdata\adwcleaner.exe /eula /clean /noreboot | Out-Null

del $Env:programdata\adwcleaner.exe | Out-Null

engine;};

#Clean Database of WinSxS
function chck68{
CleanFlag $MyInvocation.MyCommand
$counter++;
Write-Host ' [Clean] WinSxS Folder ' -F yellow -B black
DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase | Out-Null

engine;};

#Set Split Threshold for Svchost
function chck3{
CleanFlag $MyInvocation.MyCommand
$counter++;
Write-Host ' [Setting] Split Threshold for Svchost (Can break XboxGipSvc) ' -F blue -B black
$ram = (Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control' -Name 'SvcHostSplitThresholdInKB' -Type DWord -Value $ram -Force | Out-Null
engine;};

function CleanFlag
{
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $func
    )

    $filePath = $Env:programdata + '\ET\' + $func + '.lbool'
    if (Test-Path $filePath) { Remove-Item $filePath }
};

function GetFunctionNameToExecute
{
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $prefix
    )

    $name = Get-ChildItem -Path $Env:programdata\ET\$prefix*.lbool -Name | Sort-Object {[int]$_.Replace($prefix, '').Replace('.lbool','')} | Select-Object -first 1
    if ($name -ne '')
    {
        return $name.Replace('.lbool','').Trim()
    }
    else
    {
        return $null
    }
};

#Quit if no files .lbool or other errors
function error_exit { exit };

# Main Start Hamster-Engine (that amount of "if" is AWESOME) => Not anymore ;)
function engine 
{	
	$percentcomplete = $counter/$alltodo*100
	$showpercent = [math]::Round($percentcomplete)
	Write-Progress -Activity "Script in Progress" -Status "$showpercent% Complete:" -PercentComplete $showpercent
 	
  	$function = GetFunctionNameToExecute 'chck'
        if ($function -ne $null)
        {
            Invoke-Expression $function
        }
};

cls
if (-not(Test-Path $Env:programdata\ET\*.lbool)) { error_exit; }
[Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 1) | Out-Null

engine;

#Done
if (Get-Item -Path $Env:programdata\restart-network-settings.bat) {Remove-Item $Env:programdata\restart-network-settings.bat}
if (Get-Item -Path $Env:programdata\winget-et.bat) {Remove-Item $Env:programdata\winget-et.bat}

Write-Host "";Write-Host "";
Write-Host ""
Write-Host ""
Write-Host "               Everything has been done. Reboot is recommended."
Write-Host ""
Write-Host ""
Write-Host "";Write-Host "";

#MsgBox information
Add-Type -AssemblyName PresentationCore,PresentationFramework
$msgBody = "Everything has been done. Reboot is recommended."
if ($langos -eq 'Polski') {$msgBody = "Zakonczono. Zalecane jest ponowne uruchomienie."}
$msgTitle = $versionRAW
$msgButton = 'OK'
$msgImage = 'Information'
$Result = [System.Windows.MessageBox]::Show($msgBody,$msgTitle,$msgButton,$msgImage)