<?php
include 'config.php';
$reportid = $_GET["reportid"];

$sql = ("delete from dailyReport where report_id = '".$reportid."';");

if ($conn->query($sql) == TRUE) {
    echo "deleted successfully";
} else {
    echo "failed\n";
    echo ("Error description: " . $conn -> error);
}
?>
