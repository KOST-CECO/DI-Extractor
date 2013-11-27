<?
if ($wdir=='') { header ("location: ./input.php"); }
?>
<p> Diese
	<i>Descriptive Information</i> Referenzimplementierung konvertiert eine eCH-0160 Metadaten Datei in eine xIsadg oder EAD Datei.
	<br> Die importierte Metadaten Datei wird mit einer Schema Validierung &uuml;berpr&uuml;ft, verschiedene Metadatenschema werden erkannt. konvertiert werden k&ouml;nnen aber nur eCH-0160 Metadaten. Ziel ist das Extrahieren der ISAD(G) relevanten Metadaten, die
	<i>Descriptive Information</i> nach OAIS f&uuml;r den Import in ein
	<i>Datamanagement</i> oder ein Findmittel und nicht aber die vollst&auml;ndige Abbildung aller eCH-0160 Metadaten in einem anderen Schema.
	<br> Grundlage der Konvertierung ist das
	<a href="eCH-0160_DI_WhitePaper.pdf">eCH-0160_DI_WhitePaper.pdf</a> und der Crosswalk
	<a href="eCH-0160_xIsadg&EAD.xlsx">eCH-0160_xIsadg&EAD.xlsx</a>
	<br> Technisch basiert die Konvertierung auf folgenden XSLT Transformation
	<a href="eCH-0160_xIsadg&EAD_xsl.zip">eCH-0160_xIsadg&EAD_xsl.zip</a>
	<br> Eine Windows Commandline Version mit Saxon9 und xmllint ist in diesem ZIP file ebenfalls zu finden.
	<br> Die Basisdokumente f&uuml;r die beiden Metadatenschema sind die folgenden
	<i>Data Dictionaries</i> :
	<br>
	<a href="http://www.ech.ch/alfresco/guestDownload/attach/workspace/SpacesStore/49573954-e271-4cd0-8d08-4841373072eb/STAN_d_DEF_2012-11-29_eCH-0160_V1.0_ArchivischeAblieferungsschnittstelle_DataDictionary.pdf">eCH-0160_V1.0_ArchivischeAblieferungsschnittstelle_DataDictionary.pdf</a> und
	<a href="http://kost-ceco.ch/cms/download.php?21fdbf679a754b85345c28ff4930f333=">xIsadg_DataDictionary_v1.6.pdf</a>
	<br>
	<br>
</p>
