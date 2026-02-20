@echo off
echo ===================================================
echo Fetching and Installing ESP32 IoT Environment...
echo ===================================================

:: 1. Install Arduino IDE and CLI via Winget
echo [1/6] Installing Arduino IDE and CLI...
winget install -e --id ArduinoSA.IDE.stable --silent --accept-package-agreements --accept-source-agreements
winget install -e --id ArduinoSA.CLI --silent --accept-package-agreements --accept-source-agreements

:: Refresh the PATH variable for the current session so we can use arduino-cli immediately
echo Reloading Windows Environment Variables...
for /f "tokens=2*" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path') do set "syspath=%%B"
for /f "tokens=2*" %%A in ('reg query "HKCU\Environment" /v Path 2^>nul') do set "userpath=%%B"
set "PATH=%userpath%;%syspath%;%PATH%"

:: 2. Configure Arduino CLI for ESP32
echo [2/6] Adding Espressif Board URL...
arduino-cli core update-index --additional-urls https://dl.espressif.com/dl/package_esp32_index.json

:: 3. Download and Install the ESP32 Core
echo [3/6] Installing ESP32 Board Core...
arduino-cli core install esp32:esp32 --additional-urls https://dl.espressif.com/dl/package_esp32_index.json

:: 4. Install IoT Libraries
echo [4/6] Installing IoT Libraries...
arduino-cli lib install "WiFi"

:: 5. Fetch Drivers to the TEMP folder
echo [5/6] Downloading drivers...

:: Download universal CH340 driver
echo Downloading CH340...
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/YutharsanS/sliot-workshop-materials/raw/refs/heads/main/CH341SER.EXE' -OutFile "$env:TEMP\CH341SER.EXE""

:: Download and Extract the CP210x ZIP file
echo Downloading CP210x Archive...
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/YutharsanS/sliot-workshop-materials/raw/refs/heads/main/CP210x_VCP_Windows.zip' -OutFile \"$env:TEMP\CP210x_Drivers.zip\""

echo Extracting CP210x Archive...
:: This extracts the contents into a new folder called 'CP210x' inside the TEMP directory
powershell -Command "Expand-Archive -Path \"$env:TEMP\CP210x_Drivers.zip\" -DestinationPath \"$env:TEMP\CP210x\" -Force"

:: 6. Install USB Drivers Manually (One by One)
echo [6/6] Opening USB Driver Installers...
echo Please follow the prompts on the screen to install each driver.

echo.
echo Opening CH340 Installer...
start /wait "" "%TEMP%\CH341SER.EXE"

echo.
echo Opening CP210x Installer...
:: Check the architecture here and launch the correct .exe from the extracted folder
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    echo Launching 64-bit CP210x Installer...
    start /wait "" "%TEMP%\CP210x\CP210x_VCP_Windows\CP210xVCPInstaller_x64.exe"
) else (
    echo Launching 32-bit CP210x Installer...
    start /wait "" "%TEMP%\CP210x\CP210x_VCP_Windows\CP210xVCPInstaller_x86.exe"
)

:: Clean up downloaded files and extracted folders to keep the lab PCs tidy
del "%TEMP%\CH341SER.EXE"
del "%TEMP%\CP210x_Drivers.zip"
rmdir /s /q "%TEMP%\CP210x"

echo.
echo ===================================================
echo Setup Complete! All tools and libraries are ready.
echo ===================================================
echo To ensure the USB drivers bind correctly to Windows,
echo a system reboot is highly recommended.
echo.

:: Prompt for Reboot
choice /C YN /M "Would you like to reboot this computer now"
if errorlevel 2 goto NoReboot
if errorlevel 1 goto Reboot

:Reboot
echo Rebooting in 10 seconds... Save any open work!
shutdown /r /t 10
goto End

:NoReboot
echo.
echo Please remember to reboot before the session starts!
goto End

:End
pause

C:\Users\YUTHAR~1\AppData\Local\Temp\CP210x\
