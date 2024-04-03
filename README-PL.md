# ET Optimizer

<a href="https://github.com/semazurek/ET-All-in-One-Optimizer/releases"><img src="https://img.shields.io/badge/Wersja-v5.3-blue?style=for-the-badge&"></a>
<a href="#"><img src="https://img.shields.io/badge/batch-4D4D4D?style=for-the-badge&logo=windows%20terminal&logoColor=white"></a>
<a href="#"><img src="https://img.shields.io/badge/powershell-5391FE?style=for-the-badge&logo=powershell&logoColor=white"></a>
<a href="https://www.buymeacoffee.com/semazurek" target="_blank"><img src="https://img.shields.io/badge/buymeacoffee-27ae60?style=for-the-badge&logo=buymeacoffee&logoColor=white"></a>

Optymalizacja wydajności, poprawa prywatności i usuwanie bloatware'u za pomocą 1 kliknięcia.

Ostatnio testowane/aktualizowane na:
<ul>
<li>Windows 10 Home 22H2</li>
<li>Windows 11 Ent 22H2</li>
<li>Windows 8.1 Build 9600 (częściowe wsparcie)</li>
</ul> 
</br>

Pobierz: <a href="https://github.com/semazurek/ET-Optimizer/releases/download/5.3/ET-Optimizer.ps1" target="_blank">ET-Optimizer.ps1</a> or <a href="https://github.com/semazurek/ET-Optimizer/releases/download/5.3/ET-Optimizer.exe" target="_blank">ET-Optimizer.exe</a>
</br></br>Komenda przed uruchomieniem .ps1:
```PowerShell
Set-ExecutionPolicy RemoteSigned
```

<a href="https://github.com/semazurek/ET-All-in-One"><img src="https://user-images.githubusercontent.com/85984736/160146091-bb329e65-3781-4f03-b72d-b4cd096be201.png" width="50px" style="border: 1px solid black"></a>

<p align="center">
<img src="https://github.com/semazurek/ET-Optimizer/assets/85984736/d2cc35a1-cac2-40a7-a467-b1ee08167eec" width="600">
</p>



```diff

# Zaleca się wykonanie własnej dodatkowej kopii zapasowej. #
# Niektóre programy antywirusowe mogą fałszywie wykrywać to jako zagrożenie. #
# Zalecane jest wyłączenie antywirusa w trakcie działania. #

```
Skrypt rozwijany na podstawie wielu źródeł znalezionych w Internecie, przetestowanych i aktualizowanych dla różnych wersji systemu. </br>Cały skrypt zawiera się w 1 pliku, w celu jego działania wykorzystano komendy: wiersza poleceń, powershell, konfiguracji planu zasilania, konfiguracji rozruchu, zmiany rejestru, konfiguracji interfejsów sieciowych, wbudowanych narzędzi windows itp.

## Test wydajności
<p align="center">
<img src="https://user-images.githubusercontent.com/85984736/198885777-a93d6aec-50ec-4a05-be55-620cc016dfa1.png" width="400">

<img src="https://user-images.githubusercontent.com/85984736/198885788-50f9ed4d-4987-40a4-b621-4271b620893d.png" width="400">
</p>
Przetestowano po zainstalowaniu wszystkich aktualizacji i sterowników, w tym: java, winrar, office 2016, redisturable c++ itp.</br>Po uruchomieniu (2:00 czas działania)</br></br>

## Co robi skrypt

**Każda część skryptu ET jest opatrzona komentarzem i może być dowolnie edytowana.**

</br>
 <table style="width: 100%">
  <tr>
    <td>Ustaw pokazywanie rozszerzeń plików w Eksploratorze</td>
    <td>Wyłączenie czujnika lokalizacji  </td>
  </tr>
  <tr>
   <td>Wyłącz widżet Edge Web Widget</td>
   <td>WiFi: Udostępnianie HotSpot: Wyłącz</td>
  </tr>
  <tr>
   <td>Wyłączenie animacji okien i menu Start.</td>
   <td>WiFi: Współdzielony HotSpot Auto-Connect: Wyłącz</td>
  </tr>
  <tr>
   <td>Wyłączenie dławienia-powerthrottling (Intel 6gen i nowsze)</td>
   <td>Aktualizacje systemu Windows do "Powiadomienie o zaplanowanym ponownym uruchomieniu".</td>
  </tr>
  <tr>
   <td>Usuwanie Widżetów</td>
   <td>Wyłącz pobieranie aktualizacji P2P poza siecią lokalną</td>
  </tr>
  <tr>
   <td>Ukryj pole wyszukiwania na pasku zadań.</td>
   <td>Wyłącz Windows Defender</td>
  </tr>
  <tr>
   <td>Wyłączenie hibernacji</td>
   <td>Wyłącz wiadomości i zainteresowania na pasku zadań</td>
  </tr>
  <tr>
   <td>Wyłącz aplikacje działające w tle</td>
   <td>Wyłączanie list MRU (list przeskoków) w aplikacjach XAML</td>
  </tr>
  <tr>
   <td>Wyłączenie zbędnych zadań zaplanowanych</td>
   <td>Eksplorator Windows przy uruchamianiu: Ten Komputer</td>
  </tr>
  <tr>
   <td>Usuwanie Telemetrii i zbierania danych </td>
   <td>Wyłączenie opcji Uzyskaj jeszcze więcej z Windows</td>
  </tr>
  <tr>
   <td>Wyłącz opcję Pozwól aplikacjom używać mojego identyfikatora reklam....</td>
   <td>Wyłączenie automatycznego instalowania sugerowanych aplikacji</td>
  </tr>
  <tr>
   <td>Filtr SmartScreen dla aplikacji sklepowych: Wyłącz</td>
   <td>Wyłącz reklamy/sugestie w menu Start</td>
  </tr>
  <tr>
   <td>Niech strony internetowe chodzą lokalnie...</td>
   <td>Ustawienie krótszego czasu wyłączenia</td>
  </tr>
  <tr>
   <td>Wyłącz: Wysyłaj firmie Microsoft informacje o tym, jak piszę</td>
   <td>Wyłączanie paska gier/rejestratora Windows</td>
  </tr>
  <tr>
   <td>Uniemożliwia wysyłanie próbek mowy i pisma do MS</td>
   <td>Uniemożliwia wysyłanie kontaktów do systemu MS</td>
  </tr>
  <tr>
   <td>Ustawienia prywatności przeglądarki Microsoft Edge</td>
   <td>Usuwanie paska gier systemu Windows</td>
  </tr>
  <tr>
   <td>Wyłączenie Process Mitigation</td>
   <td>Wyłączenie monitu klawisze trwałe</td>
  </tr>
 <tr>
  <td>Wyłączenie historii aktywności</td>
  <td>Wyłącz automatyczne aktualizacje dla aplikacji z MS Store</td>
 </tr>
  <tr>
	<td>Ustawienie dual boot czas na 3sek</td>
	<td>Wyłącz windows insider experiments</td>
 </tr>
   <tr>
	<td>Wyłącz śledzenie uruchamiania aplikacji</td>
	<td>Wyłącz raporty dotyczące korzystania z odtwarzacza Windows Media Player</td>
 </tr>
    <tr>
	<td>Wyłącz Mozilla telemetry</td>
	<td>Wyłącz raporty o złośliwym oprogramowaniu (defender)</td>
 </tr>
   <tr>
	<td>Wyłącz dane diagnostyczne złośliwego oprogramowania (defender)</td>
	<td>Wyłącz ustawienie zastępowania dla raportowania do MS MAPS</td>
 </tr>
   <tr>
	<td>Wyłącz raportowanie spynet Defender</td>
	<td>Nie wysyłaj próbek złośliwego oprogramowania do dalszej analizy</td>
 </tr>
    <tr>
	<td>Usuwanie starych sterowników urządzeń</td>
	<td>Wyłącz Skype telemetry</td>
 </tr>
 <tr>
	<td>Wyłącz PowerShell telemetry</td>
	<td>Usuwanie OneDrive</td>
 </tr>
<tr>
	<td>Defragmentacja pliku usługi indeksowania windows</td>
	<td>Wyłącz przezroczystość w menu start i pasku zadań</td>
</tr>
<tr>
	<td>Użycie szybkiego i bezpiecznego DNS (1.1.1.1)</td>
	<td>Zaplanowany Windows Defender Scan z wysokiego na normalny priorytet </td>
</tr>	
<tr>
	<td>Skanowanie w poszukiwaniu adware (adwcleaner)</td>
	<td>Wyłącz Algorytm Nagla (Opóźnione ACK)</td>
</tr>	
<tr>
	<td>Wyłącz odliczanie do Trybu Uśpienia</td>
	<td>Opcje zasilania na: Najwyższą wydajność</td>
</tr>
<tr>
	<td>Wyłącz zabezpieczenia Spectre/Meltdown</td>
	<td>Usuwanie Microsoft Edge</td>
</tr>
<tr>
	<td>Czyszczenie WinSxS folderu</td>
	<td>Dzielenie progu (limit) dla Svchost</td>
</tr>
</table>
</br>
<li>Niepotrzebne usługi ustawione na tryb wyłączony/ręczny: </li>  

  </br>


| Nazwa wyświetlana  | Nazwa usługi  | Typ uruchomienia |
| ------------- | ------------- | ---- |
| Gromadzenie danych  | `DiagTrack` `diagnosticshub` `dmwappushservice`  | Wyłączony |
| Rejestr zdalny  | `Remote Registry`  | Wyłączony |
| Routing i Dostęp zdalny | `Remote Access`  | Wyłączony |
| Karta inteligentna | `SCardSvr`  | Wyłączony |
| Zasady usuwania karty inteligentnej | `SCPolicySvc`  | Wyłączony |
| Faks | `Fax`  | Wyłączony |
| Menedżer autoryzacji Xbox Live | `XblAuthManager`  | Wyłączony |
| Usługa sieciowa Xbox Live | `XboxNetApiSvc`  | Wyłączony |
| Zapisywanie gier Xbox Live | `XblGameSave`  | Wyłączony |
| Usługa raportowania błędów systemu Windows | `WerSvc`  | Wyłączony |
| Usługa zbierania telemetrii Nvidii | `NvTelemetryContainer`  | Wyłączony |
| Gigabyte Adjust Service (EasyTune) | `gadjservice`  | Wyłączony |
| Usługa Adobe Updater | `AdobeARMservice`  | Wyłączony |
| Usługa Corel License Validation | `PSI_SVC_2`  | Wyłączony |
| Usługa geolokalizacyjna | `lfsvc` | Wyłączony |
| Usługa portfela | `WalletService`  | Wyłączony |
| Usługa trybu pokazowego | `RetailDemo`  | Wyłączony |
| Menedżer płatności i funkcji NFC/SE | `SEMgrSvc`  | Wyłączony |
| Standardowa usługa kolektora centrum diagnostycznego firmy Microsoft | `diagsvc`  | Wyłączony |
| Usługa routera AllJoyn | `AJRouter`  | Wyłączony |
| Network Diagnostic Usage | `NDU`  | Wyłączony |
| AMD Crash Defender Driver | `amdfendr`  | Wyłączony |
| AMD Crash Defender Service | `amdfendrmgr`  | Wyłączony |
| Windows Search | `WSearch`  | Ręczny |
| Usługa inteligentnego transferu w tle | `BITS`  | Ręczny |
| Menedżer kont zabezpieczeń | `SamSs` | Ręczny |  
| Telefonia | `TapiSrv` | Ręczny |  
| Logowanie pomocnicze | `seclogon` | Ręczny | 
| Windows Update | `wuauserv`| Ręczny | 
| Usługa telefoniczna | `PhoneSvc` | Ręczny | 
| Pomoc TCP/IP NetBIOS | `lmhosts` | Ręczny | 
| Pomoc IP | `iphlpsvc` | Ręczny | 
| Usługa Google Update | `gupdate` `gupdatem` | Ręczny | 
| Usługa Microsoft Edge Update | `edgeupdate` `edgeupdatem` | Ręczny | 
| Menedżer pobranych map | `MapsBroker` | Ręczny | 
| Usługa PunkBuster (Anty-Cheat od EA) | `PnkBstrA` | Ręczny |  
| Usługa Brave Update | `brave` `bravem` | Ręczny |
| Usługa ASUS Update | `asus` `asusm` | Ręczny |
| Usługa Adobe Update | `adobeupdateservice` | Ręczny |
| Usługa Adobe FlashPlayer | `adobeflashplayerupdatesvc` | Ręczny |

</br>
<li>Usuwanie Bloatware (Preinstalowanych):</li>  
<ul></br>

`3DBuilder` `Automate` `Appconnector` `Microsoft3DViewer` `MicrosoftPowerBIForWindows` `Print3D` `XboxApp` `GetHelp` `WindowsFeedbackHub` `BingFoodAndDrink` `BingHealthAndFitness` `BingTravel` `WindowsReadingList` `MixedReality.Portal` `ScreenSketch` `YourPhone` `PicsArt-PhotoStudio` `EclipseManager` `PolarrPhotoEditorAcademicEdition` `Wunderlist` `LinkedInforWindows` `AutodeskSketchBook` `DisneyMagicKingdoms` `MarchofEmpires` `ActiproSoftwareLLC` `Plex` `iHeartRadio` `FarmVille2CountryEscape` `Duolingo` `CyberLinkMediaSuiteEssentials` `DolbyAccess` `DrawboardPDF` `FitbitCoach` `Flipboard` `Asphalt8Airborne`   `Keeper` `BingNews` `COOKINGFEVER` `PandoraMediaInc` `CaesarsSlotsFreeCasino` `Shazam` `PhototasticCollage` `TuneInRadio` `WinZipUniversal` `XING` `RoyalRevolt2` `CandyCrushSodaSaga` `BubbleWitch3Saga` `CandyCrushSaga` `Getstarted` `WindowsAlarms` `bing` `MicrosoftOfficeHub` `OneNote` `WindowsPhone` `SkypeApp`  `windowscommunicationsapps` `WindowsMaps` `Sway` `CommsPhone` `ConnectivityStore` `Twitter` `Drawboard PDF` `Sketchable` `Clipchamp` `Prime Videos` `TikTok` `ToDo` `Family` `NewVoiceNote` `SamsungNotes` `SamsungFlux` `StudioPlus` `SamsungWelcome` `SamsungQuickSearch` `SamsungPCCleaner` `SamsungCloudBluetoothSync` `PCGallery` `OnlineSupportSService` `HPJumpStarts` `HPPCHardwareDiagnosticsWindows` `HPPowerManager` `HPPrivacySettings` `HPSupportAssistant` `HPSureShieldAI` `HPSystemInformation` `HPQuickDrop` `HPWorkWell` `myHP` `HPDesktopSupportUtilities` `HPQuickTouch` `HPEasyClean` `HPSystemInformation` `ACGMediaPlayer` `AdobePhotoshopExpress` `HiddenCity` `Hulu` `Microsoft.Advertising.Xaml_10.1712.5.0_x64__8wekyb3d8bbwe` `Microsoft.Advertising.Xaml_10.1712.5.0_x86__8wekyb3d8bbwe` `MicrosoftSolitaireCollection` `MicrosoftStickyNotes` `Microsoft.People` `Microsoft.Wallet` `MinecraftUWP` `Todos` `Viber` `bingsports`
 
</ul>
</br>
<li>Wyłączanie niepotrzebnych aplikacji startowowych:</li>
<ul></br>

 `Java Update Checker x64` `Mini Partition Tool Wizard Updater` `Teams Machine Installer` `Cisco Meeting Daemon` `Adobe Reader Speed Launcher` `CCleaner Smart Cleaning/Monitor` `Spotify Web Helper` `Gaijin.Net Updater` `Microsoft Teams Update` `Google Update` `Microsoft Edge Update` `BitTorrent Bleep` `Skype` `Adobe Update Startup Utility` `iTunes Helper` `CyberLink Update Utility` `MSI Live Update` `Wondershare Helper Compact` `Cisco AnyConnect Secure Mobility Agent` `Wargaming.net Game Center` `Skype for Desktop` `Gog Galaxy` `Epic Games Launcher` `Origin` `Steam` `Opera Browser Assistant` `uTorrent` `Skype for Business` `Google Chrome Installer` `Microsoft Edge Installer` `Discord Update` `Bliz`
 
</ul>
</ul></br>
<li>Wyłączanie niepotrzebnych składników:</li>
<ul></br>

`Printing-PrintToPDFServices-Features` `Printing-XPSServices-Features` `Xps-Foundation-Xps-Viewer`

</ul>

*<p align="center">Skrypt posiada funkcje przywracania do poprzednich ustawień.</p>*
<p align="center">
  <img src="https://user-images.githubusercontent.com/85984736/155862049-d6fa04f4-2e10-4aaf-9072-0a6b0ddec0a7.png" />
</p>
