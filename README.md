# ET Optimizer

<a href="https://github.com/semazurek/ET-All-in-One-Optimizer/releases"><img src="https://img.shields.io/badge/RELEASE-v5.3-blue?style=for-the-badge&"></a>
<a href="#"><img src="https://img.shields.io/badge/batch-4D4D4D?style=for-the-badge&logo=windows%20terminal&logoColor=white"></a>
<a href="#"><img src="https://img.shields.io/badge/powershell-5391FE?style=for-the-badge&logo=powershell&logoColor=white"></a>
<a href="https://paypal.me/rikey" target="_blank"><img src="https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white"></a>

Optimize performance, improve privacy, and remove bloatware with 1 click.

Last tested/updated on:
<ul>
<li>Windows 10 Home 22H2</li>
<li>Windows 11 Enterprise 22H2</li>
<li>Windows 8.1 Build 9600 (partial support)</li>
</ul> 
</br>

Download link: <a href="https://github.com/semazurek/ET-Optimizer/releases/download/5.3/ET-Optimizer.ps1" target="_blank">ET-Optimizer.ps1</a> Command before running .ps1: ```Set-ExecutionPolicy RemoteSigned```</br>
```PowerShell
iwr -useb https://raw.githubusercontent.com/semazurek/ET-Optimizer/master/ET-Optimizer.ps1 | iex
```
<a href="https://github.com/semazurek/ET-All-in-One/blob/master/README-PL.md"><img src="https://user-images.githubusercontent.com/85984736/160295447-6638c9d9-d553-4ea3-a192-4e5ef63f8961.png" width="50px" style="border: 1px solid black"></a>

<p align="center">
<img src="https://github.com/semazurek/ET-Optimizer/assets/85984736/cb24d16f-b02a-4cfa-8e96-210d13239398" width="600">
</p>

```diff

# It's recommended to make a own extra backup. #
# Some antiviruses may falsely detecting it as a threat. #
# It is recommended to disable the antivirus while it is running. #

```
Script developed from many sources found on the Internet, tested and updated for different versions of the system. </br>The whole script is contained in 1 file, it uses: command prompt, powershell, power plan configuration, boot configuration, registry changes, network interface configuration, built-in windows tools, etc.

## Benchmark
<p align="center">
<img src="https://user-images.githubusercontent.com/85984736/198885777-a93d6aec-50ec-4a05-be55-620cc016dfa1.png" width="400">

<img src="https://user-images.githubusercontent.com/85984736/198885788-50f9ed4d-4987-40a4-b621-4271b620893d.png" width="400">
</p>
Tested after installing all updates & drivers, including: Java, WinRAR, Office 2016, Visual C++ Redistributable, etc.</br>After startup (2:00 up time).</br></br>

## What it does 

**Each part of the ET Script has a comment and can be edited freely.**

</br>
 <table style="width: 100%">
  <tr>
    <td>Enable file extensions in Explorer  </td>
    <td>Disable location sensor  </td>
  </tr>
  <tr>
   <td>Disable Edge Web Widget</td>
   <td>WiFi: HotSpot Sharing: Disable</td>
  </tr>
  <tr>
   <td>Disable windows animations and start menu.</td>
   <td>WiFi: Shared HotSpot Auto-Connect: Disable</td>
  </tr>
  <tr>
   <td>Disable powerthrottling (Intel 6gen and higher)</td>
   <td>Windows Updates to "Notify to schedule restart"</td>
  </tr>
  <tr>
   <td>Remove Widgets</td>
   <td>Disable downloading P2P updates outside the local network</td>
  </tr>
  <tr>
   <td>Hide the search box from taskbar.</td>
   <td>Disable Windows Defender</td>
  </tr>
  <tr>
   <td>Disable Hibernation</td>
   <td>Disable News and Interests on Taskbar</td>
  </tr>
  <tr>
   <td>Turn Off Background Apps</td>
   <td>Disable MRU lists (jump lists) of XAML apps</td>
  </tr>
  <tr>
   <td>Disable unnecessary startup apps</td>
   <td>Windows Explorer on start on This PC</td>
  </tr>
  <tr>
   <td>Disable Telemetry & Data Collection </td>
   <td>Disable Get Even More Out of Windows Screen</td>
  </tr>
  <tr>
   <td>Disable Let apps use my advertising ID</td>
   <td>Disable automatically installing suggested apps</td>
  </tr>
  <tr>
   <td>SmartScreen Filter for Store Apps: Disable</td>
   <td>Disable Start Menu Ads/Suggestions</td>
  </tr>
  <tr>
   <td>Let websites provide locally</td>
   <td>Set shorter shutdown time</td>
  </tr>
  <tr>
   <td>Disable: Send Microsoft info about how I write</td>
   <td>Turning Off Windows Game Bar/DVR</td>
  </tr>
  <tr>
   <td>Prevents sending speech, typing samples to MS</td>
   <td>Prevents sending contacts to MS</td>
  </tr>
  <tr>
   <td>Microsoft Edge privacy settings</td>
   <td>Remove Windows Game Bar</td>
  </tr>
  <tr>
   <td>Disable Process Mitigation</td>
   <td>Disable Sticky Keys prompt</td>
  </tr>
  <tr>
  <td>Disable Activity History</td>
  <td>Disable Automatic Updates for Microsoft Store apps</td>
 </tr>
  <tr>
	<td>Set dual boot timeout 3sec</td>
	<td>Disable windows insider experiments</td>
 </tr>
   <tr>
	<td>Disable app launch tracking</td>
	<td>Disable windows media player usage reports</td>
 </tr>
    <tr>
	<td>Disable mozilla telemetry</td>
	<td>Disable watson malware reports</td>
 </tr>
   <tr>
	<td>Disable malware diagnostic data </td>
	<td>Disable setting override for reporting to Microsoft MAPS</td>
 </tr>
   <tr>
	<td>Disable spynet Defender reporting</td>
	<td>Do not send malware samples for further analysis</td>
 </tr>
     <tr>
	<td>Remove Old Device Drivers</td>
	<td>Disable Skype Telemetry</td>
 </tr>
 <tr>
	<td>Disable PowerShell Telemetry</td>
	<td>Remove OneDrive</td>
 </tr>
<tr>
	<td>Defragment Database Indexing Service File</td>
	<td>Disable transparency in taskbar/menu start</td>
</tr>
<tr>
	<td>Enable Fast/Secure DNS (1.1.1.1)</td>
	<td>Scheduled Windows Defender Scan from highest to normal priority</td>
</tr>	
<tr>
	<td>Scan for adware (adwcleaner)</td>
	<td>Disable Nagel's Algorithm (Delayed ACK).</td>
</tr>	
<tr>
	<td>Disable Sleep Mode Timeouts</td>
	<td>Power Option to Ultimate Performance</td>
</tr>
<tr>
	<td>Disable Spectre/Meltdown Protection</td>
	<td>Remove Microsoft Edge</td>
</tr>
<tr>
	<td>Clean WinSxS Folder</td>
	<td>Split Threshold for Svchost</td>
</tr>
</table>
</br>
<li>Unnecessary services set to disabled/manual mode: </li>  

  </br>


| Display name  | Service name  | Mode |
| ------------- | ------------- | ---- |
| Collecting data  | `DiagTrack` `diagnosticshub` `dmwappushservice`  | Disabled |
| Remote Registry  | `Remote Registry`  | Disabled |
| Remote Access | `Remote Access`  | Disabled |
| Smart Card | `SCardSvr`  | Disabled |
| Smart Card Removal Policy Service | `SCPolicySvc`  | Disabled |
| Fax | `Fax`  | Disabled |
| Xbox Live Auth Manager | `XblAuthManager`  | Disabled |
| Xbox Live Networking Service | `XboxNetApiSvc`  | Disabled |
| Xbox Live Game Save Service | `XblGameSave`  | Disabled |
| Windows Reporting Service | `WerSvc`  | Disabled |
| Nvidia Telemetry collector | `NvTelemetryContainer`  | Disabled |
| Gigabyte Adjust Service (EasyTune) | `gadjservice`  | Disabled |
| Adobe Updater Service | `AdobeARMservice`  | Disabled |
| Corel License Validation Service | `PSI_SVC_2`  | Disabled |
| Geolocation service | `lfsvc` | Disabled |
| WalletService | `WalletService`  | Disabled |
| Microsoft Retail Demo experience | `RetailDemo`  | Disabled |
| Management of payments and NFC | `SEMgrSvc`  | Disabled |
| Executes diagnostic actions for troubleshooting support | `diagsvc`  | Disabled |
| Alljoyn Router Service | `AJRouter`  | Disabled |
| Network Diagnostic Usage | `NDU`  | Disabled |
| AMD Crash Defender Driver | `amdfendr`  | Disabled |
| AMD Crash Defender Service | `amdfendrmgr`  | Disabled |
| Windows Search | `WSearch`  | Manual |
| Background Intelligent Transfer Service | `BITS`  | Manual |
| Security Accounts Manager | `SamSs` | Manual |  
| Telephony | `TapiSrv` | Manual |  
| Secondary Logon | `seclogon` | Manual | 
| Windows Update | `wuauserv`| Manual | 
| Telephony state on the device | `PhoneSvc` | Manual | 
| TCP/IP NetBIOS Helper | `lmhosts` | Manual | 
| IP Helper | `iphlpsvc` | Manual | 
| Google Update service | `gupdate` `gupdatem` | Manual | 
| Microsoft Edge Update Service | `edgeupdate` `edgeupdatem` | Manual | 
| Downloaded Windows Maps Manager | `MapsBroker` | Manual | 
| PunkBuster (Game anti-cheat EA) | `PnkBstrA` | Manual |  
| Brave Update service | `brave` `bravem` | Manual |
| ASUS Update service | `asus` `asusm` | Manual |
| Adobe Update Service | `adobeupdateservice` | Manual |
| Adobe FlashPlayer Service | `adobeflashplayerupdatesvc` | Manual |

</br>
<li>Remove Bloatware Apps (Preinstalled):</li>  
<ul></br>

`3DBuilder` `Automate` `Appconnector` `Microsoft3DViewer` `MicrosoftPowerBIForWindows` `Print3D` `XboxApp` `GetHelp` `WindowsFeedbackHub` `BingFoodAndDrink` `BingHealthAndFitness` `BingTravel` `WindowsReadingList` `MixedReality.Portal` `ScreenSketch` `YourPhone` `PicsArt-PhotoStudio` `EclipseManager` `PolarrPhotoEditorAcademicEdition` `Wunderlist` `LinkedInforWindows` `AutodeskSketchBook` `DisneyMagicKingdoms` `MarchofEmpires` `ActiproSoftwareLLC` `Plex` `iHeartRadio` `FarmVille2CountryEscape` `Duolingo` `CyberLinkMediaSuiteEssentials` `DolbyAccess` `DrawboardPDF` `FitbitCoach` `Flipboard` `Asphalt8Airborne`   `Keeper` `BingNews` `COOKINGFEVER` `PandoraMediaInc` `CaesarsSlotsFreeCasino` `Shazam` `PhototasticCollage` `TuneInRadio` `WinZipUniversal` `XING` `RoyalRevolt2` `CandyCrushSodaSaga` `BubbleWitch3Saga` `CandyCrushSaga` `Getstarted` `WindowsAlarms` `bing` `MicrosoftOfficeHub` `OneNote` `WindowsPhone` `SkypeApp`  `windowscommunicationsapps` `WindowsMaps` `Sway` `CommsPhone` `ConnectivityStore` `Twitter` `Drawboard PDF` `Sketchable` `Clipchamp` `Prime Videos` `TikTok` `ToDo` `Family` `NewVoiceNote` `SamsungNotes` `SamsungFlux` `StudioPlus` `SamsungWelcome` `SamsungQuickSearch` `SamsungPCCleaner` `SamsungCloudBluetoothSync` `PCGallery` `OnlineSupportSService` `HPJumpStarts` `HPPCHardwareDiagnosticsWindows` `HPPowerManager` `HPPrivacySettings` `HPSupportAssistant` `HPSureShieldAI` `HPSystemInformation` `HPQuickDrop` `HPWorkWell` `myHP` `HPDesktopSupportUtilities` `HPQuickTouch` `HPEasyClean` `HPSystemInformation` `ACGMediaPlayer` `AdobePhotoshopExpress` `HiddenCity` `Hulu` `Microsoft.Advertising.Xaml_10.1712.5.0_x64__8wekyb3d8bbwe` `Microsoft.Advertising.Xaml_10.1712.5.0_x86__8wekyb3d8bbwe` `MicrosoftSolitaireCollection` `MicrosoftStickyNotes` `Microsoft.People` `Microsoft.Wallet` `MinecraftUWP` `Todos` `Viber` `bingsports`
 
</ul>
</br>
<li>Disable Unnecessary StartUp Applications:</li>
<ul></br>

 `Java Update Checker x64` `Mini Partition Tool Wizard Updater` `Teams Machine Installer` `Cisco Meeting Daemon` `Adobe Reader Speed Launcher` `CCleaner Smart Cleaning/Monitor` `Spotify Web Helper` `Gaijin.Net Updater` `Microsoft Teams Update` `Google Update` `Microsoft Edge Update` `BitTorrent Bleep` `Skype` `Adobe Update Startup Utility` `iTunes Helper` `CyberLink Update Utility` `MSI Live Update` `Wondershare Helper Compact` `Cisco AnyConnect Secure Mobility Agent` `Wargaming.net Game Center` `Skype for Desktop` `Gog Galaxy` `Epic Games Launcher` `Origin` `Steam` `Opera Browser Assistant` `uTorrent` `Skype for Business` `Google Chrome Installer` `Microsoft Edge Installer` `Discord Update` `Bliz`
 
</ul>
</ul></br>
<li>Disables unnecessary components:</li>
<ul></br>

`Printing-PrintToPDFServices-Features` `Printing-XPSServices-Features` `Xps-Foundation-Xps-Viewer`

</ul>

*<p align="center">The script has a function to restore to the previous settings.</p>*
<p align="center">
  <img src="https://user-images.githubusercontent.com/85984736/155862049-d6fa04f4-2e10-4aaf-9072-0a6b0ddec0a7.png" />
</p>
