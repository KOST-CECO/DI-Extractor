@ECHO OFF
SETLOCAL
ECHO.
ECHO "Installieren aller notwendigen Dateien in C:\Tools\xampp\htdocs\app -> http://localhost/app"
ECHO.
PAUSE

SET UNIX_HOME=C:\Tools\PCUnixUtils

SET WORKDIR=%CD%
SET HTDOCS=C:\Tools\xampp\htdocs

RMDIR /S /Q %HTDOCS%\app

ROBOCOPY %WORKDIR%\app %HTDOCS%\app /MIR /XF *.xml /XF *.bat /XF *.zip /XF *.ppr

COPY %WORKDIR%\app\null.xml %HTDOCS%\app
COPY "P:\KOST\Standards\xIsadg\_Workbench\DataDictionary\eCH-0160_xIsadg&EAD_v2.1.xlsx" %HTDOCS%\app
COPY "P:\KOST\Standards\xIsadg\_Workbench\DataDictionary\xIsadg_DataDictionary_v2.1.pdf" %HTDOCS%\app

%UNIX_HOME%\7z.exe a -mx9 "%HTDOCS%\app\eCH-0160_xIsadg&EAD_xsl.zip" "%WORKDIR%\app\*.xs*" "%WORKDIR%\app\*.bat" "%WORKDIR%\app\xsd_*"

PAUSE
CALL "C:\Program Files\Internet Explorer\iexplore.exe" "http://localhost/app/"

EXIT /B

