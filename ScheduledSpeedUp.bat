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
    ping -n 10 127.0.0.1 >nul: 2>nul:
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
Echo *****  ---This will take 10 minutes to 2 hours---  *****
Echo *****                                              *****
Echo ***** Deleting Temp Files                          *****
Echo ***** Running Windows Disk Clean up Tool           *****
Echo ***** Check Windows System Files                   *****
Echo ***** Start System Maintenance                     *****
Echo ***** Flush DNS and reset IP Stack                 *****
Echo ***** Sync time to the Internet                    *****
Echo *****                                              *****
Echo ***** Start Time %SDay%-%SMonth%-%SYear%  %StartTime%
Echo ***** Start Time %SDay%-%SMonth%-%SYear%  %StartTime% >C:\Windows\Temp\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ********************************************************
Echo ****               Log file located at             *****
Echo %temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:


:: Deleting Temp Files
Set TTime=%Time:~0,5%
Echo ********************************************************
Echo ***** Deleting Temp Files                          *****
Echo ***** Deleting Temp Files                          ***** >>C:\Windows\Temp\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 5 Minutes                                    *****
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


:: Running Windows Disk Clean up Tool
Set TTime=%Time:~0,5%
Echo ********************************************************
Echo ***** Running Windows Disk Clean up Tool           *****
Echo ***** Running Windows Disk Clean up Tool           ***** >>C:\Windows\Temp\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 5 Minutes                                    *****
Echo ***** Time %TTime%
Echo ********************************************************
cleanmgr /sagerun:1 | out-Null
ping -n 2 127.0.0.1 >nul: 2>nul:


:: Check Windows System Files
Set TTime=%Time:~0,5%
Echo ***** Check Windows System Files, 4 checks         *****
Echo ***** Check Windows System Files, 4 checks         ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 2 Hours                                      *****
Echo ***** Time %TTime%
Echo *****                                              *****
DISM /Online /Cleanup-Image /CheckHealth >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
Set TTime=%Time:~0,5%
Echo ***** Check #1 Done %TTime%                          *****
ping -n 10 127.0.0.1 >nul: 2>nul:
DISM /Online /Cleanup-Image /ScanHealth >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
Set TTime=%Time:~0,5%
Echo ***** Check #2 Done %TTime%                          *****
ping -n 10 127.0.0.1 >nul: 2>nul:
DISM /Online /Cleanup-Image /RestoreHealth >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
Set TTime=%Time:~0,5%
Echo ***** Check #3 Done %TTime%                          *****
ping -n 10 127.0.0.1 >nul: 2>nul:
sfc /scannow >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
Set TTime=%Time:~0,5%
Echo ***** Check #4 Done %TTime%                          *****
Echo ********************************************************
ping -n 10 127.0.0.1 >nul: 2>nul:


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
ping -n 30 127.0.0.1 >nul: 2>nul:


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
ping -n 30 127.0.0.1 >nul: 2>nul:


:: start notepad "%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt"

:: Done
Set TYear=%date:~10,4%
Set TMonth=%date:~4,2%
Set TDay=%date:~7,2%
Set StopTime=%Time:~0,5%
Echo.
Echo ********************************************************
Echo ***** Doing the last cleanup                       *****
Echo ***** Doing the last cleanup                       ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 Minutes                                    *****
Echo ***** Start Time %SDay%-%SMonth%-%SYear%  %StartTime% >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** Stop Time  %TDay%-%TMonth%-%TYear%  %StopTime%  >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** Start Time %SDay%-%SMonth%-%SYear%  %StartTime%
Echo ***** Stop Time  %TDay%-%TMonth%-%TYear%  %StopTime%
Echo *****  Thank you                                   *****
Echo ********************************************************
ping -n 6 127.0.0.1 >nul: 2>nul