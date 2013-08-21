<form action="processingest.php" method="get">
    <hr>
    <input name="geschaeft" value="<? echo $geschaeft; ?>" type="hidden">
    <input name="target" value="<? echo $target; ?>" type="hidden">
    <table>
        <tr>
            <td colspan="2" rowspan="1">
                <i>Zielakzession (Archivtektonik):</i></td>
        </tr>
        <tr>
            <td style="text-align: right;">
                 Signatur:</td>
            <td>
                <input name="collsig" size="10" type="text" title="Signatur des Knoten in der Archivtektonik an den die Ablieferung eingehängt werden soll"> Titel:
                <input name="colltitle" size="40" type="text" title="Beschreibung des Knotens in der Archivtektonik an den die Ablieferung eingehängt werden soll"></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td colspan="2" rowspan="1">
                <i>Ablieferungsinformationen (Quelle):</i></td>
        </tr>
        <tr>
            <td style="text-align: right;">
                Abliefernde Stelle:</td>
            <td>
                <input name="sipAbl" size="60" title="Der Name der abliefernden Stelle" type="text"></td>
        </tr>
        <tr>
            <td style="text-align: right;">
                Kontraktperson:</td>
            <td>
                <input name="sipKont" size="60" title="Der Name inkl. Vorname des Ansprechpartners innerhalb der abliefernden Stelle"></td>
        </tr>
        <tr>
            <td style="text-align: right;">
                Aktenbildende Stelle:</td>
            <td>
                <input name="sipProv" size="60" title="Bezeichnung der Stelle die die Akten produziert hat. Muss nicht identisch sein mit der abliefernden Stelle"></td>
        </tr>
        <tr>
            <td style="text-align: right;">
                Ablage:</td>
            <td>
                <input name="sipReg" size="60" title="Bezeichnung der Ablage/Registratur in der die abgelieferten Unterlagen geführt wurden"></td>
        </tr>
        <tr>
            <td style="text-align: right;">
                EDV System:</td>
            <td>
                <input name="sipEDV" size="60" title="Bezeichnung des EDV Systems in welchem die Daten geführt wurden"></td>
        </tr>
        <tr>
            <td style="text-align: right;">
                Titel:</td>
            <td>
                <input name="sipTit" size="60" title="Erfassung eines aussagekräftigen Namens oder Titels für die Ablieferung"></td>
        </tr>
        <tr>
            <td style="text-align: right;">
                Zeitraum:</td>
            <td>
                <input name="sipZtr" size="60" title="Eine Zeitraumangabe als beliebiger Text innerhalb dem die Akten entstanden sind. Z.B. 1980-1990 oder Jan. 1990 bis Dez. 2000"></td>
        </tr>
        <tr>
            <td style="text-align: right;">
                Beschreibung:</td>
            <td>
                <input name="sipBeschr" size="60" title="Erlaubt die Erfassung zusätzlicher Hinweise und Kommentare zur Ablieferung">
                <input value="Ablieferung starten" type="submit"></td>
        </tr>
    </table>
</form>
