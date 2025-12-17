<?php
if ($wdir=='') { header ("location: ./input.php"); }
?>
		<p> Diese
			<i>Descriptive Information</i> Referenzimplementierung konvertiert eine eCH-0160 Metadaten Datei in eine xIsadg Datei.
			Die importierte Metadaten Datei wird mit einer Schema Validierung überprüft, verschiedene Metadatenschemen werden erkannt, 
			verarbeitet werden nur eCH-0160 Metadaten. Ziel ist die Extraktion der ISAD(G) relevanten Metadaten, die
			<i>Descriptive Information</i> nach OAIS, für den Import in ein
			<i>Datamanagement</i> oder ein Findmittel, jedoch nicht die vollständige Abbildung aller eCH-0160 Metadaten in einem anderen Schema.
		</p>
		<p>
			Grundlage der Konvertierung ist das Papier
			<a href="https://www.ech.ch/sites/default/files/imce/Fachgruppen/DigitaleArchivierung/WhitePaper%20zu%20eCH-0160%20V1.0.zip">Extraktion 
				deskriptiver Metadaten aus der archivischen Ablieferungsschnittstelle eCH-0160</a>.
		</p>
		<p>
			Als Ausgangsformat wird eCH-0160 unterstützt. Zielformat ist xIsadg in Version v1.6.1 oder v3.0.
			<!--Technisch basiert die Konvertierung auf folgenden XSLT Transformationen
			<a href="./eCH-0160_xIsadg.zip">eCH-0160_xIsadg.zip</a> 
			Eine Windows Commandline Batch Datei mit Saxon9 und xmllint ist in dieser ZIP Datei ebenfalls zu finden.
			-->
		</p>
		<p>&nbsp;</p>
		<p>
			<b>Verwendete Standards:</b>
			<ul>
			<li><a href="https://www.ech.ch/de/ech/ech-0160/1.3.0">eCH-0160 v1.3</a></li>
			<li><a href="http://www.ech.ch/de/ech/ech-0257/1.2.0">eCH-0257_v1.2 (Metadatentransformationen zu eCH-0160)</a></li>
			<li><a href="https://kost-ceco.ch/cms/xisadg_de.html">xIsadg</a></li>
			</ul>
		</p>
		<p>
			<b> Crosswalk:</b> <br/>
			<!--a href="./eCH-0160_xIsadg&EAD_v3.0_Bp.xlsx">Crosswalk eCH-0160 -> xIsadg (Entwurf)</a -->
		</p>
