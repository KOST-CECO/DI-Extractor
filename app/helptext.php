<?php
if ($wdir=='') { header ("location: ./input.php"); }
?>
<p> Diese
    <i>Descriptive Information</i> Referenzimplementierung konvertiert eine eCH-0160 Metadaten Datei in eine xIsadg oder EAD Datei.
    <br> Die importierte Metadaten Datei wird mit einer Schema Validierung &uuml;berpr&uuml;ft, verschiedene Metadatenschema werden erkannt. konvertiert werden k&ouml;nnen aber nur eCH-0160 Metadaten. Ziel ist das Extrahieren der ISAD(G) relevanten Metadaten, die
    <i>Descriptive Information</i> nach OAIS f&uuml;r den Import in ein
    <i>Datamanagement</i> oder ein Findmittel und nicht aber die vollst&auml;ndige Abbildung aller eCH-0160 Metadaten in einem anderen Schema.
    <br> Grundlage der Konvertierung ist das Papier
    <a href="https://www.ech.ch/alfresco/s/ech/download?nodeid=e05d969b-1bff-4593-ad57-d751cc5473aa">Extraktion deskriptiver Metadaten aus der archivischen Ablieferungsschnittstelle eCH-0160</a>
    <br> und der Crosswalk
    <a href="http://kost-ceco.ch/cms/download.php?f1351de7cc3ee1f6eff52a2868325157">eCH-0160_xIsadg&EAD_v2.0.xlsx</a>
    <br> Unterstützt werden eCH-0160 1.0 und eCH-0160 1.1; xIsadg v1.6.1 und xIsadg v2.0 und EAD in der Ausprägung METS Matterhorn Profil
    <br> Technisch basiert die Konvertierung auf folgenden XSLT Transformationen
    <a href="eCH-0160_xIsadg&EAD_xsl.zip">eCH-0160_xIsadg&EAD_xsl.zip</a>
    <br> Eine Windows Commandline Batch Datei mit Saxon9 und xmllint ist in dieser ZIP Datei ebenfalls zu finden.
    <br> Die Basisdokumente f&uuml;r die Metadatenschema sind die folgenden
    <i>Data Dictionaries</i> :
    <br>
    <a href="https://www.ech.ch/alfresco/s/ech/download?nodeid=4bf53ff1-0e4f-4fb9-9ccc-75a4219bb20c">eCH-0160_V1.0_ArchivischeAblieferungsschnittstelle_DataDictionary.pdf</a> und
    <a href="http://kost-ceco.ch/cms/download.php?5cbbc57717f9aa2c8feecaf1a37f4b65=">xIsadg_DataDictionary_v2.0.pdf</a>
    <br>
    <br>
</p>
