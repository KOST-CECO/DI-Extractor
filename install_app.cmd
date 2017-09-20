@ECHO OFF
SETLOCAL
ECHO.
ECHO "Installieren aller notwendigen Dateien in C:\Tools\xampp\htdocs\app -> http://localhost:90/app"
ECHO.
PAUSE

SET UNIX_HOME=C:\Tools\PCUnixUtils

SET WORKDIR=%CD%
SET HTDOCS=C:\Tools\xampp\htdocs

RMDIR /S /Q %HTDOCS%\app

ROBOCOPY %WORKDIR%\app %HTDOCS%\app /MIR /XF *.xml /XF *.bat /XF *.zip /XF *.ppr

COPY %WORKDIR%\app\null.xml %HTDOCS%\app

%UNIX_HOME%\7z.exe a -mx9 "%HTDOCS%\app\eCH-0160_xIsadg&EAD_xsl.zip" "%WORKDIR%\app\*.xs*" "%WORKDIR%\app\*.bat" "%WORKDIR%\app\xsd_*"


CALL "C:\Program Files\Internet Explorer\iexplore.exe" "http://localhost:90/app/"

EXIT /B

