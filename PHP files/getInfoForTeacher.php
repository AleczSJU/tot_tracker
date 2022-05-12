<?php
include 'config.php';
$name = $_GET["name"];

$sql = ("select teacher.teacher_id, teacher.name, age, gender, email, phone_number, classroom.name as className from teacher inner join classroom on teacher.classroom_id = classroom.classroom_id where teacher.name = '".$name."';");
$result = $conn->query($sql);

$list = array();
if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $list[] = $row;
    }
    echo json_encode($list);
}
?>
