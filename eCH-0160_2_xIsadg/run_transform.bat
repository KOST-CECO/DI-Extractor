@ECHO OFF
SETLOCAL

SET JAVA_HOME=C:\Software\jre1.5.0
SET UNIX_HOME=C:\Software\PCUnixUtils
SET SAXON=C:\software\saxon9
SET PATH=%UNIX_HOME%;%JAVA_HOME%\bin;%PATH%

SET OUTFILE=xIsadg_metadata.xml

DEL /Q %OUTFILE%

java -cp %SAXON%\saxon9.jar net.sf.saxon.Transform -s:metadata_plus.xml -xsl:eCH2xIsadg.xsl -o:"%OUTFILE%"

ECHO SLEEP 1
SLEEP 1

REM PAUSE
