<?php
include 'config.php';
$className = $_GET["className"];

$sql = ("select plan, date from lessonPlan
         inner join classroom on classroom.classroom_id = lessonPlan.classroom_id
         where classroom.name = '".$className."';"); 
$result = $conn->query($sql);

$list = array();
if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $list[] = $row;
    }
    echo json_encode($list);
}
?>
