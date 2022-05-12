<?php
include 'config.php';
$classroom = $_GET["className"];

$sql = ("select child.child_id, child.name, classroom.name as classroom from child 
         inner join classroom on child.classroom_id = classroom.classroom_id 
         where classroom.name = '".$classroom."';");
$result = $conn->query($sql);

$list = array();
if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $list[] = $row;
    }
    echo json_encode($list);
}
?>
