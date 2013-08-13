@ECHO OFF
SETLOCAL

SET JAVA_HOME=C:\Software\jre6
SET SAXON=C:\Software\saxon9
SET LINT=C:\Software\PCUnixUtils

IF [%1]==[] (
        ECHO usage: %0  path\SIP...  OUTPUT
        EXIT /B
)

IF [%2]==[] (
        ECHO usage: %0  path\SIP...  OUTPUT
        EXIT /B
)

IF NOT EXIST %1 (
        ECHO SIP path %1 not found
        ECHO usage: %0 path\SIP...
        EXIT /B
)

IF NOT EXIST %1\header\metadata.xml (
        ECHO %1\header\metadata.xml not found
        ECHO usage: %0 path\SIP...
        EXIT /B
)

SET ECH-0160=%1
SET OUTPUT=%2
IF EXIST %OUTPUT% (
        DEL /Q %OUTPUT%
)

REM User input -----------------------------------------------------------------
ECHO.
ECHO Benutzereingabe
ECHO ===============
SET /P FONDTITLE=Bestand Titel: 
ECHO.

%JAVA_HOME%\bin\java -jar %SAXON%\saxon9.jar -s:%ECH-0160%\header\metadata.xml -xsl:eCH2xIsadg.xsl -o:"%OUTPUT%" fondtitle=%FONDTITLE%

%LINT%\xmllint.exe -sax -noout -schema xIsadg_v1.6.1.xsd "%OUTPUT%"
ECHO.

IF %ERRORLEVEL%==0 (
        ECHO SIP %ECH-0160% converted
        ECHO output is %OUTPUT%
        ECHO.
)

