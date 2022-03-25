# ET All-in-One Optimization Script

<a href="#"><img src="https://img.shields.io/badge/RELEASE-v3.9-blue?style=for-the-badge&"></a>
<a href="#"><img src="https://img.shields.io/badge/batch-4D4D4D?style=for-the-badge&logo=windows%20terminal&logoColor=white"></a>
<a href="#"><img src="https://img.shields.io/badge/powershell-5391FE?style=for-the-badge&logo=powershell&logoColor=white"></a>
<a href="https://paypal.me/rikey" target="_blank"><img src="https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white"></a>

 <img align="left" src="https://user-images.githubusercontent.com/85984736/155878549-829f33b3-a3fa-4172-8d88-6bbae77c1341.png" width="130"/> 
Performance optimization, privacy fix and debloat script by 1 click. 

Last tested/updated on:
<ul>
<li>Windows 10 Home 21H2</li>
<li>Windows 11 Ent 21H2</li>
<li>Windows 8.1 Build 9600 (partial support)</li>
</ul> 
</br>
Download link: <a href="https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/semazurek/ET-All-in-One/blob/master/ET-AIO.bat" target="_blank">ET-AIO.bat</a> 
 
It's continuation of abandoned <a href="https://youtu.be/SZLV0DbMyHw">GUI project (2017)</a>
</br>

<a href="https://github.com/semazurek/ET-All-in-One/blob/master/README-PL.md"><img src="https://user-images.githubusercontent.com/85984736/160145781-1c0cff7f-5cf9-4289-8436-8bdf0deeff30.png" width="50px"></a>

## Benchmark
<p align="center">
<img src="https://user-images.githubusercontent.com/85984736/159177028-067b5b11-69e3-4dda-9335-5e32ae16168e.png" width="400">

<img src="https://user-images.githubusercontent.com/85984736/159177034-1a68d273-063c-41cb-b825-1f9f21a008ca.png" width="400">
</p>
Tested with installed all updates & drivers, including: java, winrar, office 2016, redisturable c++ etc.</br>After startup (1:35 up time).</br></br>
System RAM (After ET Usage):
<ul>
<li>Windows 10: 1.9 GB
<li>Windows 11: 1.8 GB
<li>Windows 8.1: <1 GB
</ul>

## What it does 

**Each part of the ET Script has a comment and can be edited freely.**

</br>
 <table style="width: 100%">
  <tr>
    <td>Set showing file extensions in Explorer  </td>
    <td>Disable location sensor  </td>
  </tr>
  <tr>
   <td>Disable Edge Web Widget</td>
   <td>WiFi: HotSpot Sharing: Disable</td>
  </tr>
  <tr>
   <td>Disable windows, menu Start animations.</td>
   <td>WiFi: Shared HotSpot Auto-Connect: Disable</td>
  </tr>
  <tr>
   <td>Uninstall OneDrive </td>
   <td>Windows Updates to "Notify to schedule restart"</td>
  </tr>
  <tr>
   <td>Ads blocking via hosts file (AdAway git)</td>
   <td>Disable P2P Update downloads outside of local network</td>
  </tr>
  <tr>
   <td>Enable All (Logical) Cores (Boot Advanced Options)</td>
   <td>Hide the search box from taskbar.</td>
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
   <td>Disable SCHEDULED TASKS tweaks </td>
   <td>Windows Explorer on start on This PC</td>
  </tr>
  <tr>
   <td>Remove Telemetry & Data Collection </td>
   <td>Disable Get Even More Out of Windows Screen</td>
  </tr>
  <tr>
   <td>Disable Let apps use my advertising ID...</td>
   <td>Disable automatically installing suggested apps</td>
  </tr>
  <tr>
   <td>SmartScreen Filter for Store Apps: Disable</td>
   <td>Disable Start Menu Ads/Suggestions</td>
  </tr>
  <tr>
   <td>Let websites provide locally...</td>
   <td>Setting shorter shutdown time</td>
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
</table>
</br>
<li>Unnecessary services set to disabled/manuall mode: </li>  

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
| Geolocation services | `lfsvc` `wlidsvc`  | Disabled |
| WalletService | `WalletService`  | Disabled |
| Microsoft Retail Demo experience | `RetailDemo`  | Disabled |
| Management of payments and NFC | `SEMgrSvc`  | Disabled |
| Executes diagnostic actions for troubleshooting support | `diagsvc`  | Disabled |
| Alljoyn Router Service | `AJRouter`  | Disabled |
| Background Intelligent Transfer Service | `BITS`  | Disabled |
| Security Accounts Manager | `SamSs` | Manuall |  
| Telephony | `TapiSrv` | Manuall |  
| Secondary Logon | `seclogon` | Manuall | 
| Windows Update | `wuauserv`| Manuall | 
| Telephony state on the device | `PhoneSvc` | Manuall | 
| TCP/IP NetBIOS Helper | `lmhosts` | Manuall | 
| IP Helper | `iphlpsvc` | Manuall | 
| Google Update service | `gupdate` `gupdatem` | Manuall | 
| Microsoft Edge Update Service | `edgeupdate` | Manuall | 
| Downloaded Windows Maps Manager | `MapsBroker` | Manuall | 
| PunkBuster (Game anti-cheat EA) | `PnkBstrA` | Manuall |  

</br>
<li>Remove Bloatware Apps (Preinstalled):</li>  
<ul></br>

`3DBuilder` `Automate` `Appconnector` `Microsoft3DViewer` `MicrosoftPowerBIForWindows` `Print3D` `XboxApp` `GetHelp` `WindowsFeedbackHub` `BingFoodAndDrink` `BingHealthAndFitness` `BingTravel` `WindowsReadingList` `MixedReality.Portal` `ScreenSketch` `YourPhone` `PicsArt-PhotoStudio` `EclipseManager` `Netflix` `PolarrPhotoEditorAcademicEdition` `Wunderlist` `LinkedInforWindows` `AutodeskSketchBook` `DisneyMagicKingdoms` `MarchofEmpires` `ActiproSoftwareLLC` `Plex` `iHeartRadio` `FarmVille2CountryEscape` `Duolingo` `CyberLinkMediaSuiteEssentials` `DolbyAccess` `DrawboardPDF` `Facebook` `FitbitCoach` `Flipboard` `Asphalt8Airborne`   `Keeper` `BingNews` `COOKINGFEVER` `PandoraMediaInc` `CaesarsSlotsFreeCasino` `Shazam` `SpotifyMusic` `PhototasticCollage` `TuneInRadio` `WinZipUniversal` `XING` `RoyalRevolt2` `CandyCrushSodaSaga` `BubbleWitch3Saga` `CandyCrushSaga` `Getstarted` `WindowsAlarms` `bing` `MicrosoftOfficeHub` `OneNote` `WindowsPhone` `SkypeApp`  `windowscommunicationsapps` `WindowsMaps` `Sway` `CommsPhone` `ConnectivityStore` `Twitter` `Drawboard PDF` `Sketchable` `Clipchamp` `Prime Videos` `TikTok`  `Instagram` `WhatsApp` `ToDo`
 
</ul>
</br>
<li>Disable Unnecessary StartUp Applications:</li>
<ul></br>

 `Java Update Checker x64` `Mini Partition Tool Wizard Updater` `Teams Machine Installer` `Cisco Meeting Daemon` `Adobe Reader Speed Launcher` `CCleaner Smart Cleaning/Monitor` `Spotify Web Helper` `Gaijin.Net Updater` `Microsoft Teams Update` `Google Update` `Microsoft Edge Update` `BitTorrent Bleep` `Skype` `Adobe Update Startup Utility` `iTunes Helper` `CyberLink Update Utility` `MSI Live Update` `Wondershare Helper Compact` `Cisco AnyConnect Secure Mobility Agent`
 
</ul>
</ul></br>
<li>Disables unnecessary components:</li>
<ul></br>

`Printing-PrintToPDFServices-Features` `Printing-XPSServices-Features` `Xps-Foundation-Xps-Viewer` `WCF-Services45` `MSRDC-Infrastructure`

</ul>
</br>

<p align="center">
  <img src="https://user-images.githubusercontent.com/85984736/155862049-d6fa04f4-2e10-4aaf-9072-0a6b0ddec0a7.png" />
</p>
