<?php
include 'config.php';
$name = $_GET["name"];

$sql = ("select child.child_id, child.name, age, gender, classroom.name as className from child inner join classroom on child.classroom_id = classroom.classroom_id where child.name = '".$name."';");
$result = $conn->query($sql);

$list = array();
if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $list[] = $row;
    }
    echo json_encode($list);
}
?>
