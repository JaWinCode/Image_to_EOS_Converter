@echo off

setlocal

set "source=https://github.com/JaWinCode/Image_to_EOS_Converter/archive/master.zip"
set "temp_folder=%TEMP%\GitHub"
set "appdata_folder=%APPDATA%\Image_To_EOS_Converter"
set "shortcut_name=Image_to_EOS_Converter.lnk"
set "shortcut_target=%APPDATA%\Image_To_EOS_Converter\Image_to_EOS_Converter_V1.exe"
set "shortcut_dir=%USERPROFILE%\Desktop"

echo Herunterladen der Dateien ...
if not exist "%temp_folder%" mkdir "%temp_folder%"
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%source%', '%temp_folder%\master.zip')"

echo Entpacken des Archivs ...
powershell -Command "Expand-Archive '%temp_folder%\master.zip' -DestinationPath '%temp_folder%'"

echo Kopieren der Dateien in das Appdata-Verzeichnis ...
if not exist "%appdata_folder%" mkdir "%appdata_folder%"
robocopy "%temp_folder%\Image_to_EOS_Converter-master" "%appdata_folder%" /E

echo Erstellen der Verknuepfung auf dem Desktop ...
powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%shortcut_dir%\%shortcut_name%'); $Shortcut.TargetPath = '%shortcut_target%'; $Shortcut.Save()"

echo Bereinigen der temporaeren Dateien ...
rmdir /s /q "%temp_folder%"

echo Fertig!

pause
