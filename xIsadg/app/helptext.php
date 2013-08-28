<?
if ($wdir=='') { header ("location: ./input.php"); }
?>
<p>
Diese Referenzimplementierung konvertiert eine eCH-0160 Metadaten Datei in eine xIsadg oder EAD Datei.<br>
Die importierte Metadaten Datei wird mit einer Schema Validierung überprüft, verschiedene Metadatenschema werden erkannt.<br>
Ziel ist das Extrahieren der ISAD(G) relevanten Metadaten, die <i>Descriptive Information</i>, für den Import in<br>
ein <i>Datamanagement</i> oder ein Findmittel und nicht aber die vollständige Abbildung aller eCH-0160 Metadaten in einem anderen Schema.<br>
Grundlage der Konvertierung ist der folgender Crosswalk <a href="eCH-0160 zu xIsadg_v3.xlsx">eCH-0160 zu xIsadg_v3.xlsx</a><br>
Technisch basiert die Konvertierung auf folgender XSLT Transformation <a href="eCH2xIsadg.zip">eCH2xIsadg.zip</a><br>
Eine Windows Commandline Version benötigt Saxon9 und xmllint und ist hier zu finden <a href="eCH2xIsadg_cmd.zip">eCH2xIsadg_cmd.zip</a><br>
Die Basisdokumente für die beiden Metadatenschema sind die folgenden <i>Data Dictionaries</i>:<br>
<a href"http://www.ech.ch/alfresco/guestDownload/attach/workspace/SpacesStore/49573954-e271-4cd0-8d08-4841373072eb/STAN_d_DEF_2012-11-29_eCH-0160_V1.0_ArchivischeAblieferungsschnittstelle_DataDictionary.pdf">eCH-0160_V1.0_ArchivischeAblieferungsschnittstelle_DataDictionary.pdf</a>
und
<a href"http://kost-ceco.ch/cms/download.php?21fdbf679a754b85345c28ff4930f333">xIsadg_DataDictionary_v1.6.pdf</a>
</p>
