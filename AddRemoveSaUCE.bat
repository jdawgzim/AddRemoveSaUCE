@echo off
setlocal enabledelayedexpansion

:: Instructions:
:: 1. Create directory structure and apply patches
:: 2. Edit script to already include your source and target paths
:: 3. Edit script to add additional saUCE folders below
:: 4. Make your addlist.txt or removelist.txt
:: 5. Run script
:: 6. Add intro.mp4 to cox/custom and 
:: 7. Add cox/playlists and cox/playlist_art

:: Notes:
::   You can leave games in the cox\playlists that have no UCE.  CoinopsX will ignore it.
::   This script can handle '!' and '&' in the filenames.  It replaces them with '*'
::   (i.e. "Mr Do!" -> "Mr Do*")

set saucepath=F:\Downloads\CoinOpsX
:: set /p saucepath="Give full path to where to saUCEs are (i.e. H: or C:\CoinopsX)? "
REM Choose which line above to comment out to determine what saucepath is.
REM If your v5 saUCE is here:    C:\Users\Bob\Downloads\CoinOps X Arcade Version 5 is Alive Saucey Edition
REM then set the above line to:  set saucepath=C:\Users\Bob\Downloads

echo.
echo *** saUCE Games Add/Remove Script ***
echo.

set target=D:\MyTrash\alu
::set /p target="Give target path to where to Add/Remove files (i.e. H: or C:\CoinopsX)? "
REM Choose which line above to comment out to determine what target is.
REM I recommend using a PC SSD directory as target instead of your USB stick
REM   because you can run AddonX Tool on that directory instead of taking your
REM   USB stick away from your arcade.  Once AddonX is done copy everything over 
REM   to the USB quickly.

set CUR_YYYY=%date:~10,4%
set CUR_MM=%date:~4,2%
set CUR_DD=%date:~7,2%
set DATENAME=%CUR_YYYY%%CUR_MM%%CUR_DD%

:PICKFOLDER
echo.
echo Available folders:
echo 1. Arcade
echo 2. 3 Player Build
echo 3. 4 Player Build
echo 4. Daphne
echo 5. Lightgun Build
echo 6. example1
echo 7. example2
echo 8. ScummVM
echo 9. ColecoV
echo 0. Genesis
echo a. SegaCD
echo b. PCECD
echo c. PCECD
echo.
choice /c:1234567890abc /m "Which folder you would like to work with "
set ChoiceLevel=%ErrorLevel%
echo %ChoiceLevel%
if %ChoiceLevel% equ 1 (
	set folder=CoinopsX Arcade Version 5 is Alive Saucey Edition
	set uce=Arcade
)
if %ChoiceLevel% equ 2 (
	set folder=CoinopsX Arcade Version 5 is Alive Saucey Edition
	set uce=3 Player Build
)
if %ChoiceLevel% equ 3 (
	set folder=CoinopsX Arcade Version 5 is Alive Saucey Edition
	set uce=4 Player Build
)
if %ChoiceLevel% equ 4 (
	set folder=CoinopsX Arcade Version 5 is Alive Saucey Edition
	set uce=Daphne
)
if %ChoiceLevel% equ 5 (
	set folder=CoinopsX Arcade Version 5 is Alive Saucey Edition
	set uce=Lightgun Build
)
if %ChoiceLevel% equ 6 (
	set folder=CoinopsX saUCEd example1 Edition
	set uce=example1
)
if %ChoiceLevel% equ 7 (
	set folder=CoinopsX saUCEd example2 Edition
	set uce=example2
)
if %ChoiceLevel% equ 8 (
	set folder=CoinopsX ScummVM edition
	set uce=ScummVM
)
if %ChoiceLevel% equ 9 (
	set folder=CoinopsX saUCEd ColecoVision Edition
	set uce=ColecoV
)
if %ChoiceLevel% equ 10 (
	set folder=CoinopsX saUCEd Genesis Edition
	set uce=Genesis
)
if %ChoiceLevel% equ 11 (
	set folder=CoinopsX saUCEd SegaCD Edition
	set uce=SegaCD
)
if %ChoiceLevel% equ 12 (
	set folder=CoinopsX saUCEd PCECD Edition
	set uce=PCECD
)
if %ChoiceLevel% equ 13 (
	set folder=CoinopsX saUCEd PCECD Edition
	set uce=PCECD
)
echo Source: "%saucepath%\%folder%\%uce%"
echo Target: "%target%"

:PICKTASK
echo.
echo Options:
echo 1. Add a single game.
echo 2. Add games in addlist.txt
echo 3. Add all games in %target%\cox\playlists
echo 4. Remove a single game.
echo 5. Remove games in removelist.txt
echo 6. Remove all games in %target%\cox\playlists
echo.
choice /c:123456 /m "What would you like to do "
set ChoiceLevel=%ErrorLevel%
if %ChoiceLevel% equ 1 goto :ADDGAME
if %ChoiceLevel% equ 2 goto :ADDLIST
if %ChoiceLevel% equ 3 goto :ADDPLAYLISTS
if %ChoiceLevel% equ 4 goto :REMOVEGAME
if %ChoiceLevel% equ 5 goto :REMOVELIST
if %ChoiceLevel% equ 6 goto :REMOVEPLAYLISTS


:ADDGAME
echo.
set /p game="What is the filename of the game you want to add? "
@REM Allows exclamation points to pass
setlocal disabledelayedexpansion
call :PROCESSADD "%game%"
goto :END


:ADDLIST
echo.
set /p yesaddlist="Add all games in addlist.txt? (Y/N): "
if /i "%yesaddlist%" neq "Y" goto :END
echo.
echo Adding games in addlist.txt to %target%\%uce% ...
call :PROCESSADDLIST "addlist.txt"
goto :END


:ADDPLAYLISTS
echo.
set /p yesaddplaylists="Are you sure you want to add all games in the playlists in %target%\cox\playlists\? (Y/N): "
if /i "%yesaddplaylists%" neq "Y" goto :END
for %%f in (%target%\cox\playlists\*) do (
	echo.
	echo.
	echo Adding games in the "%%~nxf" playlist ...
	call :PROCESSADDLIST "%%f"
)
goto :END


:REMOVEGAME
echo.
set /p game="What is the filename of the game you want to remove? "
call :PROCESSREMOVE "%game%"
goto :END


:REMOVELIST
echo.
set /p yesremovelist="Remove all games in removelist.txt? (Y/N): "
if /i "%yesremovelist%" neq "Y" goto :END
echo.
echo Removing games in removelist.txt from %target%\%uce% ...
call :PROCESSREMOVELIST "removelist.txt"
goto :END


:REMOVEPLAYLISTS
echo.
set /p yesremoveplaylists="Are you sure you want to remove all games in the playlists in %target%\cox\playlists\? (Y/N): "
if /i "%yesremoveplaylists%" neq "Y" goto :END
for %%f in (%target%\cox\playlists\*) do (
	echo.
	echo.
	echo Removing games in the "%%~nxf" playlist ...
	call :PROCESSREMOVELIST "%%f"
)
goto :END


:PROCESSADDLIST
for /F "usebackq tokens=*" %%g in ("%~1") do (
	@REM Allows exclamation points to pass
	setlocal disabledelayedexpansion
	call :PROCESSADD "%%g"
)
goto :EOF


:PROCESSREMOVELIST
for /F "usebackq tokens=*" %%g in ("%~1") do (
	call :PROCESSREMOVE "%%g"
)
goto :EOF


:PROCESSADD
echo.
@REM Keep quotes to contain ampersands AKA not using "%~1"
set _uce=%1
@REM Replace exclamations with asterisks
set _uce=%_uce:!=*%
echo Adding "%~1" to %target%\%uce% ...
setlocal enabledelayedexpansion
@REM Replace ampersands with asterisks
set _uce=%_uce:&=*%
set _uce=%_uce:"=%
if exist "%saucepath%\%folder%\%uce%\%_uce%.uce" (
	@REM /d Only overwrites older files and /y skips prompts
	xcopy /q /d /y "%saucepath%\%folder%\%uce%\%_uce%.uce" "%target%\%uce%\"
	xcopy /q /d /y "%saucepath%\%folder%\cox\cover\%_uce%.*" "%target%\cox\cover\"
	xcopy /q /d /y "%saucepath%\%folder%\cox\custom\%_uce%.*" "%target%\cox\custom\"
	xcopy /q /d /y "%saucepath%\%folder%\cox\logo\%_uce%.*" "%target%\cox\logo\"
	xcopy /q /d /y "%saucepath%\%folder%\cox\marquee\%_uce%.*" "%target%\cox\marquee\"
	xcopy /q /d /y "%saucepath%\%folder%\cox\video\%_uce%.*" "%target%\cox\video\"
	echo "%_uce%" successflly added.
) else (
	echo ERROR: Could not find "%saucepath%\%folder%\%uce%\%_uce%.uce"
	echo ERROR: Could not find "%saucepath%\%folder%\%uce%\%_uce%.uce" >> error_%DATENAME%.log
)
goto :EOF


:PROCESSREMOVE
@REM TODO: Add exclamation and ampersand support to this
echo.
echo Removing "%~1" from %target%\%uce% ...
if exist "%target%\%uce%\%~1.uce" (
	del "%target%\%uce%\%~1.uce"
	del "%target%\cox\cover\%~1.*"
	del "%target%\cox\custom\%~1.*"
	del "%target%\cox\logo\%~1.*"
	del "%target%\cox\marquee\%~1.*"
	del "%target%\cox\video\%~1.*"
	echo "%~1" successfully removed.
) else (
	echo ERROR: Could not find "%target%\%uce%\%~1.uce"
	echo ERROR: Could not find "%target%\%uce%\%~1.uce"  >> error_%DATENAME%.log
)
goto :EOF


:END
echo.
echo Please check "error_<date>.log"
set /p again="Would you like to add or remove something else? (Y/N): "
if /i "%again%" equ "Y" goto :PICKFOLDER
ENDLOCAL
