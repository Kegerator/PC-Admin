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
Echo ***** Flush DNS and reset IP Stack                 *****
Echo ***** Check the Gateway and DNS Servers            *****
Echo ***** Sync time to the Internet                    *****
Echo ***** Enable and Create Restore Point              *****
Echo ***** Schedule the Restore Point every 63 days     *****
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
c:\windows\SYSTEM32\cleanmgr /d C /verylowdisk
ping -n 10 127.0.0.1 >nul: 2>nul:


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



:: Check the Gateway and DNS Servers
Set TTime=%Time:~0,5%
Echo ***** Check the Gateway and DNS Servers            *****
Echo ***** Check the Gateway and DNS Servers            ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 Minute                                     *****
Echo *****
setlocal enabledelayedexpansion
:: Find the gateway's IP address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr "Default"') do set gateway=%%a
:: Remove any spaces from the gateway IP address
set gateway=!gateway: =!
:: Ping the gateway
IPconfig /all >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** Pinging the Gateway                          *****
ping %gateway%
ping %gateway% >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
:: Getting DNS Server address
for /f "tokens=2 delims=:" %%a in ('ipconfig /all ^| findstr /c:"DNS Servers"') do (
    set dnsServer=%%a
    Echo ***** DNS Server: !dnsServer!
    set isIP=false
    rem Check if it's an IPv4 address
    for /f "tokens=1-4 delims=." %%b in ("!dnsServer!") do (
        if "%%d" neq "" (
            set isIP=true
        )
    )
    rem Check if it's an IPv6 address
    echo ***** !dnsServer! | findstr /c:"[::]" >nul
    if !errorlevel!==0 (
        set isIP=true
    )
    if !isIP!==true (
        powershell -Command "& {(New-Object Net.Sockets.TcpClient).Connect('!dnsServer!', 53)}" >nul 2>&1
        if !errorlevel!==0 (
            Echo ***** Port 53 is open on !dnsServer!
            Echo ***** Port 53 is open on !dnsServer! >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
        ) else (
            Echo ***** Port 53 is closed on !dnsServer!
            Echo ***** Port 53 is closed on !dnsServer! >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
        )
    ) else (
        Echo ***** DNS Server hostname, resolving to IP address... *****
        Echo ***** DNS Server hostname, resolving to IP address... >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
        for /f "tokens=2 delims=[]" %%c in ('ping -n 1 !dnsServer! ^| findstr /c:"["') do (
            set IPAddress=%%c
            Echo ***** IP Address: !IPAddress! 
            powershell -Command "& {(New-Object Net.Sockets.TcpClient).Connect('!IPAddress!', 53)}" >nul 2>&1
            if !errorlevel!==0 (
                Echo ***** Port 53 is open on !IPAddress!  
                Echo ***** Port 53 is open on !IPAddress! >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt
            ) else (
                Echo ***** Port 53 is closed on !IPAddress!
                Echo ***** Port 53 is closed on !IPAddress! >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt
            )
        )
    )
)
endlocal
Echo ***** Time %TTime%
Echo ********************************************************




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
:: Check for any errors
if %errorlevel% neq 0 (
    :: An error occurred, print an error message
    echo An error occurred while creating the restore point. 
    echo An error occurred while creating the restore point. >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
) else (
    :: No error occurred, print a success message
    echo The restore point was created successfully.
    echo The restore point was created successfully. >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
)
**********************
ping -n 300 127.0.0.1 >nul: 2>nul:


:: Schedule the Restore Point to run every 63 days if one does not exist called RestorePoint
Set TTime=%Time:~0,5%
Echo ***** Schedule the Restore Point every 63 days     *****
Echo ***** Schedule the Restore Point every 63 days     ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 Minutes                                    *****
Echo ***** Time %TTime%
Echo ********************************************************
schtasks /create /tn RestorePoint /tr "powershell.exe Checkpoint-Computer -Description RestorePoint" /sc daily /mo 63 /sd 12/31/2021 /st 22:00 /f /IT >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt 
ping -n 3 127.0.0.1 >nul: 2>nul:


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
Echo ********************************************************
ping -n 6 127.0.0.1 >nul: 2>nul
Echo ***** Rebooting in 2:00 minutes                    *****
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