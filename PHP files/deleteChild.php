<?php
include 'config.php';
$childid = $_GET["childid"];

$sql = ("delete from child where child_id = '".$childid."';");

if ($conn->query($sql) == TRUE) {
    echo "deleted successfully";
} else {
    echo "failed\n";
    echo ("Error description: " . $conn -> error);
}
?>


