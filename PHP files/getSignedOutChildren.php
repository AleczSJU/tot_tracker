<?php
include 'config.php';

$todayDate = date("Y-m-d");

$sql = "select distinct name, attendance.child_id from attendance 
        inner join child on child.child_id = attendance.child_id 
        where attendance.child_id not in (
	    select attendance.child_id from attendance 
	    inner join child on child.child_id = attendance.child_id 
	    where status like '%check_in%' and date >= '$todayDate' and attendance.child_id not in (
                select child_id from attendance where status like '%check_out%' and date >= '$todayDate'));
";
$result = $conn->query($sql);

$list = array();
if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $list[] = $row;
    }
    echo json_encode($list);
}
?>
