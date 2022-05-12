<?php
include 'config.php';
$name = $_GET["name"];

$sql = ("select classroom.classroom_id, classroom.name, count(child_id) as count from classroom 
         inner join child on child.classroom_id = classroom.classroom_id 
         where classroom.name = '".$name."' group by classroom.name;");
$result = $conn->query($sql);

$list = array();
if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $list[] = $row;
    }
    echo json_encode($list);
}
?>
