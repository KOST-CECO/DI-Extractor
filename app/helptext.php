<?php
if ($wdir=='') { header ("location: ./input.php"); }
?>
		<p> Diese
			<i>Descriptive Information</i> Referenzimplementierung konvertiert eine eCH-0160 Metadaten Datei in eine xIsadg Datei.
			Die importierte Metadaten Datei wird mit einer Schema Validierung überprüft, verschiedene Metadatenschema werden erkannt; 
			konvertiert werden können aber nur eCH-0160 Metadaten. Ziel ist das Extrahieren der ISAD(G) relevanten Metadaten, die
			<i>Descriptive Information</i> nach OAIS für den Import in ein
			<i>Datamanagement</i> oder ein Findmittel und nicht aber die vollständige Abbildung aller eCH-0160 Metadaten in einem anderen Schema. 
			Grundlage der Konvertierung ist das Papier
			<a href="https://www.ech.ch/sites/default/files/imce/Fachgruppen/DigitaleArchivierung/WhitePaper%20zu%20eCH-0160%20V1.0.zip">Extraktion 
				deskriptiver Metadaten aus der archivischen Ablieferungsschnittstelle eCH-0160</a>.
			Unterstützt werden die Ausgangsformate eCH-0160 1.0, eCH-0160 1.1, eCH-0160 1.2; Zielformat ist xIsadg v1.6.1 und xIsadg v3.0
			Technisch basiert die Konvertierung auf folgenden XSLT Transformationen
			<a href="./eCH-0160_xIsadg.zip">eCH-0160_xIsadg.zip</a> 
			Eine Windows Commandline Batch Datei mit Saxon9 und xmllint ist in dieser ZIP Datei ebenfalls zu finden.
			<br> <br>
			<b> Standards für das Metadatenschema:</b> <br>
			<a href="https://www.ech.ch/de/ech/ech-0160/1.2.0">eCH-0160 v1.2</a>.
			<br>
			<a href="./xIsadg_DataDictionary_v3d0.pdf">xIsadg_DataDictionary_v3.0.pdf</a>
			<br>
			<a href="http://www.ech.ch/de/ech/ech-0257/1.1.0">eCH-0257_v1.1 (Metadatentransformationen zu eCH-0160)</a>
			<br>
			<b> Crosswalk:</b> <br>
			<a href="./eCH-0160_xIsadg&EAD_v3.0_Bp.xlsx">Crosswalk eCH-0160 -> xIsadg (Entwurf)</a>
		</p>
