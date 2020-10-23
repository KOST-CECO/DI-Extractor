<?php
if ($wdir=='') { header ("location: ./input.php"); }
?>
<hr>
<i> Folgende Datei steht zur Konvertierung bereit:
    <b>
        <?=$metadatafile?></b></i>
<br>
<br>
<!-- Formular für manuellen Dateninput, dreispaltig -->
<form action="processingest.php" method="post">
    <input name="metadatafile" value="<?php echo $metadatafile; ?>" type="hidden">
    <input name="wdir" value=<?=$wdir?> type="hidden">
    <table style="width: 100%;">
        <tr>
            <td colspan="3" rowspan="1">
                <i>Manuelle Angaben zur Zielakzession (Archivtektonik):</i></td>
        </tr>
        <tr>
            <td style="text-align: right;">
                Bestand-Signatur:</td>
            <td colspan="2" rowspan="1">
                <input class="form-control" name="collsig" size="16" type="text" title="Signatur (Archiv- & Bestandk&uuml;rzel) des Knoten in der Archivtektonik an den die Ablieferung eingeh&auml;ngt werden soll"> 
                &nbsp;&nbsp;Bestandtitel:
                <input class="form-control" name="colltitle" size="54" type="text" title="Beschreibung des Knotens in der Archivtektonik an den die Ablieferung eingeh&auml;ngt werden soll"></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td colspan="3" rowspan="1">
                <i>Angaben zur Signaturbildung:</i></td>
        </tr>
        <tr>
            <td style="text-align: right;">
                Signaturstil:</td>
            <td colspan="2" rowspan="1">
                <input type="radio" name="collstyle" value="fortlaufend" title="Fortlaufend nummeriert in der Art SIG.1 SIG.2 SIG.3" checked> fortlaufende Nummerierung
                <input type="radio" name="collstyle" value="dezimal" title="Hierarchische Dezimalgliederung in der Art SIG.1 SIG.1.1 SIG.1.2 SIG.1.3">
                dezimal Gliederung</td>
        </tr>
        <tr>
            <td style="text-align: right;">
                Ausgabeformat:</td>
            <td>
                <input type="radio" name="xschema" value="xIsadg" title="Ausgabe als xIsadg Metadaten Datei" onClick="ricOff();" checked> xIsadg 1.6.1
                <input type="radio" name="xschema" value="xI2sadg" title="Ausgabe als xIsadg Metadaten Datei Version 2.1" onClick="ricOff();"> xIsadg 2.1
                <input type="radio" name="xschema" value="EAD" title="Ausgabe als EAD Metadaten Datei (METS Matterhorn Style)" onClick="ricOff();"> EAD
                <input type="radio" name="xschema" value="RIC" title="Ausgabe als RIC Metadaten Datei Version 0.1" onClick="ricOn();"> RIC 0.1(beta)
            </td>
            <td>
                <div style="text-align: right;">
                    <input class="btn" value="Konvertieren" type="submit" style="font-size:100%">
                </div></td>
        </tr>
    </table>
    <!-- Zusatzangaben zur Konvertierung in RIC -->
    <div id="addonRIC">
      <hr>
      <table style="width: 100%;">
        <tbody>
          <tr>
            <td colspan="2">
              <i>Zusatzangaben zur Konvertierung in RIC:</i>
            </td>
          </tr>
          <tr>
            <td style="text-align: right;">
              Paketname:
            </td>
            <td>
              <input class="form-control" name="packagename" size="16" type="text" value="SIP..." title="(Datei-)Name des Ablieferungspaketes, z.B. SIP_20120628_BfB_Bm.zip"> 
              &nbsp;&nbsp;Base URI:
              <input class="form-control" name="baseuri" size="54" type="text" value="http://arelda_v4.0.ch/" title="Basis URI der Resourcen in RIC (default: http://arelda_v4.0.ch/)">
            </td>
          </tr>
          <tr>
            <td colspan="2"></td>
          </tr>
            <td colspan="2">
              Aktenbildner/Provenienz (GND o.ä.)
              <input class="form-control" name="creator" size="20" type="text" title="URI von Aktenbildner/Provenienz, wird keine Normdatei referenziert wird lokal im SIP eine URI gebildet">
              &nbsp;&nbsp;Abliefernde Stelle (GND o.ä.)
              <input class="form-control" name="submissionbody" size="20" type="text" title="URI der abliefernde Stelle, wird keine Normdatei referenziert wird lokal im SIP eine URI gebildet">
            </td>
          </tr>
          <tr>
            <td style="text-align: right;">
              Sprache:
            </td>
            <td>
              <input type="radio" name="language" value="de" title="Primäre Sprache der Metadaten" checked=""> deutsch
              <input type="radio" name="language" value="fr" title="Primäre Sprache der Metadaten"> Sprache französisch
              <input type="radio" name="language" value="it" title="Primäre Sprache der Metadaten"> italienisch
              <input type="radio" name="language" value="en" title="Primäre Sprache der Metadaten"> englisch
            </td>
          </tr>
        </tbody>
      </table>
    </div>
</form>
