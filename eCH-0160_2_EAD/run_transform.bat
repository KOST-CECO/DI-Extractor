@ECHO OFF
SETLOCAL

CALL transform.bat "../SIP_20070923_RIS_3Dossier"      "ead_metadata.xml"
CALL transform.bat "../SIP_20070923_RIS_3Dossier_plus" "ead_metadata_plus.xml"
