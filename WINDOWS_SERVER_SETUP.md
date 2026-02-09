# 🖥️ TFS Server Setup - Windows Guide

## Förutsättningar

### 1. Ladda ner och installera
- **Visual Studio 2022** (Community): https://visualstudio.microsoft.com/
  - Välj "Desktop development with C++"
- **MySQL Server 8.0**: https://dev.mysql.com/downloads/mysql/
- **Git**: https://git-scm.com/download/win
- **vcpkg**: https://github.com/microsoft/vcpkg

---

## Steg 1: Klona projektet

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

