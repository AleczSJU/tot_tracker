<?php
include 'config.php';
$planid = $_GET["planid"];

$sql = ("delete from lessonPlan where lessonplan_id = '".$planid."';");

if ($conn->query($sql) == TRUE) {
    echo "deleted successfully";
} else {
    echo "failed\n";
    echo ("Error description: " . $conn -> error);
}
?>
