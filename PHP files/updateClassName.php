<?php
include 'config.php';
$classid = $_GET["classid"];
$newName = $_GET["newName"];

$sql = ("update classroom set name = '".$newName."' where classroom_id = ".$classid.";");

if ($conn->query($sql) == TRUE) {
    echo "deleted successfully";
} else {
    echo "failed\n";
    echo ("Error description: " . $conn -> error);
}
?>
