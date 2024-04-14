@echo off
mode con: cols=80 lines=25
color 0E
title PT Spoofer

:MainMenu
color 0E
cls
echo.
echo.
echo                     ------------------------------------
echo                         Welcome to PT Spoofer!
echo                     ------------------------------------
echo.
echo                         1. Change Disk Serials
echo                         2. Change MAC Address
echo                         3. Spoof System Information
echo                         4. Serial Check
echo                         5. Cleaning
echo                         6. Exit
echo.
echo                     ------------------------------------
echo                     Choose an option (1-6) and press Enter:
echo.
set /p choice=

if "%choice%"=="1" goto ChangeDiskSerials
if "%choice%"=="2" goto ChangeMACAddress
if "%choice%"=="3" goto SpoofSystemInfo
if "%choice%"=="4" goto SerialCheck
if "%choice%"=="5" goto Clean
if "%choice%"=="6" goto End

echo Invalid choice, please try again.
pause
goto MainMenu

:ChangeDiskSerials
color 02
cls
start "" "%~dp0HardDisk.exe"
echo Press any key after changing your disk serials...
pause > nul
goto MainMenu

:ChangeMACAddress
color F4
cls
start "" "%~dp0MAC_Address_Changer.exe"
echo Change your MAC Address and press any key ONLY after your internet comes back...
pause > nul
goto MainMenu

:SpoofSystemInfo
color 01
cls
echo Spoofing System Information...
cd %~dp0
AMIDEWINx64.EXE /SU auto
AMIDEWINx64.EXE /SS "Default string"
AMIDEWINx64.EXE /SV "1.0"
AMIDEWINx64.EXE /CSK "Default string"
AMIDEWINx64.EXE /CM  "Default string"
AMIDEWINx64.EXE /SP "MS-7D22"
AMIDEWINx64.EXE /SM "Micro-Star International Co., Ltd."
AMIDEWINx64.EXE /SK "Default string"
AMIDEWINx64.EXE /SF "Default string"
AMIDEWINx64.EXE /BM "Micro-Star International Co., Ltd."
AMIDEWINx64.EXE /BP "H510M-A PRO (MS-7D22)"
AMIDEWINx64.EXE /BV "1.0"
AMIDEWINx64.EXE /BT "Default string"
AMIDEWINx64.EXE /BLC "Default string"
AMIDEWINx64.EXE /PSN "To Be Filled By O.E.M."
AMIDEWINx64.EXE /PAT "To Be Filled By O.E.M."
AMIDEWINx64.EXE /PPN "To Be Filled By O.E.M."
AMIDEWINx64.EXE /CSK "Default string"
AMIDEWINx64.EXE /CS "Default string"
AMIDEWINx64.EXE /CV "1.0"
AMIDEWINx64.EXE /CM "Micro-Star International Co., Ltd."
AMIDEWINx64.EXE /CA "Default string"
AMIDEWINx64.EXE /CO "0000 0000h"
AMIDEWINx64.EXE /CT "03h"
AMIDEWINx64.EXE /IV "3.80"
AMIDEWINx64.EXE /IVN "American Megatrends International, LLC."
AMIDEWINx64.EXE /BS "%random%%random%"
cls
net stop winmgmt /y
net start winmgmt /y
sc stop winmgmt
timeout 1
sc start winmgmt
timeout 1
echo Successfully Spoofed. Press any key to return to the main menu...
pause > nul
goto MainMenu

:SerialCheck
color 05
mode con: cols=70 lines=35
:SerialCheckLoop
cls
echo Performing Serial Check...
:diocane
cls
echo Bios
wmic bios get serialnumber
wmic csproduct get uuid
echo CPU
wmic cpu get serialnumber
wmic cpu get processorid
echo Diskdrive
wmic diskdrive get serialnumber
echo Baseboard serialnumber
wmic baseboard get serialnumber
echo Baseboard manufacturer
wmic baseboard get manufacturer
echo MacAddress
wmic path Win32_NetworkAdapter where "PNPDeviceID like '%%PCI%%' AND NetConnectionStatus=2 AND AdapterTypeID='0'" get MacAddress
echo Press any key to perform the check again, or 'Q' to return to the main menu...
set /p choice=
if /I "%choice%"=="Q" goto MainMenu
goto SerialCheckLoop

:Clean
echo Cleaning...
del /f /s /q "x:\%localappdata%\Nova"
del /f /s /q "x:\%appdata%\Nova"
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppSwitched" /f
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\UFH\SHC" /f
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\UFH\SHC" /f
goto MainMenu

:End
color 0E
cls
echo Goodbye! The program will exit in 5 seconds...
timeout /t 5 /nobreak > nul
exit
