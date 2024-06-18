@echo off
setlocal EnableDelayedExpansion 
color
if not exist "C:\MSCpref" (
goto :Fts
)
set /p save_drivet=<"C:\MSCpref\Save_drive.txt"
:test
echo Select what you want to do
echo 1: Change Saves + Backup
echo 2: Backup current save
echo 3: Change Saves
echo 4: List of Backed up saves
echo 5: Delete Meshsave
set /p choice=?

if %choice%==1 (
	:redo
	echo.
	echo.
	echo The current backed up saves are:
	echo.
	dir /b "%save_drivet%\MSCSAVES\"
	echo.
	echo Choose the name of the save:
	set /p nsn=?
	mkdir "%save_drivet%\MSCSAVES\!nsn!\"  2>nul || goto :OVERWRITE1
	:3
	xcopy /s /y "C:\Users\%username%\AppData\LocalLow\Amistech\My Summer Car" "%save_drivet%\MSCSAVES\!nsn!" /Q > nul 
	echo Okay! Now choose the name of the old save
	set /p osn=?
	if not exist "%save_drivet%\MSCSAVES\!osn!" goto :FOUT
	del /s /Q > nul "C:\Users\%username%\AppData\LocalLow\Amistech\My Summer Car"
	xcopy /s /y "%save_drivet%\MSCSAVES\!osn!" "C:\Users\%username%\AppData\LocalLow\Amistech\My Summer Car" /Q > nul
	echo Succes!
	pause()
)

if %choice%==2 (
	:redo
	echo.
	echo.
	echo The current backed up saves are:
	echo.
	dir /b "%save_drivet%\MSCSAVES\"
	echo.
	echo Choose the name of the save:
	set /p nsn=?
	mkdir "%save_drivet%\MSCSAVES\!nsn!\"  2>nul || goto :OVERWRITE
	:2
	xcopy /s /y "C:\Users\%username%\AppData\LocalLow\Amistech\My Summer Car" "%save_drivet%\MSCSAVES\!nsn!" /Q > nul 
	echo Okay backed up!
	pause()
)

if %choice%==3 (
	echo.
	echo.
	echo The current backed up saves are:
	echo.
	dir /b "%save_drivet%\MSCSAVES\"
	echo.
	echo Choose the name of the old save
	set /p osn=?
	if not exist "%save_drivet%\MSCSAVES\!osn!" goto :FOUT
	del /s /q > nul "C:\Users\%username%\AppData\LocalLow\Amistech\My Summer Car"
	xcopy /s /y "%save_drivet%\MSCSAVES\!osn!" "C:\Users\%username%\AppData\LocalLow\Amistech\My Summer Car" /Q > nul
	echo Succes!
	pause()
)

if %choice%==4 goto :4

if %choice%==5 (
	del /s /q > nul "C:\Users\%username%\AppData\LocalLow\Amistech\My Summer Car\meshsave.txt" 2>&1 || echo "Meshsave.txt was already removed :/"
	echo ;D
	pause()
)

exit /B

	
:FOUT
color 04
echo An error has occured and the program can't continue
pause()
exit /B

:OVERWRITE
echo This map already exists, do you want to overwrite?
set /p overschrijven=y/n?
if %overschrijven%==y (
goto :2
)
if %overschrijven% == n (
echo Choose another name then
goto :redo
)

:OVERWRITE1
echo This map already exists, do you want to overwrite?
set /p overschrijven=y/n?
if %overschrijven%==y (
goto :3
) else if %overschrijven% == n (
echo Choose another name then
goto :redo
) else goto :FOUT

:4
if %choice%==4 (
	dir /b "%save_drivet%\MSCSAVES\"
	goto :test
)

:Fts
mkdir "C:\MSCpref" || goto :test
Echo It looks like this is your first time using this .bat file
Echo Please select what drive you want your saves saved
set /p save_drive=E.g C: or D: :
echo %save_drive%>"C:\MSCpref\Save_drive.txt"
Echo Done!
Echo Lets see if i've done it correctly
set /p save_drivet=<"C:\MSCpref\Save_drive.txt"
echo %save_drivet%
mkdir "%save_drivet%\MSCSAVES\" || goto :fout
goto :test

