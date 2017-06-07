@ECHO OFF
SETLOCAL

CALL transform.bat "../sample/SIP_20070923_arelda_v4"      "xIsadg_metadata.xml"
CALL "C:\Tools\Altova\XMLSpy2005\XMLSpy2005.exe"           "%CD%\xIsadg_metadata.xml"

EXIT /B
