@ECHO OFF
SETLOCAL

SET JAVA_HOME=C:\Software\jre1.5.0
SET SAXON=C:\software\saxon9
SET PATH=%JAVA_HOME%\bin;%PATH%

DEL "XSL Output.xml"

java -cp %SAXON%\saxon9.jar net.sf.saxon.Transform -s:metadata_plus.xml -xsl:eCH2xIsadg.xsl -o:"XSL Output.xml"

REM PAUSE
