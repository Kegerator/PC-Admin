@Echo Off
CLS
:: *** Date and Time
Echo.
Set StartTime=%Time:~0,5%
Echo.
Echo %StartTime%

DISM /Online /Cleanup-Image /CheckHealth

DISM /Online /Cleanup-Image /ScanHealth

DISM /Online /Cleanup-Image /RestoreHealth /Source:repairSource\install.wim

sfc /scannow

:: *** Date and Time
Set StopTime=%Time:~0,5%
Echo.
Echo Start Time %StartTime%
Echo  Stop Time %StopTime%
Echo.
Echo Thank you
