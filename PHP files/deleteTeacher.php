<?php
include 'config.php';
$teacherid = $_GET["teacherid"];

$sql = ("delete from teacher where teacher_id = '".$teacherid."';");

if ($conn->query($sql) == TRUE) {
    echo "deleted successfully";
} else {
    echo "failed\n";
    echo ("Error description: " . $conn -> error);
}
?>
