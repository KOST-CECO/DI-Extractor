@ECHO OFF
SETLOCAL

SET ZDIR="C:\Program Files\7-Zip"
SET WORKDIR="C:\workbench\_Workbench"
SET HTDOCS=%WORKDIR%\htdocs

ECHO.
ECHO Installieren aller notwendigen Dateien in %HTDOCS%\app
ECHO.
PAUSE

CD %WORKDIR%
RMDIR /S /Q %HTDOCS%\app
RMDIR /S /Q %HTDOCS%
MKDIR %HTDOCS%

ROBOCOPY %WORKDIR%\app %HTDOCS%\app /MIR /XF *.xml /XF *.bat /XF *.zip /XF *.ppr

COPY %WORKDIR%\app\null.xml %HTDOCS%\app
COPY "P:\KOST\Standards\xIsadg\_Workbench\DataDictionary\eCH-0160_xIsadg&EAD_v2.1.xlsx" %HTDOCS%\app
COPY "P:\KOST\Standards\xIsadg\_Workbench\DataDictionary\xIsadg_DataDictionary_v2.1.pdf" %HTDOCS%\app

%ZDIR%\7z.exe a -mx9 "%HTDOCS%\app\eCH-0160_xIsadg&EAD&RIC.xsl.zip" "%WORKDIR%\app\*.xs*" "%WORKDIR%\app\*.bat" "%WORKDIR%\app\xsd_*"

EXIT /B

