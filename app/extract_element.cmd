@ECHO OFF
SETLOCAL

REM create DB ------------------------------------------------------------------
IF [%1]==[] (
	ECHO metadata.xml filename is missing
	ECHO usage: %0 metadata.xml [on=weiter Metadaten]
	EXIT /B
)
IF NOT EXIST %1 (
	ECHO metadata.xml filename is missing
	EXIT /B
)
SET METADATA=%1

ECHO Element Metadaten ---------------------------------------------------------
sed "s/</@</g" %METADATA% | sed "s/>/>@/g" | sed "s/#/@#/g"| tr @ \n | tr \042 \n | grep # | sort
ECHO.

ECHO Datum Metadaten -----------------------------------------------------------
REM sed "s/<datum/@<datum/g" %METADATA% | tr @ \n | grep "<datum>" | sed "s/<[/]*datum>//g" | sort -t "-" +2
sed "s/fromDate/datum/g" %METADATA% | sed "s/toDate/datum/g" | sed "s/pointofTime/datum/g" | sed "s/<datum/@<datum/g" | tr @ \n | grep "<datum>" | sed "s/<[/]*datum>//g" | sort -t "-" +2
ECHO.

ECHO 1967-02-01 = ablieferung entstehungszeitraum von
ECHO 1967-04-02 = ablieferung entstehungszeitraum bis
ECHO 1967-01-03 = provenienz existenzzeitraum von
ECHO 1967-12-04 = provenienz existenzzeitraum bis
ECHO 1967-02-05 = ordnungssystem anwendungszeitraum von
ECHO 1967-04-06 = ordnungssystem anwendungszeitraum bis
ECHO 1967-02-07 = dossier entstehungszeitraum von
ECHO 1967-03-08 = dossier entstehungszeitraum bis
ECHO 1967-01-09 = dossier eroeffnungsdatum
ECHO 1967-01-10 = dossier abschlussdatum
ECHO 1967-01-11 = dokument registrierdatum
ECHO 1967-02-12 = dokument entstehungszeitraum von
ECHO 1967-02-13 = dokument entstehungszeitraum bis
ECHO.

IF NOT [%2]==[] (
	ECHO weitere Metadaten ---------------------------------------------------------
	sed "s/</@</g" %METADATA% | sed "s/>/>@/g" | sed "s/#/@#/g"| tr @ \n | tr \042 \n | grep -v # | grep -v "<" | grep -v ">" | grep -v -e "^[[:space:]]*$" | grep -v 1967 | grep -v =
)

EXIT /B
