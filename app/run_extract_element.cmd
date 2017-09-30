@ECHO OFF

SET TERM=xterm

SET JAVA_HOME=C:\Program Files\Java\jre8
SET JAVA_HOME=C:\Tools\jdk1.8.0_40
SET JAVA="%JAVA_HOME%\bin\java.exe"
SET PERL_HOME=C:\Tools\Perl
SET MYSQL_HOME=C:\Tools\xampp\mysql
SET SVN_HOME=C:\Tools\Subversion
SET GIT_HOME=C:\Tools\Git
SET UNIX_HOME=C:\Tools\PCUnixUtils
SET GNU_BIN=C:\Tools\Git\usr\bin
REM SET CMAKE_HOME=C:\Tools\cmake-3.5.2-win32-x86\bin

set SVN_EDITOR=notepad.exe

SET GOHOME=C:\Tools\Go\bin
SET GOROOT=C:\Tools\Go
SET GOPATH=C:\Tools\Gowork

SET GCC=C:\Tools\MinGW\bin

SET PATH=%GCC%;%GOHOME%;%GOPATH%\bin;%GNU_BIN%;%UNIX_HOME%;%GIT_HOME%\cmd;%JAVA_HOME%\bin;%PERL_HOME%\bin;%MYSQL_HOME%\bin;%SVN_HOME%\bin;%PATH%

REM --------------------------------------------------------------

CALL extract_element.cmd ..\sample\arelda_v4-vollstaendig-GEVER.xml  >ee1.txt

CALL extract_element.cmd xIsadg.2.0_metadata.xml >ee2.txt

C:\Tools\Git\cmd\tkdiff.exe ee1.txt ee2.txt

DEL ee1.txt ee2.txt

EXIT /B  

