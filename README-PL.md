<h1 align="center"> <img src="https://github.com/user-attachments/assets/d50d77b0-57ec-4d23-9e0c-13541e024f02" width="48">
ET Optimizer
</h1>
<p align="center">
<a href="https://github.com/semazurek/ET-All-in-One-Optimizer/releases"><img src="https://img.shields.io/badge/Wersja-v6.0-blue?style=for-the-badge&"></a>
<a href="#"><img src="https://img.shields.io/badge/C%23-239120?style=for-the-badge&logo=c-sharp&logoColor=white"></a>
<a href="#"><img src="https://img.shields.io/badge/.NET-512BD4?style=for-the-badge&logo=dotnet&logoColor=white"></a>
<a href="#"><img src="https://img.shields.io/github/downloads/semazurek/ET-Optimizer/total?style=for-the-badge"></a>
<a href="https://www.buymeacoffee.com/semazurek" target="_blank"><img src="https://img.shields.io/badge/buymeacoffee-27ae60?style=for-the-badge&logo=buymeacoffee&logoColor=white"></a>
</p>
<p align="center">
<img src="https://github.com/semazurek/semazurek.github.io/blob/main/assets/work1.jpg" width="600">
</p>

<p align="center">Optymalizacja wydajności, poprawa prywatności i usuwanie bloatware'u za pomocą 1 kliknięcia.</p>
 








Aplikacja rozwijana na podstawie wielu źródeł znalezionych w Internecie, przetestowanych i aktualizowanych dla różnych wersji systemu. </br>Cały skrypt zawiera się w 1 pliku, w celu jego działania wykorzystano komendy: wiersza poleceń, powershell, konfiguracji planu zasilania, konfiguracji rozruchu, zmiany rejestru, konfiguracji interfejsów sieciowych, wbudowanych narzędzi windows itp.

Początkowo ET był prostym plikiem wsadowym (.bat), który z czasem ewoluował w plik .bat z implementacjami vbs i powershell, a następnie został całkowicie przepisany do powershell. Z biegiem lat stał się niemal w pełni rozwiniętą aplikacją C#.

Pierwsza wersja pojawiła się w prostej wersji do użytku osobistego w 2021 roku.
Do tej pory projekt rozrósł się do: 4161 linii kodu, 860+ commitów, przetłumaczonego na 6 języków i jest dalej rozwijany z pasją.

<p align="center">
<a href="https://github.com/semazurek/ET-Optimizer/blob/master/README-PL.md"><img src="https://github.com/user-attachments/assets/909786ca-b8b4-4124-b342-3debc6ec8a0e"width="48"></a>
<a href="https://github.com/semazurek/ET-Optimizer"><img src="https://github.com/user-attachments/assets/177f0eb1-f371-4cdd-bbce-9f451e47431d"width="48"></a>
<a href="https://github.com/semazurek/ET-Optimizer/blob/master/README-RUS.md"><img src="https://github.com/user-attachments/assets/c0d4749d-4647-4506-a78c-7a092dd5836c"width="48"></a>
<a href="#"><img src="https://github.com/user-attachments/assets/ffbb6086-b0da-4a98-a126-02ca92c31758"width="48"></a>
<a href="#"><img src="https://github.com/user-attachments/assets/9d8c5679-233b-4416-8371-067f6fc4e114"width="48"></a>
<a href="#"><img src="https://github.com/user-attachments/assets/63bd6170-82ec-49cc-b798-a6b0f3a90a8d"width="48"></a>
</p>

> [!WARNING]  
> Zaleca się wykonanie własnej dodatkowej kopii zapasowej. Nie biorę odpowiedzialności za wyrządzone szkody.
</br>
<p align="center">
<a href="https://github.com/semazurek/ET-Optimizer/releases"><img src="https://img.shields.io/badge/Pobierz-0078D6?style=for-the-badge&logo=windows&logoColor=white"  width="120"></a>
</p>

## 📷 Screenshots
<details>
  <summary> Menu Aplikacji </summary>
  <img src="https://github.com/user-attachments/assets/6d3b3f1f-ce89-475c-be0a-5d81d4aa2d3a"/>
</details>
<details>
  <summary> Podczas Operacji </summary>
  <img src="https://github.com/user-attachments/assets/473a8ec7-0038-44d8-9628-8ccfe6199daf"/>
</details>
<details>
  <summary> Dodatki </summary>
  <img src="https://github.com/user-attachments/assets/8f8a9d54-42f7-41c5-bee6-0a0a5a5430d7"/>
</details>

## 🛠 Co robi skrypt


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
<li>Usuwanie Bloatware (Preinstalowanych)</li>  

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

## 👏 Udostępnienia społęczności

https://www.youtube.com/watch?v=vIzWJ7OjgXA

https://www.youtube.com/watch?v=BM_AirabkB8

https://www.youtube.com/watch?v=FFKeJuXC4HA

https://www.youtube.com/watch?v=G048P3g8bGM

https://www.majorgeeks.com/files/details/et_all_in_one_optimization_script.html

https://filecr.com/windows/semazurek-et-optimizer/

https://en.taiwebs.com/windows/download-et-optimizer-9574.html

https://www.essential-freebies.de/board/viewtopic.php?t=19662

https://www.softpedia.com/get/Tweak/System-Tweak/ET-All-in-One-Optimization-Script.shtml

https://scloud.ws/blog/optimization/5370.html

https://rsload.net/soft/optimization/39444-et-optimizer.html

https://www.yasdl.com/tag/%D8%AF%D8%A7%D9%86%D9%84%D9%88%D8%AF-et-optimizer
