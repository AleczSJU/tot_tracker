<?php
include 'config.php';
$name = $_GET["name"];
$age = $_GET["age"];
$gender = $_GET["gender"];
$classroom = $_GET["classroom"];

$getnewid = ("select max(child_id) as maxID from child;");
$result = $conn->query($getnewid);

$newid = array();
if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $newid[] = $row['maxID'];
    }
}

$newid[0] = $newid[0] + 1;

//$getAttendanceid = ("select max(id) as maxID from attendance;");
//$attendanceResult = $conn->query($getAttendanceid);

//$newAttendanceid = array();
//if ($attendanceResult -> num_rows > 0) {
//  while ($row = $attendanceResult->fetch_assoc()) {
//    $newAttendanceid = $row['maxID'];
//  }
//}

//$newAttendanceid[0] = $newAttendanceid[0] + 1;

$getID = ("select classroom_id from classroom where name = '".$classroom."';");
$result2 = $conn->query($getID);

$classroom_id = array();
if ($result2 -> num_rows > 0) {
    while ($row = $result2->fetch_assoc()) {
        $classroom_id[] = $row['classroom_id'];
    }
}

$sql = ("insert into child values (".$newid[0].", '".$name."', ".$age.", '".$gender."', ".$classroom_id[0].");");
//$sql2 = ("insert into attendance values(".$newAttendanceid[0].", ".$newid[0].", 'check_out', '2022-04-20');");

if ($conn->query($sql) == TRUE) {
//    $conn->query($sql2);
    echo "inserted successfully";
} else {
    echo "failed\n";
    echo ("Error description: " . $conn -> error);
}

?>
