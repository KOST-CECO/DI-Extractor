<?
// Ingest Informationen verarbeiten
if ($_GET['wdir']=='') { die; } else {$wdir = $_GET['wdir']; }
if ($_GET['metadatafile']=='') { die; } else {$metadatafile = $_GET['metadatafile']; }

// include class file for "PHP Input Filter"
require_once("class.inputfilter.php");
$myFilter = new InputFilter();
$collsig   = utf8_encode( $myFilter->process( stripslashes($_GET['collsig'] ) ) );
$colltitle = utf8_encode( $myFilter->process( stripslashes($_GET['colltitle']) ) );
$collstyle = utf8_encode( $myFilter->process( stripslashes($_GET['collstyle']) ) );

// Referenzdatei für die Signaturnummerierung
$reffile = "./$wdir/$wdir.xml";

// Disable libxml errors
libxml_use_internal_errors(true);

if ($collstyle == 'fortlaufend') {
    // Signatur generieren: Liste aller Objektreferenzen erzeugen
    // Load the XML source
    $xml = new DOMDocument;
    $xml->load("./$wdir/$metadatafile");
    // Load the XSLT source
    $xsl = new DOMDocument;
    $xsl->load('xIcreateRef.xsl');
    // Configure the transformer
    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl); // attach the xsl rules
    // Set parameter
    $proc->setParameter('', 'archsig', $collsig);
    // Transform according to the xsl rules
    $reflist = $proc->transformToXML($xml);
    
    // Signatur generieren: Liste aller Objektreferenzen fortlaufend nummerieren
    // Load the XML source
    $xml_ref = new DOMDocument;
    $xml_ref->loadXML($reflist);
    // Load the XSLT source
    $xsl = new DOMDocument;
    $xsl->load('xInumberRef.xsl');
    // Configure the transformer
    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl); // attach the xsl rules
    // Transform according to the xsl rules
    $numlist = $proc->transformToXML($xml_ref);
    file_put_contents("$reffile", $numlist);
}
else {
    // Load the XML source
    $xml = new DOMDocument;
    $xml->load("./$wdir/$metadatafile");
    $reffile = 'null.xml';
}

// Load the XSLT source
$xsl = new DOMDocument;
$xsl->load('eCH2xIsadg.xsl');
// Configure the transformer
$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl); // attach the xsl rules
// Set parameter
$proc->setParameter('', 'fondtitle', $colltitle);
$proc->setParameter('', 'archsig', $collsig);
$proc->setParameter('', 'reffilename', "$reffile");
// Transform according to the xsl rules
$xisadg = $proc->transformToXML($xml);

// alle Dateien im Arbeitsverzeichnis "$wdir" löschen
if ($handle = opendir($wdir)) {
    while (false !== ($file = readdir($handle))) {
        if ($file != "." && $file != ".." && $file != ".svn") {
            unlink("$wdir/$file");
        }
    }
closedir($handle);
}

// We'll be outputting a XML
header('Content-type: application/xml');
echo $xisadg;

// HTML Header ausgeben und damit ein Redirect auslösen
//file_put_contents("./$wdir/out.xml", $xisadg);
//header ("location: ./$wdir/out.xml");
?>
