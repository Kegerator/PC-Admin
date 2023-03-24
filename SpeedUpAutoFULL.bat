@echo off
CLS


mode con:cols=56 lines=9


::Check_Permissions
net session >nul 2>&1
if %errorLevel% == 0 (
    Echo ********************************************************
    Echo *****     Administrative permissions confirmed     *****
) else (
    Color 4F
    Echo ********************************************************
    Echo *****   Failure: Current permissions inadequate    *****
    Echo *****     You need Administrative permissions      *****
    Echo *****         for this to work properly            *****
    Echo ********************************************************
    Echo.
    Pause
    Color 7 
    )


mode con:cols=56 lines=220


:: Start 
Set SYear=%date:~10,4%
Set SMonth=%date:~4,2%
Set SDay=%date:~7,2%
Set StartTime=%Time:~0,5%
Echo.
Echo ********************************************************
Echo *****  ---This will take 20 minutes to 4 hours---  *****
Echo *****                                              *****
Echo ***** Deleting Temp Files                          *****
Echo ***** Start Disk Cleanup                           *****
Echo ***** Check Windows System Files                   *****
Echo ***** Start System Maintenance                     *****
Echo ***** Clear any print jobs and restart the spooler *****
Echo ***** Disable Multicasting                         *****
Echo ***** Change Network Settings                      *****
Echo ***** Flush DNS and reset IP Stack                 *****
Echo ***** Sync time to the Internet                    *****
Echo ***** Set Networks to Private                      *****
Echo ***** Enable File Sharing on Private               *****
Echo ***** Set to High Power                            *****
Echo ***** Disable Visual Effects                       *****
Echo ***** Disable Transparncy                          *****
Echo ***** Enable and Create Restore Point              *****
Echo ***** Schedule the Restore Point every 63 days     *****
Echo ***** Checking C: for Errors                       *****
Echo *****                                              *****
Echo ***** Start Time %SDay%-%SMonth%-%SYear%  %StartTime%
Echo ***** Start Time %SDay%-%SMonth%-%SYear%  %StartTime% >C:\Windows\Temp\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ********************************************************
Echo ****               Log file located at             *****
Echo %temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt
ping -n 1 127.0.0.1 >nul: 2>nul:


:: Deleting Temp Files
Set TTime=%Time:~0,5%
Echo ********************************************************
Echo ***** Deleting Temp Files                          *****
Echo ***** Deleting Temp Files                          ***** >>C:\Windows\Temp\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 to 5 Minutes                               *****
Echo ***** Time %TTime%
Echo ********************************************************
ping -n 2 127.0.0.1 >nul: 2>nul:
del /s /f /q %USERPROFILE%\appdata\local\temp\*.* >>C:\Windows\Temp\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>NUL
ping -n 2 127.0.0.1 >nul: 2>nul:
copy C:\Windows\Temp\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt %temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt >NUL 2>>NUL
ping -n 2 127.0.0.1 >nul: 2>nul:
del /s /f /q %userprofile%\Recent\*.* >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:
del /s /f /q C:\Windows\Prefetch\*.* >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:
del /s /f /q C:\Windows\Temp\*.* >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:
del /s /f /q %USERPROFILE%\appdata\local\Microsoft\Windows\INetCache\*.* >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:
del /s /f /q C:\Windows\Logs\CBS\*.* >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:
:: Clear Temporary Internet File
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:
:: Clear Cookies: 
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:


:: Start Disk Cleanup
Set TTime=%Time:~0,5%
Echo ***** Start Disk Cleanup                           *****
Echo ***** Start Disk Cleanup                           ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 to 15 Minutes                              *****
Echo ***** Time %TTime%
Echo ********************************************************
Call c:\windows\SYSTEM32\cleanmgr /d C /verylowdisk
ping -n 120 127.0.0.1 >nul: 2>nul:


:: Check Windows System Files
Set TTime=%Time:~0,5%
Echo ***** Check Windows System Files, 4 checks         *****
Echo ***** Check Windows System Files, 4 checks         ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 5 Minutes to 2 Hours                         *****
Echo ***** Time %TTime%
Echo *****                                              *****
::
sfc /scannow >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
Set TTime=%Time:~0,5%
Echo ***** Check #1 Done %TTime%                          *****
ping -n 1 127.0.0.1 >nul: 2>nul:
::
DISM /Online /Cleanup-Image /CheckHealth >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
Set TTime=%Time:~0,5%
Echo ***** Check #2 Done %TTime%                          *****
ping -n 1 127.0.0.1 >nul: 2>nul:
::
DISM /Online /Cleanup-Image /ScanHealth >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
Set TTime=%Time:~0,5%
Echo ***** Check #3 Done %TTime%                          *****
ping -n 1 127.0.0.1 >nul: 2>nul:
::
DISM /Online /Cleanup-Image /RestoreHealth >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
Set TTime=%Time:~0,5%
Echo ***** Check #4 Done %TTime%                          *****
Echo ********************************************************
ping -n 1 127.0.0.1 >nul: 2>nul:


:: Start System Maintenance Silent
Set TTime=%Time:~0,5%
Echo ***** Starting System Maintenance                  *****
Echo ***** Starting System Maintenance                  ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 2 Minutes, then will run in the background   *****
Echo ***** Time %TTime%
Echo ********************************************************
ping -n 2 127.0.0.1 >nul: 2>nul:
:: Enable Auto Maintenance
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /V "MaintenanceDisabled" /T REG_DWORD /D "0" /f >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:
:: Start Maintenance
MSchedExe.exe Start >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 120 127.0.0.1 >nul: 2>nul:


:: Clear any print jobs and restart the spooler
Set TTime=%Time:~0,5%
Echo ***** Clear any print jobs and restart the spooler *****
Echo ***** Clear any print jobs and restart the spooler ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 Minute                                     *****
Echo ***** Time %TTime%
Echo ********************************************************
:$reference https://www.dostips.com/
:$reference https://support.microsoft.com/kb/946737
net stop spooler /y >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
del "%systemroot%\system32\spool\printers\*.shd" >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
del "%systemroot%\system32\spool\printers\*.spl" >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
net start spooler >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 3 127.0.0.1 >nul: 2>nul:


:: Disable Multicasting
Set TTime=%Time:~0,5%
Echo ***** Disable Multicasting                         *****
Echo ***** Disable Multicasting                         ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 Minute                                     *****
Echo ***** Time %TTime%
Echo ********************************************************
netsh int ipv4 set global multicastforwarding=disabled >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 3 127.0.0.1 >nul: 2>nul:


:: Network Settings
Set TTime=%Time:~0,5%
Echo ***** Change Network Settings                      *****
Echo ***** Change Network Settings                      ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 Minute                                     *****
Echo ***** Time %TTime%
Echo ********************************************************
:: Disable Ethernet adapter power management
powershell -Command "Disable-NetAdapterPowerManagement -Name Ethernet" >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
:: Disable Energy-Efficient Ethernet
netsh interface tcp set global eee=disabled >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
:: Disable various advanced Ethernet adapter properties
netsh interface tcp set global flowcontrol=disabled >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
netsh interface tcp set global rss=disabled >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
netsh interface tcp set global green=disabled >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
netsh interface tcp set global chimney=disabled >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
netsh interface tcp set global arpo=disabled >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
netsh interface tcp set global nso=disabled >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
netsh interface tcp set global csumipv4=disabled >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
netsh interface tcp set global udpcsumipv4=disabled >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
netsh interface tcp set global intmod=disabled >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
netsh interface tcp set global jumbo=disabled >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
netsh interface tcp set global jumbopacket=disabled >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
netsh interface tcp set global pfc=disabled >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
netsh interface tcp set global magic=disabled >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
netsh interface tcp set global vlan=disabled >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt>>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
netsh interface ipv6 set state disabled >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:
REM Disable Enable PME
powershell -Command "Set-NetAdapterAdvancedProperty -Name Ethernet -DisplayName 'Enable PME' -DisplayValue 'Disabled'" >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:
REM Disable Interrupt Moderation
powershell -Command "Set-NetAdapterAdvancedProperty -Name Ethernet -DisplayName 'Interrupt Moderation' -DisplayValue 'Disabled'" >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:

::  Flush DNS and reset IP Stack
Set TTime=%Time:~0,5%
Echo ***** Flush DNS and reset IP Stack                 *****
Echo ***** Flush DNS and reset IP Stack                 ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 2 Minutes                                    *****
Echo ***** Time %TTime%
Echo ********************************************************
ipconfig /flushdns >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 4 127.0.0.1 >nul: 2>nul:
netsh winsock reset >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 4 127.0.0.1 >nul: 2>nul:
:: The following lines have been commented out because, if the PC has a static IP it will loose it's network connection.
:: netsh int ip reset >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
:: ping -n 4 127.0.0.1 >nul: 2>nul:
:: ipconfig /release >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
:: ping -n 4 127.0.0.1 >nul: 2>nul:
:: ipconfig /renew >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 3 127.0.0.1 >nul: 2>nul:


:: Sync time to the Internet
Set TTime=%Time:~0,5%
Echo ***** Sync time to the Internet                    *****
Echo ***** Sync time to the Internet                    ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 Minute                                     *****
Echo ***** Time %TTime%
Echo ********************************************************
Set-TimeZone "Eastern Standard Time" >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
net stop w32time >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
w32tm /unregister >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
w32tm /config /syncfromflags:manual /manualpeerlist:"0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org" >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
w32tm /config /update >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
w32tm /register >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
net start w32time >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
w32tm /resync /rediscover >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 3 127.0.0.1 >nul: 2>nul:


:: Set Networks to Private
Set TTime=%Time:~0,5%
Echo ***** Set Networks to Private                      *****
Echo ***** Set Networks to Private                      ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 Minute                                     *****
Echo ***** Time %TTime%
Echo ********************************************************
setlocal EnableDelayedExpansion
for /f "tokens=*" %%a in ('powershell -Command "Get-NetConnectionProfile -ErrorAction Stop | Where-Object { $_.NetworkCategory -match 'Public' }"') do set connectionProfile=%%a

if defined connectionProfile (
    powershell -Command "try { Set-NetConnectionProfile -InputObject $connectionProfile -NetworkCategory Private -ErrorAction Stop; Write-Host 'Network category changed to Private.' } catch { Write-Error 'Failed to change network category: ' + $_.Exception.Message -ForegroundColor Red }" >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
) else (
    echo No active public network connection found.
)
ping -n 2 127.0.0.1 >nul: 2>nul:

:: Enable File Sharing
Set TTime=%Time:~0,5%
Echo ***** Enable File Sharing on Private               *****
Echo ***** Enable File Sharing on Private               ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 Minute                                     *****
Echo ***** Time %TTime%
Echo ********************************************************
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes
:: Set file shareing on the Private network
REM Disable File and Printer Sharing for Public profile
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=No profile=Public >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
REM Enable File and Printer Sharing for Private profile
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes profile=Private >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:

:: Set to High Power
Set TTime=%Time:~0,5%
Echo ***** Set to High Power                            *****
Echo ***** Set to High Power                            ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 Minute                                     *****
Echo ***** Time %TTime%
Echo ********************************************************
& powercfg.exe -x -monitor-timeout-ac 120 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
& powercfg.exe -x -monitor-timeout-dc 120 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
& powercfg.exe -x -disk-timeout-ac 0 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
& powercfg.exe -x -disk-timeout-dc 0 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
& powercfg.exe -x -standby-timeout-ac 0 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
& powercfg.exe -x -standby-timeout-dc 0 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
& powercfg.exe -x -hibernate-timeout-ac 0 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
& powercfg.exe -x -hibernate-timeout-dc 0 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
:: Disable USB Selective Suspend 
& powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
:: Disable hibernation/sleep
Start-Process 'powercfg.exe' -Verb runAs -ArgumentList '/h off' >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
:: Disable Connected Standby (CSEnabled)
Set-ItemProperty -Path "HKLM:\SYSTEM\\CurrentControlSet\Control\Power" -Name "CSEnabled" -Type DWord -Value 0 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:


:: Create Restore Point
Set TTime=%Time:~0,5%
Echo ***** Enable and Create Restore Point              *****
Echo ***** Enable and Create Restore Point              ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 5 Minutes                                    *****
Echo ***** Time %TTime%
Echo ********************************************************
:: Enable system restore
Reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v DisableSR /t REG_DWORD /d 1 /f >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 1 127.0.0.1 >nul: 2>nul:
:: Create a Restore Point
Wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Finished Speed Up Process", 100, 12 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 300 127.0.0.1 >nul: 2>nul:


::Disable Visual Effects
Set TTime=%Time:~0,5%
Echo ***** Disable Visual Effects                       *****
Echo ***** Disable Visual Effects                       ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 Minute                                     *****
Echo ***** Time %TTime%
Echo *****                                              *****
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:


:: Disable Transparncy
Set TTime=%Time:~0,5%
Echo ***** Disable Transparncy                          *****
Echo ***** Disable Transparncy                          ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 Minute                                     *****
Echo ***** Time %TTime%
Echo *****                                              *****
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /V "EnableTransparency /T REG_DWORD /D 0 /F >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:


:: Schedule the Restore Point to run every 63 days if one does not exist called RestorePoint
Set TTime=%Time:~0,5%
Echo ***** Schedule the Restore Point every 63 days     *****
Echo ***** Schedule the Restore Point every 63 days     ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 Minutes                                    *****
Echo ***** Time %TTime%
Echo ********************************************************
schtasks /create /tn RestorePoint /tr "powershell.exe Checkpoint-Computer -Description RestorePoint" /sc daily /mo 63 /sd 12/31/2021 /st 22:00 /f /IT >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt 
ping -n 3 127.0.0.1 >nul: 2>nul:

:: Checking C: for errors
Set TTime=%Time:~0,5%
Echo ***** Checking C: for Errors                       *****
Echo ***** Checking C: for Errors                       ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 Minute                                     *****
Echo ***** Time %TTime%
Echo *****                                              *****
fsutil dirty query C: >nul
if %errorlevel% neq 0 (
Echo ***** The dirty bit is set on C: drive.            *****
Echo ***** Running chkdsk on next reboot...             *****
Echo ***** Running chkdsk on next reboot...             ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
chkdsk C: /f /x /r
) else (
Echo ***** The dirty bit is not set on C: drive.        *****
Echo ***** The dirty bit is not set on C: drive.        ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
)
Echo ********************************************************

:: start notepad "%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt"

:: Done
Set TYear=%date:~10,4%
Set TMonth=%date:~4,2%
Set TDay=%date:~7,2%
Set StopTime=%Time:~0,5%
Echo.
Echo ********************************************************
Echo ***** Rebooting in 2 minutes                       *****
Echo ***** Rebooting in 2 minutes                       ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** Start Time %SDay%-%SMonth%-%SYear%  %StartTime% >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** Stop Time  %TDay%-%TMonth%-%TYear%  %StopTime%  >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** Start Time %SDay%-%SMonth%-%SYear%  %StartTime%
Echo ***** Stop Time  %TDay%-%TMonth%-%TYear%  %StopTime%
Echo ********************************************************
ping -n 10 127.0.0.1 >nul: 2>nul
Echo ***** 1:50                                         *****
ping -n 10 127.0.0.1 >nul: 2>nul
Echo ***** 1:40                                         *****
ping -n 10 127.0.0.1 >nul: 2>nul
Echo ***** 1:30                                         *****
ping -n 101 127.0.0.1 >nul: 2>nul
Echo ***** 1:20                                         *****
ping -n 10 127.0.0.1 >nul: 2>nul
Echo ***** 1:10                                         *****
ping -n 10 127.0.0.1 >nul: 2>nul
Echo ***** 1:00                                         *****
ping -n 10 127.0.0.1 >nul: 2>nul
Echo ***** 0:50                                         *****
ping -n 10 127.0.0.1 >nul: 2>nul
Echo ***** 0:40                                         *****
ping -n 10 127.0.0.1 >nul: 2>nul
Echo ***** 0:30                                         *****
ping -n 10 127.0.0.1 >nul: 2>nul
Echo ***** 0:20                                         *****
ping -n 10 127.0.0.1 >nul: 2>nul
Echo ***** 0:10                                         *****
ping -n 10 127.0.0.1 >nul: 2>nul
Echo *****  Thank you                                   *****
Echo ********************************************************
ping -n 3 127.0.0.1 >nul: 2>nul
shutdown /r /f /c "Speedup Process Completed"  >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt