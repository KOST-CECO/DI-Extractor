@ECHO OFF
SETLOCAL

SET JAVA_HOME=..\jre6
SET SAXON=..\saxon9

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
SET OUTPUT=xIsadg_metadata.xml
DEL /Q %OUTPUT%

%JAVA_HOME%\bin\java -cp %SAXON%\saxon9.jar net.sf.saxon.Transform -s:%ECH-0160%\header\metadata.xml -xsl:eCH2xIsadg.xsl -o:"%OUTPUT%"


