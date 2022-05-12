<?php
include 'config.php';
$childName = $_GET["childName"];

$sql = ("select dailyReport.report_id, report, child.name, DATE_FORMAT(date, '%l:%i %p') as date, child.child_id from dailyReport 
         inner join child on child.child_id = dailyReport.child_id
         where child.name = '".$childName."' and dailyReport.date >= curdate();");
$result = $conn->query($sql);

$list = array();
if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $list[] = $row;
    }
    echo json_encode($list);
}
?>
