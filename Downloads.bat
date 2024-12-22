@echo off

:: Download Python scripts
curl -L -o login.py https://www.dropbox.com/scl/fi/az5jzhpuiylnw7yqw9du5/login.py?rlkey=1qjxif8fu35dh0v77nagv2ihh&dl=1
curl -L -o loop.bat https://www.dropbox.com/scl/fi/vji7ekyslpbovokpqeay3/loop.bat?rlkey=876nfzm3qdmyqhc1jckgqjcld&dl=1
curl -L -o show.bat https://www.dropbox.com/scl/fi/cwbwdo2n3tt8rbqmugc6h/show.bat?rlkey=41m0ds12mg6e28giib3zqlf6w&dl=1

:: Download RustDesk installer
certutil -urlcache -split -f "https://github.com/rustdesk/rustdesk/releases/download/1.2.1/rustdesk-1.2.1-x86_64.exe" rustdesk.exe

:: Install Python packages
pip install pyautogui --quiet
pip install psutil --quiet

:: Download and install Telegram
curl -s -L -o C:\Users\Public\Desktop\Telegram.exe https://telegram.org/dl/desktop/win64
curl -s -L -o C:\Users\Public\Desktop\Winrar.exe https://www.rarlab.com/rar/winrar-x64-621.exe

:: Download VMQuickConfig
powershell -Command "Invoke-WebRequest 'https://github.com/chieunhatnang/VM-QuickConfig/releases/download/1.6.1/VMQuickConfig.exe' -OutFile 'C:\Users\Public\Desktop\VMQuickConfig.exe'"

:: Silent installation of Telegram and WinRAR
C:\Users\Public\Desktop\Telegram.exe /VERYSILENT /NORESTART
del C:\Users\Public\Desktop\Telegram.exe
C:\Users\Public\Desktop\Winrar.exe /S
del C:\Users\Public\Desktop\Winrar.exe

:: Remove desktop shortcuts
del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk" > errormsg.txt 2>&1
del /f "C:\Users\Public\Desktop\Unity Hub.lnk" > errormsg.txt 2>&1

:: Set password for 'runneradmin' user
set password=123
powershell -Command "Set-LocalUser -Name 'runneradmin' -Password (ConvertTo-SecureString -AsPlainText '%password%' -Force)"

:: Start RustDesk
start "" "rustdesk.exe"

:: Run login script
python login.py

:: Modify registry to show 'This PC' on desktop
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

:: Set time zone to Sri Lanka Standard Time
tzutil /s "Sri Lanka Standard Time"
