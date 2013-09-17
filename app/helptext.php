<?
if ($wdir=='') { header ("location: ./input.php"); }
?>
<p>
  Diese
  <i>Descriptive Information</i> Referenzimplementierung konvertiert eine eCH-0160 Metadaten Datei in
  eine xIsadg oder EAD Datei.
  <br> Die importierte Metadaten Datei wird mit einer Schema Validierung &uuml;berpr&uuml;ft, verschiedene Metadatenschema werden erkannt. konvertiert werden k&ouml;nnen aber nur eCH-0160 Metadaten. Ziel ist das Extrahieren der ISAD(G) relevanten Metadaten, die
  <i>Descriptive Information</i> nach
  OAIS f&uuml;r den Import in ein
  <i>Datamanagement</i> oder ein Findmittel und nicht aber die vollst&auml;ndige Abbildung aller eCH-0160 Metadaten in
  einem anderen Schema.
  <br>Grundlage der Konvertierung ist der folgender Crosswalk
  <a href="eCH-0160%20zu%20xIsadg_v3.xlsx">eCH-0160 zu xIsadg_v3.xlsx</a>
  und
  <a href="eCH-0160%20zu%20EAD_v1.xlsx">CH-0160 zu EAD_v1.xlsx</a>
  <br>Technisch basiert die Konvertierung auf folgenden XSLT Transformation
  <a href="eCH2xIsadg.zip">eCH2xIsadg.zip</a>
  und
  <a href="eCH2EAD.zip">eCH2EAD.zip</a>
  <br> Eine Windows Commandline Version ben&ouml;tigt Saxon9 und xmllint und ist hier zu finden
  <a href="eCH2ISADG_cmd.zip">eCH2ISADG_cmd.zip</a>
  <br>Die Basisdokumente f&uuml;r die beiden Metadatenschema sind die folgenden
  <i> Data Dictionaries</i>:
  <br>
  <a href="" http:="" www.ech.ch="" alfresco="" guestdownload="" attach="" workspace="" spacesstore="" 49573954-e271-4cd0-8d08-4841373072eb="" stan_d_def_2012-11-29_ech-0160_v1.0_archivischeablieferungsschnittstelle_datadictionary.pdf="">eCH-0160_V1.0_ArchivischeAblieferungsschnittstelle_DataDictionary.pdf</a>
  und
  <a href="" http:="" kost-ceco.ch="" cms="" download.php?21fdbf679a754b85345c28ff4930f333="">xIsadg_DataDictionary_v1.6.pdf</a>
  <br>
  <br>
</p>
