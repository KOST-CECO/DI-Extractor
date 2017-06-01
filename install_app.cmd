@ECHO OFF
SETLOCAL
ECHO.
ECHO "Installieren aller notwendigen Dateien in C:\Tools\xampp\htdocs\app -> http://localhost:90/app"
ECHO.
PAUSE

RMDIR /S /Q C:\Tools\xampp\htdocs\app

ROBOCOPY C:\Tools\workbench\_DI-Extractor\app C:\Tools\xampp\htdocs\app /MIR

CALL "C:\Program Files\Internet Explorer\iexplore.exe" "http://localhost:90/app/"

EXIT /B
