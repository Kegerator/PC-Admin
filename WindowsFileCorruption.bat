@Echo Off
CLS


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


:: *** Date and Time
Echo.
Set StartTime=%Time:~0,5%
Echo *************************
Echo ***** Starting %StartTime%

DISM /Online /Cleanup-Image /CheckHealth
Set TTime=%Time:~0,5%
Echo ***** Check #1 Done ***** %TTime% 

ping -n 10 127.0.0.1 >nul: 2>nul:
DISM /Online /Cleanup-Image /ScanHealth
Set TTime=%Time:~0,5%
Echo ***** Check #2 Done ***** %TTime%  

ping -n 10 127.0.0.1 >nul: 2>nul:
DISM /Online /Cleanup-Image /RestoreHealth /Source:repairSource\install.wim
Set TTime=%Time:~0,5%
Echo ***** Check #3 Done ***** %TTime%  

ping -n 10 127.0.0.1 >nul: 2>nul:
sfc /scannow
Set TTime=%Time:~0,5%
Echo ***** Check #4 Done *****%TTime%  
Echo *************************

:: *** Date and Time
Set StopTime=%Time:~0,5%
Echo.
Echo Start Time %StartTime%
Echo  Stop Time %StopTime%
Echo.
Echo Thank you
ping -n 10 127.0.0.1 >nul: 2>nul: