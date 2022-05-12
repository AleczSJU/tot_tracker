<?php
include 'config.php';

$todayDate = date("Y-m-d");

$sql = ("select distinct name from t_attendance 
         inner join teacher on teacher.teacher_id = t_attendance.teacher_id 
         where t_attendance.teacher_id not in (
             select t_attendance.teacher_id from t_attendance 
	     inner join teacher on teacher.teacher_id = t_attendance.teacher_id 
	     where status like '%check_in%' and date >= 'todayDate' and t_attendance.teacher_id not in (
	         select teacher_id from t_attendance where status like '%check_out%' and date >= '$todayDate'));");
$result = $conn->query($sql);

$list = array();
if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $list[] = $row;
    }
    echo json_encode($list);
}
?>
