<?php
include 'config.php';
$classid = $_GET["classid"];

$sql = ("delete from classroom where classroom_id = '".$classid."';");

if ($conn->query($sql) == TRUE) {
    echo "deleted successfully";
} else {
    echo "failed\n";
    echo ("Error description: " . $conn -> error);
}
?>
