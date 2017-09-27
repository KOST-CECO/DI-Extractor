@ECHO OFF 
SETLOCAL


ECHO ===========================================================================
ECHO Signaturstil: fortlaufend SIG.1 SIG.2 / Ausgabeformat: xIadg 2.0
SET FONDTITLE=Bestand-Titel
SET SIGNATUR=sig
REM Signaturstil (fortlaufend SIG.1 SIG.2 / hierarchisch SIG.1 SIG.1.1): [1] oder [2]
SET STIL=1
REM Ausgabeformat (xIadg / xIsadg 2.0 / EAD ): [1] [2] oder [3]
SET FMT=2
CALL transform.bat "../sample/arelda_v4-vollstaendig-metadata.xml"      "xIsadg.2.0_metadata.xml"

if errorlevel 1 (
   PAUSE
   EXIT /B
)

REM PAUSE

CALL "C:\Tools\Altova\XMLSpy2005\XMLSpy2005.exe"                   "%CD%\xIsadg.2.0_metadata.xml"

EXIT /B
