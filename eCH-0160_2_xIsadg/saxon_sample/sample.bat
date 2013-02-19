@ECHO OFF
SETLOCAL

SET JAVA_HOME=N:\KOST\Software\jre1.5.0
SET SAXON=C:\software\saxon9
SET PATH=%JAVA_HOME%\bin;%PATH%

DEL saxon_test.html

java -cp %SAXON%\saxon9.jar net.sf.saxon.Transform -s:saxon_test.xml -xsl:saxon_test.xsl -o:saxon_test.html

PAUSE
