@ECHO OFF 
SETLOCAL

REM SET INPUT=arelda_v4-vollstaendig-FILES.xml
SET INPUT=arelda_v4-vollstaendig-GEVER.xml
REM SET INPUT=arelda_v4.1-vollstaendig-GEVER.xml
REM SET INPUT=arelda_v4-minimal-GEVER.xml


ECHO ===========================================================================
ECHO Signaturstil: fortlaufend SIG.1 SIG.2 / Ausgabeformat: xIsadg 2.1
SET FONDTITLE=Bestand-Titel
SET SIGNATUR=sig
REM Signaturstil (fortlaufend SIG.1 SIG.2 / hierarchisch SIG.1 SIG.1.1): [1] oder [2]
SET STIL=1
REM Ausgabeformat (xIadg / xIsadg 2.1 / EAD ): [1] [2] oder [3]
SET FMT=2
CALL transform.cmd "../sample/%INPUT%"      "xIsadg.2.1_metadata.xml"

IF %ERRORLEVEL% NEQ 0 (
   PAUSE
   EXIT /B
)

REM PAUSE

CALL "C:\Tools\Altova\XMLSpy2005\XMLSpy.exe"                   "%CD%\xIsadg.2.1_metadata.xml"

ECHO ===========================================================================
ECHO Signaturstil: fortlaufend SIG.1 SIG.2 / Ausgabeformat: xIsadg 2.1
SET FONDTITLE=Bestand-Titel
SET SIGNATUR=sig
REM Signaturstil (fortlaufend SIG.1 SIG.2 / hierarchisch SIG.1 SIG.1.1): [1] oder [2]
SET STIL=2
REM Ausgabeformat (xIadg / xIsadg 2.1 / EAD ): [1] [2] oder [3]
SET FMT=3
CALL transform.cmd "../sample/%INPUT%"      "ead_metadata.xml"

IF %ERRORLEVEL% NEQ 0 (
   PAUSE
   EXIT /B
)

REM PAUSE

CALL "C:\Tools\Altova\XMLSpy2005\XMLSpy.exe"                   "%CD%\ead_metadata.xml"

EXIT /B
