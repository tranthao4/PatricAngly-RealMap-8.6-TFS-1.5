@echo off
title TFS Server Console
echo Starting The Forgotten Server...
echo.

:: Kör din server (byt ut 'tfs.exe' om din .exe-fil heter något annat)
theforgottenserver-x64.exe

:: Om något går fel, pausa så du kan läsa det
echo.
echo Server process finished. Press any key to close this window.
pause >nul
