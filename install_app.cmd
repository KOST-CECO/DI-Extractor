@ECHO OFF
SETLOCAL
ECHO.
ECHO "Installieren aller notwendigen Dateien in C:\Tools\xampp\htdocs\app -> http://localhost:90/app"
ECHO.
PAUSE

SET WORKDIR=%CD%
SET HTDOCS=C:\Tools\xampp\htdocs

RMDIR /S /Q %HTDOCS%\app

ROBOCOPY %WORKDIR%\app %HTDOCS%\app /MIR

CALL "C:\Program Files\Internet Explorer\iexplore.exe" "http://localhost:90/app/"

EXIT /B
