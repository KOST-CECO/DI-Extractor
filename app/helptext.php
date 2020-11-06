<?php
if ($wdir=='') { header ("location: ./input.php"); }
?>
		<p> Diese
			<i>Descriptive Information</i> Referenzimplementierung konvertiert eine eCH-0160 Metadaten Datei in eine xIsadg oder EAD Datei.
			Die importierte Metadaten Datei wird mit einer Schema Validierung überprüft, verschiedene Metadatenschema werden erkannt; 
			konvertiert werden können aber nur eCH-0160 Metadaten. Ziel ist das Extrahieren der ISAD(G) relevanten Metadaten, die
			<i>Descriptive Information</i> nach OAIS für den Import in ein
			<i>Datamanagement</i> oder ein Findmittel und nicht aber die vollständige Abbildung aller eCH-0160 Metadaten in einem anderen Schema. Grundlage der Konvertierung ist das Papier
			<a href="https://test.ech.ch/alfresco/s/ech/download?nodeid=e05d969b-1bff-4593-ad57-d751cc5473aa">Extraktion deskriptiver Metadaten aus der archivischen Ablieferungsschnittstelle eCH-0160</a> und der Crosswalk
			<a href="https://kost-ceco.ch/cms/dl/91141f46022f5f2dd1f8fa9409d2dcab/eCH-0160_xIsadg%26EAD_v2.1.xlsx">eCH-0160_xIsadg&amp;EAD_v2.1.xlsx</a>. Unterstützt werden die Ausgangsformate eCH-0160 1.0 und eCH-0160 1.1; Zielformat ist xIsadg v1.6.1 und xIsadg v2.1, EAD in der Ausprägung METS Matterhorn Profil und RIC-O Version 0.1
			<br> Technisch basiert die Konvertierung auf folgenden XSLT Transformationen
			<a href="./eCH-0160_xIsadg&amp;EAD&amp;RIC.xsl.zip">eCH-0160_xIsadg&amp;EAD&amp;RIC.xsl.zip</a>
			<br> Eine Windows Commandline Batch Datei mit Saxon9 und xmllint ist in dieser ZIP Datei ebenfalls zu finden.
			<br> Die Basisdokumente für die Metadatenschema sind die folgenden
			<i>Data Dictionaries</i> :
			<br>
			<a href="http://ech.ch/de/dokument/4bf53ff1-0e4f-4fb9-9ccc-75a4219bb20c">eCH-0160_V1.1_ArchivischeAblieferungsschnittstelle_DataDictionary.pdf</a> und
			<a href="https://kost-ceco.ch/cms/dl/b890ad3a2222023b4247d17779062619/xIsadg_DataDictionary_v2.1.pdf">xIsadg_DataDictionary_v2.1.pdf</a>
			<br>
			Nach einer Konvertierung in RIC Format steht der RDF Content unter der unten angegebenen 
			URI für eine SPARQL Auswertung mit einem Online Tool zur Verfügung (z.B. <a href="http://librdf.org/query/">Redland Rasqal RDF Query</a>)
			<br>
		</p>
