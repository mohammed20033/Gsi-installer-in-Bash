@echo off
cls
echo. GSI INSTALLER FOR SELENE
echo.
echo. By seveN
echo.
echo.
pause
echo.
echo. Go in normal fastboot and press enter ...
pause >nul
echo.
REM set /p boot=Are you want to flash boot.img? (y/n): 
REM if "%boot%"=="y" (
REM     set /p boot_img=Drag boot.img here: 
REM     echo.
REM     echo. Flashing boot...
REM     echo.
REM     fastboot flash boot %boot_img%
REM     echo.
REM     echo. Done
REM ) else if "%boot%"=="n" (
REM     echo. Skipping...
REM ) else (
REM     echo. Invalid input!
REM )
echo.
set /p gsi_img=Drag GSI file here and press enter: 
echo.
set /p vbmeta_img=Okay, now drag vbmeta file here and press enter: 
cls
echo. Now sit back and get coffee; everything is automated
timeout 2 >nul
echo.
echo. Disabling VBmeta
echo.
fastboot --disable-verity --disable-verification flash vbmeta %vbmeta_img%
echo.
echo. Done
echo.
echo.-----------------------------------------------------------
echo.
echo. Going to fastbootD ...
echo.
fastboot reboot fastboot
echo.
echo. Done
echo.-----------------------------------------------------------
echo.
echo. Erasing userdata ...
echo.
fastboot erase userdata
echo.
echo. Done
echo.-----------------------------------------------------------
echo.
echo. Erasing system ...
echo.
fastboot erase system
echo.
echo. Done
echo.-----------------------------------------------------------
echo.
echo. Flashing GSI image to slot A...
echo.
fastboot flash system_a %gsi_img%
echo.
echo. Done
echo.
echo.-----------------------------------------------------------
echo.
echo. Going to recovery now ... do wipe data then restarte.
pause >nul
fastboot reboot recovery
echo.-----------------------------------------------------------
echo.
echo. Bakaaa byeee <3 ...
echo.
echo.
pause
