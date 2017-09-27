@ECHO OFF 
SETLOCAL

ECHO ===========================================================================
ECHO Signaturstil: fortlaufend SIG.1 SIG.2 / Ausgabeformat: xIsadg
SET FONDTITLE=xIsadg-Bestand-Titel
SET SIGNATUR=sig
REM Signaturstil (fortlaufend SIG.1 SIG.2 / hierarchisch SIG.1 SIG.1.1): [1] oder [2]
SET STIL=1
REM Ausgabeformat (xIsadg / xIsadg 2.0 / EAD ): [1] [2] oder [3]
SET FMT=1
CALL transform.bat "../sample/SIP_20070923_arelda_v4"      "xIsadg_metadata.xml"
CALL "C:\Tools\Altova\XMLSpy2005\XMLSpy2005.exe"           "%CD%\xIsadg_metadata.xml"

ECHO ===========================================================================
ECHO Signaturstil: hierarchisch SIG.1 SIG.1.1 / Ausgabeformat: xIsadg
SET FONDTITLE=xIsadg-Bestand-Titel
SET SIGNATUR=sig
REM Signaturstil (fortlaufend SIG.1 SIG.2 / hierarchisch SIG.1 SIG.1.1): [1] oder [2]
SET STIL=2
REM Ausgabeformat (xIsadg / xIsadg 2.0 / EAD ): [1] [2] oder [3]
SET FMT=1
CALL transform.bat "../sample/SIP_20070923_arelda_v4"      "xIsadg_metadata.xml"
CALL "C:\Tools\Altova\XMLSpy2005\XMLSpy2005.exe"           "%CD%\xIsadg_metadata.xml"


ECHO ===========================================================================
ECHO Signaturstil: fortlaufend SIG.1 SIG.2 / Ausgabeformat: xIsadg 2.0
SET FONDTITLE=EAD-Bestand-Titel
SET SIGNATUR=sig
REM Signaturstil (fortlaufend SIG.1 SIG.2 / hierarchisch SIG.1 SIG.1.1): [1] oder [2]
SET STIL=1
REM Ausgabeformat (xIsadg / xIsadg 2.0 / EAD ): [1] [2] oder [3]
SET FMT=2
CALL transform.bat "../sample/SIP_20070923_arelda_v4"      "EAD_metadata.xml"
CALL "C:\Tools\Altova\XMLSpy2005\XMLSpy2005.exe"           "%CD%\EAD_metadata.xml"

ECHO ===========================================================================
ECHO Signaturstil: hierarchisch SIG.1 SIG.1.1 / Ausgabeformat: xIsadg 2.0
SET FONDTITLE=EAD-Bestand-Titel
SET SIGNATUR=sig
REM Signaturstil (fortlaufend SIG.1 SIG.2 / hierarchisch SIG.1 SIG.1.1): [1] oder [2]
SET STIL=2
REM Ausgabeformat (xIsadg / xIsadg 2.0 / EAD ): [1] [2] oder [3]
SET FMT=2
CALL transform.bat "../sample/SIP_20070923_arelda_v4"      "EAD_metadata.xml"
CALL "C:\Tools\Altova\XMLSpy2005\XMLSpy2005.exe"           "%CD%\EAD_metadata.xml"


ECHO ===========================================================================
ECHO Signaturstil: fortlaufend SIG.1 SIG.2 / Ausgabeformat: EAD
SET FONDTITLE=EAD-Bestand-Titel
SET SIGNATUR=sig
REM Signaturstil (fortlaufend SIG.1 SIG.2 / hierarchisch SIG.1 SIG.1.1): [1] oder [2]
SET STIL=1
REM Ausgabeformat (xIsadg / xIsadg 2.0 / EAD ): [1] [2] oder [3]
SET FMT=3
CALL transform.bat "../sample/SIP_20070923_arelda_v4"      "EAD_metadata.xml"
CALL "C:\Tools\Altova\XMLSpy2005\XMLSpy2005.exe"           "%CD%\EAD_metadata.xml"

ECHO ===========================================================================
ECHO Signaturstil: hierarchisch SIG.1 SIG.1.1 / Ausgabeformat: EAD
SET FONDTITLE=EAD-Bestand-Titel
SET SIGNATUR=sig
REM Signaturstil (fortlaufend SIG.1 SIG.2 / hierarchisch SIG.1 SIG.1.1): [1] oder [2]
SET STIL=2
REM Ausgabeformat (xIsadg / xIsadg 2.0 / EAD ): [1] [2] oder [3]
SET FMT=3
CALL transform.bat "../sample/SIP_20070923_arelda_v4"      "EAD_metadata.xml"
CALL "C:\Tools\Altova\XMLSpy2005\XMLSpy2005.exe"           "%CD%\EAD_metadata.xml"

EXIT /B
