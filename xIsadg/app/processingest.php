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



// HTML Header ausgeben und damit ein Redirect auslösen
header ("location: ./$wdir/$metadatafile");
?>
