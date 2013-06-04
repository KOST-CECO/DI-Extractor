@ECHO OFF
SETLOCAL

SET JAVA_HOME=C:\Software\jre6
SET SAXON=C:\Software\saxon9
SET OUTFILE=xIsadg_metadata.xml

IF [%1]==[] (
        ECHO usage: %0 path\SIP...
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
IF EXIST %OUTFILE% (
        DEL /Q %OUTFILE%
)

%JAVA_HOME%\bin\java -cp %SAXON%\saxon9.jar net.sf.saxon.Transform -s:%ECH-0160%\header\metadata.xml -xsl:eCH2xIsadg.xsl -o:"%OUTFILE%"

IF EXIST %OUTFILE% (
        ECHO.
        ECHO SIP %ECH-0160% converted
        ECHO output is %OUTFILE%
        ECHO.
)

