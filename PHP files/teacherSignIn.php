<?php
include 'config.php';
$teacherName = $_GET["teacherName"];

$getnewid = ("select max(id) as maxID from t_attendance;");
$result = $conn->query($getnewid);

$newid = array();
if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $newid[] = $row['maxID'];
    }
}

$newid[0] = $newid[0] + 1;

$getchildid = ("select teacher_id from teacher where name = '".$teacherName."';");
$result2 = $conn->query($getchildid);

$teacherid = array();
if ($result2 -> num_rows > 0) {
    while ($row = $result2->fetch_assoc()) {
        $teacherid[] = $row['teacher_id'];
    }
}


$sql = ("insert into t_attendance values (".$newid[0].", ".$teacherid[0].", 'check_in', now())");

if ($conn->query($sql) == TRUE) {
    echo "inserted successfully";
} else {
    echo "failed";
}
?>
