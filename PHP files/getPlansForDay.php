<?php
include 'config.php';
$currentDay = $_GET["currentDay"];
$nextDay = $_GET["nextDay"];
$className = $_GET["className"];

$sql = ("select lessonplan_id, plan, DATE_FORMAT(date, '%l:%h %p') as date from lessonPlan 
         inner join classroom on classroom.classroom_id = lessonPlan.classroom_id 
         where (classroom.name = '".$className."') and (date between '".$currentDay."' and '".$nextDay."');");
$result = $conn->query($sql);

$list = array();
if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $list[] = $row;
    }
    echo json_encode($list);
}
?>
