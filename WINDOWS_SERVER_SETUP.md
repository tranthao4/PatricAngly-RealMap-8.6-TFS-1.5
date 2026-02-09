# 🖥️ TFS Server & OTClient Setup - Windows Guide

Denna guide innehåller två delar:
- **DEL 1:** TFS Server Setup (Steg 1-9)
- **DEL 2:** OTClient Auto-Updater Setup (Steg 10-18)

---
---

# 📦 DEL 1: TFS SERVER SETUP

---

## Förutsättningar för DEL 1

### Ladda ner och installera följande:
- **Visual Studio 2022** (Community): https://visualstudio.microsoft.com/
  - Välj "Desktop development with C++"
- **MySQL Server 8.0**: https://dev.mysql.com/downloads/mysql/
- **Git**: https://git-scm.com/download/win
- **vcpkg**: https://github.com/microsoft/vcpkg

---

## Steg 1: Klona TFS-projektet

```powershell
cd C:\
git clone https://github.com/PatricAngly/PatricAngly-RealMap-8.6-TFS-1.5.git
cd PatricAngly-RealMap-8.6-TFS-1.5
```

---

## Steg 2: Installera vcpkg och dependencies

```powershell
cd C:\
git clone https://github.com/microsoft/vcpkg.git
cd vcpkg
.\bootstrap-vcpkg.bat
.\vcpkg integrate install

# Installera dependencies
.\vcpkg install boost-iostreams:x64-windows
.\vcpkg install boost-system:x64-windows
.\vcpkg install boost-filesystem:x64-windows
.\vcpkg install boost-asio:x64-windows
.\vcpkg install lua:x64-windows
.\vcpkg install libmariadb:x64-windows
.\vcpkg install pugixml:x64-windows
.\vcpkg install cryptopp:x64-windows
.\vcpkg install fmt:x64-windows
```

---

## Steg 3: Kompilera med CMake

```powershell
cd C:\PatricAngly-RealMap-8.6-TFS-1.5
mkdir build
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=C:/vcpkg/scripts/buildsystems/vcpkg.cmake
cmake --build . --config Release
```

---

## Steg 4: Konfigurera MySQL

1. Öppna **MySQL Command Line Client**
2. Kör följande:

```sql
CREATE DATABASE forgottenserver_rl;
CREATE USER 'tfs'@'localhost' IDENTIFIED BY 'tfs123';
GRANT ALL PRIVILEGES ON forgottenserver_rl.* TO 'tfs'@'localhost';
FLUSH PRIVILEGES;
USE forgottenserver_rl;
SOURCE C:/PatricAngly-RealMap-8.6-TFS-1.5/schema.sql;
```

---

## Steg 5: Konfigurera config.lua

Öppna `C:\PatricAngly-RealMap-8.6-TFS-1.5\config.lua` och ändra:

```lua
-- Ändra IP till din publika IP eller 0.0.0.0
ip = "0.0.0.0"

-- MySQL-inställningar (om du ändrade lösenord)
mysqlHost = "127.0.0.1"
mysqlUser = "tfs"
mysqlPass = "tfs123"
mysqlDatabase = "forgottenserver_rl"
mysqlPort = 3306
```

---

## Steg 6: Öppna portar i Windows Firewall

```powershell
# Kör som Administrator
netsh advfirewall firewall add rule name="TFS Login" dir=in action=allow protocol=tcp localport=7171
netsh advfirewall firewall add rule name="TFS Game" dir=in action=allow protocol=tcp localport=7172
```

---

## Steg 7: Port Forwarding i routern

1. Hitta din lokala IP: `ipconfig` → Leta efter "IPv4 Address"
2. Logga in på routern (oftast `192.168.1.1`)
3. Hitta "Port Forwarding" / "NAT" / "Virtual Server"
4. Lägg till:
   - **Port 7171 TCP** → Din lokala IP
   - **Port 7172 TCP** → Din lokala IP

---

## Steg 8: Hitta din publika IP

Öppna webbläsare och gå till: https://ifconfig.me

---

## Steg 9: Starta servern

```powershell
cd C:\PatricAngly-RealMap-8.6-TFS-1.5\build\Release
.\tfs.exe
```

---

## 🎮 Spelare ansluter med

- **IP:** Din publika IP (t.ex. `85.123.45.67`)
- **Port:** `7171`

---

## Felsökning

| Problem | Lösning |
|---------|---------|
| MySQL connection failed | Kontrollera att MySQL-tjänsten körs |
| Port already in use | Stäng andra program på port 7171/7172 |
| Players can't connect | Kontrollera brandvägg och port forwarding |
| Compilation errors | Kör `vcpkg integrate install` igen |

---

## Skapa admin-konto

I MySQL:
```sql
INSERT INTO accounts (name, password, type) VALUES ('admin', 'admin', 6);
INSERT INTO players (name, account_id, group_id, vocation, town_id)
VALUES ('God', 1, 6, 0, 1);
```

---

## ✅ Checklista DEL 1 - TFS Server

- [ ] Visual Studio 2022 installerat
- [ ] MySQL Server 8.0 installerat
- [ ] Git installerat
- [ ] vcpkg installerat och dependencies installerade
- [ ] Projektet klonat till `C:\PatricAngly-RealMap-8.6-TFS-1.5`
- [ ] Projektet kompilerat med CMake
- [ ] MySQL databas skapad och schema importerat
- [ ] `config.lua` konfigurerad med rätt IP
- [ ] Portar 7171 och 7172 öppna i brandvägg
- [ ] Port forwarding konfigurerad i router
- [ ] Servern startar utan fel
- [ ] Admin-konto skapat

---
---

# 🔄 DEL 2: OTCLIENT AUTO-UPDATER SETUP

Denna del beskriver hur du sätter upp automatisk uppdatering för OTClient så att spelare automatiskt får nya filer vid start.

---

## Förutsättningar för DEL 2

- **DEL 1 måste vara klar** (TFS Server fungerar)
- **OTClient** kompilerat eller nedladdat
- **XAMPP** (laddas ner i Steg 10)

---

## Översikt - Hur Auto-Updater fungerar

```
┌─────────────────┐     1. POST request      ┌─────────────────┐
│                 │  ───────────────────────► │                 │
│    OTClient     │     (version, build)      │   Webbserver    │
│    (Spelare)    │                           │   (updater.php) │
│                 │  ◄─────────────────────── │                 │
└─────────────────┘   2. JSON (fil-lista +    └─────────────────┘
        │                 checksums)                  │
        │                                             │
        │            3. Ladda ner filer               │
        └─────────────────────────────────────────────┘
```

**Flöde:**
1. Klienten startar och kontaktar `Services.updater` URL
2. Servern svarar med lista på filer och deras checksums
3. Klienten jämför med lokala filer
4. Nya/ändrade filer laddas ner
5. Klienten startar om vid behov

---

## Steg 10: Installera webbserver (XAMPP)

### 10.1 Ladda ner och installera XAMPP
- **Ladda ner:** https://www.apachefriends.org/download.html
- Välj **Windows** version
- Installera till `C:\xampp`
- Starta **XAMPP Control Panel**
- Klicka **Start** på **Apache**

### 10.2 Verifiera att det fungerar
- Öppna webbläsare: http://localhost
- Du bör se XAMPP välkomstsida

---

## Steg 11: Skapa updater API

### 11.1 Skapa mapp för klientfiler
```powershell
mkdir C:\xampp\htdocs\client
mkdir C:\xampp\htdocs\client\data
mkdir C:\xampp\htdocs\api
```

### 11.2 Skapa updater.php
Skapa filen `C:\xampp\htdocs\api\updater.php` med följande innehåll:

```php
<?php
/**
 * OTClient Auto-Updater API
 *
 * Detta script returnerar en lista på alla klientfiler med checksums.
 * Klienten jämför checksums och laddar ner filer som ändrats.
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

// Konfigurera sökväg till klientfiler
$clientFilesPath = '../client/';
$clientFilesUrl = 'http://' . $_SERVER['HTTP_HOST'] . '/client/';

// Alternativt: Använd din publika IP eller domän
// $clientFilesUrl = 'http://DIN_PUBLIKA_IP/client/';
// $clientFilesUrl = 'http://dinserver.duckdns.org/client/';

/**
 * Rekursivt hämta alla filer i en mapp med MD5 checksums
 */
function getFilesWithChecksums($dir, $baseDir = '') {
    $files = [];

    if (!is_dir($dir)) {
        return $files;
    }

    $items = scandir($dir);
    foreach ($items as $item) {
        if ($item === '.' || $item === '..') continue;

        $fullPath = $dir . '/' . $item;
        $relativePath = $baseDir ? $baseDir . '/' . $item : $item;

        if (is_dir($fullPath)) {
            $files = array_merge($files, getFilesWithChecksums($fullPath, $relativePath));
        } else {
            // Beräkna MD5 checksum
            $files[$relativePath] = md5_file($fullPath);
        }
    }

    return $files;
}

// Hämta POST-data från klienten (för loggning/debugging)
$input = json_decode(file_get_contents('php://input'), true);
$clientVersion = $input['version'] ?? 'unknown';
$clientBuild = $input['build'] ?? 'unknown';
$clientOS = $input['os'] ?? 'unknown';

// Logga uppdateringsförfrågan (valfritt)
$logFile = '../logs/updater.log';
if (!is_dir('../logs')) mkdir('../logs', 0755, true);
$logEntry = date('Y-m-d H:i:s') . " - Version: $clientVersion, Build: $clientBuild, OS: $clientOS\n";
file_put_contents($logFile, $logEntry, FILE_APPEND);

// Hämta alla filer med checksums
$files = getFilesWithChecksums($clientFilesPath);

// Returnera JSON-svar
$response = [
    'url' => $clientFilesUrl,
    'files' => $files,
    'keepFiles' => false  // true = behåll lokala filer som inte finns på servern
];

// Valfritt: Lägg till binary-uppdatering (för att uppdatera själva .exe filen)
// $response['binary'] = [
//     'file' => 'otclient.exe',
//     'checksum' => md5_file($clientFilesPath . 'otclient.exe')
// ];

echo json_encode($response, JSON_PRETTY_PRINT);
?>
```

---

## Steg 12: Kopiera klientfiler till webbservern

### 12.1 Kopiera data-mappen
Kopiera OTClient's `data/` mapp till webbservern:

```powershell
# Kopiera från OTClient till webbserver
xcopy /E /I "C:\otclient\data" "C:\xampp\htdocs\client\data"

# Kopiera modules om du vill uppdatera dem också
xcopy /E /I "C:\otclient\modules" "C:\xampp\htdocs\client\modules"
```

### 12.2 Mappstruktur på webbservern
```
C:\xampp\htdocs\
├── api\
│   └── updater.php          ← API-scriptet
├── client\
│   ├── data\
│   │   ├── things\
│   │   │   ├── Tibia.dat
│   │   │   └── Tibia.spr
│   │   ├── images\
│   │   ├── fonts\
│   │   └── ...
│   └── modules\
│       ├── game_interface\
│       └── ...
└── logs\
    └── updater.log          ← Skapas automatiskt
```

---

## Steg 13: Konfigurera OTClient

### 13.1 Redigera init.lua
Öppna `C:\otclient\init.lua` och ändra `Services` blocket:

```lua
-- updater
Services = {
    updater = "http://localhost/api/updater.php",  -- Lokal testning
    -- updater = "http://DIN_PUBLIKA_IP/api/updater.php",  -- För publik hosting
    -- updater = "http://dinserver.duckdns.org/api/updater.php",  -- Med DuckDNS
}
```

### 13.2 För publik hosting
Ändra till din publika IP eller domän:

```lua
Services = {
    updater = "http://85.123.45.67/api/updater.php",
}
```

---

## Steg 14: Testa updater lokalt

### 14.1 Testa API:n manuellt
Öppna webbläsare: http://localhost/api/updater.php

Du bör se JSON-svar liknande:
```json
{
    "url": "http://localhost/client/",
    "files": {
        "data/things/Tibia.dat": "abc123...",
        "data/things/Tibia.spr": "def456...",
        "data/images/background.png": "ghi789..."
    },
    "keepFiles": false
}
```

### 14.2 Testa med klienten
1. Starta OTClient
2. Klienten bör visa "Checking for updates..."
3. Om filer saknas lokalt → laddas ner automatiskt
4. Klienten startar sedan normalt

---

## Steg 15: Publik hosting (för spelare utanför ditt nätverk)

### 15.1 Öppna port 80 i Windows Firewall
```powershell
netsh advfirewall firewall add rule name="HTTP" dir=in action=allow protocol=tcp localport=80
```

### 15.2 Port forwarding i routern
Lägg till:
- **Port 80 TCP** → Din lokala IP (samma dator som kör XAMPP)

### 15.3 Uppdatera updater.php
Ändra `$clientFilesUrl` till din publika IP:

```php
$clientFilesUrl = 'http://85.123.45.67/client/';
```

### 15.4 Uppdatera init.lua i klienten
```lua
Services = {
    updater = "http://85.123.45.67/api/updater.php",
}
```

---

## Steg 16: Distribuera klienten till spelare

### 16.1 Skapa klient-paket
1. Kopiera hela OTClient-mappen
2. Ta bort onödiga filer (build-filer, .git, etc.)
3. Behåll endast:
   - `otclient.exe`
   - `data/` (minimal - resten laddas ner)
   - `modules/` (minimal)
   - `init.lua` (med rätt updater URL)

### 16.2 Minimal klient-struktur
```
OTClient-MinServer\
├── otclient.exe
├── init.lua              ← Med Services.updater konfigurerad
├── data\
│   └── things\           ← Kan vara tom, laddas ner
└── modules\
    └── (minimal)
```

### 16.3 Zippa och dela
```powershell
Compress-Archive -Path "C:\OTClient-MinServer\*" -DestinationPath "C:\MinServer-Client.zip"
```

Dela `MinServer-Client.zip` med dina spelare.

---

## Steg 17: Uppdatera klientfiler (när du gör ändringar)

### 17.1 Workflow för uppdateringar
1. Gör ändringar i dina lokala klientfiler
2. Kopiera ändrade filer till `C:\xampp\htdocs\client\`
3. Spelare startar klienten → får automatiskt nya filer

### 17.2 Manuellt sync-script
Skapa `C:\otclient\sync_client.bat`:

```batch
@echo off
echo ========================================
echo   OTClient File Sync Tool
echo ========================================
echo.
echo Synkroniserar klientfiler till webbserver...
echo.

REM Kopiera data-mappen
echo [1/2] Kopierar data-mappen...
xcopy /E /Y /I /Q "C:\otclient\data" "C:\xampp\htdocs\client\data"

REM Kopiera modules
echo [2/2] Kopierar modules-mappen...
xcopy /E /Y /I /Q "C:\otclient\modules" "C:\xampp\htdocs\client\modules"

echo.
echo ========================================
echo   KLART! Spelare far uppdateringar vid nasta start.
echo ========================================
pause
```

**Användning:** Dubbelklicka på `sync_client.bat` efter att du gjort ändringar.

---

## Steg 18: Automatisk synkronisering (valfritt)

Om du vill att filer synkas **automatiskt** när du sparar ändringar, använd något av följande alternativ:

### 18.1 PowerShell FileSystemWatcher (Rekommenderat)

Skapa `C:\otclient\auto_sync.ps1`:

```powershell
# ============================================
# OTClient Auto-Sync Script
# Övervakar ändringar och synkar automatiskt
# ============================================

$sourcePath = "C:\otclient"
$destPath = "C:\xampp\htdocs\client"
$foldersToWatch = @("data", "modules")

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  OTClient Auto-Sync Started" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Overvakar: $sourcePath" -ForegroundColor Yellow
Write-Host "Synkar till: $destPath" -ForegroundColor Yellow
Write-Host ""
Write-Host "Tryck Ctrl+C for att avsluta." -ForegroundColor Gray
Write-Host ""

# Skapa FileSystemWatcher för varje mapp
$watchers = @()

foreach ($folder in $foldersToWatch) {
    $watchPath = Join-Path $sourcePath $folder

    if (Test-Path $watchPath) {
        $watcher = New-Object System.IO.FileSystemWatcher
        $watcher.Path = $watchPath
        $watcher.Filter = "*.*"
        $watcher.IncludeSubdirectories = $true
        $watcher.EnableRaisingEvents = $true

        # Event handler för ändringar
        $action = {
            $path = $Event.SourceEventArgs.FullPath
            $changeType = $Event.SourceEventArgs.ChangeType
            $relativePath = $path.Replace($sourcePath, "")
            $destFile = Join-Path $destPath $relativePath

            # Vänta lite så filen hinner sparas
            Start-Sleep -Milliseconds 500

            try {
                # Skapa mapp om den inte finns
                $destDir = Split-Path $destFile -Parent
                if (!(Test-Path $destDir)) {
                    New-Item -ItemType Directory -Path $destDir -Force | Out-Null
                }

                # Kopiera filen
                Copy-Item -Path $path -Destination $destFile -Force

                $timestamp = Get-Date -Format "HH:mm:ss"
                Write-Host "[$timestamp] SYNKAD: $relativePath" -ForegroundColor Green
            }
            catch {
                Write-Host "FEL: Kunde inte synka $relativePath" -ForegroundColor Red
            }
        }

        # Registrera events
        Register-ObjectEvent $watcher "Changed" -Action $action | Out-Null
        Register-ObjectEvent $watcher "Created" -Action $action | Out-Null

        $watchers += $watcher
        Write-Host "Overvakar: $folder\" -ForegroundColor Green
    }
}

Write-Host ""

# Håll scriptet igång
try {
    while ($true) { Start-Sleep -Seconds 1 }
}
finally {
    # Städa upp watchers
    foreach ($watcher in $watchers) {
        $watcher.EnableRaisingEvents = $false
        $watcher.Dispose()
    }
    Write-Host "Auto-sync avslutad." -ForegroundColor Yellow
}
```

**Starta auto-sync:**
```powershell
powershell -ExecutionPolicy Bypass -File "C:\otclient\auto_sync.ps1"
```

**Skapa genväg:** Skapa `C:\otclient\start_auto_sync.bat`:
```batch
@echo off
powershell -ExecutionPolicy Bypass -File "C:\otclient\auto_sync.ps1"
```

---

### 18.2 Starta auto-sync vid Windows-start (valfritt)

1. Tryck `Win + R`, skriv `shell:startup`
2. Skapa genväg till `start_auto_sync.bat` i mappen
3. Nu startar auto-sync automatiskt när Windows startar

---

### 18.3 Alternativ: Robocopy med schemalagd uppgift

Om du föredrar att synka med jämna intervall istället för realtid:

Skapa `C:\otclient\scheduled_sync.bat`:
```batch
@echo off
REM Synkar var 5:e minut via Task Scheduler

robocopy "C:\otclient\data" "C:\xampp\htdocs\client\data" /E /MIR /NFL /NDL /NJH /NJS
robocopy "C:\otclient\modules" "C:\xampp\htdocs\client\modules" /E /MIR /NFL /NDL /NJH /NJS
```

**Schemalägg i Task Scheduler:**
```powershell
# Kör som Administrator
schtasks /create /tn "OTClient Sync" /tr "C:\otclient\scheduled_sync.bat" /sc minute /mo 5
```

---

## Sammanfattning - Sync-alternativ

| Metod | Beskrivning | Bäst för |
|-------|-------------|----------|
| `sync_client.bat` | Manuell sync | Sällan uppdateringar |
| `auto_sync.ps1` | Realtids-sync | Aktiv utveckling |
| `scheduled_sync.bat` | Synkar var X minut | Bakgrundssynk |

---

## Felsökning - Updater

| Problem | Lösning |
|---------|---------|
| "Updater Error: Timeout" | Kontrollera att Apache körs i XAMPP |
| "Invalid data from updater api" | Kolla att updater.php returnerar giltig JSON |
| Filer laddas inte ner | Kontrollera att filerna finns i `htdocs/client/` |
| "Can't download file" | Kontrollera brandvägg och att URL:en är korrekt |
| Klienten hittar inte updater | Verifiera `Services.updater` i init.lua |

### Debug-tips
1. Öppna http://localhost/api/updater.php i webbläsare
2. Kolla `C:\xampp\htdocs\logs\updater.log` för förfrågningar
3. Kolla OTClient's loggfil för fel

---

## Alternativ: Gratis hosting med GitHub

Om du inte vill köra egen webbserver kan du använda GitHub:

### GitHub Pages (statisk hosting)
1. Skapa repo på GitHub
2. Ladda upp klientfiler
3. Aktivera GitHub Pages
4. Skapa `files.json` manuellt med checksums

**Nackdel:** Måste uppdatera checksums manuellt.

### GitHub Releases
1. Skapa releases med klientfiler
2. Länka till raw-filer

---

## ✅ Checklista DEL 2 - Auto-Updater

- [ ] XAMPP installerat och Apache startat (Steg 10)
- [ ] `updater.php` skapad i `C:\xampp\htdocs\api\` (Steg 11)
- [ ] Klientfiler kopierade till `C:\xampp\htdocs\client\` (Steg 12)
- [ ] `init.lua` konfigurerad med `Services.updater` (Steg 13)
- [ ] Testat lokalt: http://localhost/api/updater.php (Steg 14)
- [ ] Port 80 öppen i brandvägg (Steg 15)
- [ ] Port forwarding för port 80 konfigurerad (Steg 15)
- [ ] `updater.php` uppdaterad med publik IP (Steg 15)
- [ ] Klient-paket skapat och delat med spelare (Steg 16)
- [ ] Sync-script skapat för uppdateringar (Steg 17)
- [ ] (Valfritt) Auto-sync konfigurerad (Steg 18)

---
---

# 🎉 KLART!

När båda checklistorna är avklarade har du:
- ✅ En fungerande TFS-server som spelare kan ansluta till
- ✅ En OTClient med automatisk uppdatering
- ✅ Möjlighet att pusha uppdateringar till alla spelare

**Spelare ansluter med:**
- **Server IP:** Din publika IP (t.ex. `85.123.45.67`)
- **Port:** `7171`

**Uppdateringar:**
1. Gör ändringar i `C:\otclient\data\` eller `C:\otclient\modules\`
2. Kör `sync_client.bat` (eller använd auto-sync)
3. Spelare får uppdateringar automatiskt vid nästa start!
