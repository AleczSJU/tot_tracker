<?php
include 'config.php';
$plan = $_GET["plan"];
$className = $_GET["className"];
$date = $_GET["date"];
//$date = strtotime($planDate);

$getnewid = ("select max(lessonplan_id) as maxID from lessonPlan;");
$result = $conn->query($getnewid);

$newid = array();
if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $newid[] = $row['maxID'];
    }
}

$newid[0] = $newid[0] + 1;

$getID = ("select classroom_id from classroom where name = '".$className."';");
$result2 = $conn->query($getID);

$classid = array();
if ($result2 -> num_rows > 0) {
    while ($row = $result2->fetch_assoc()) {
        $classid[] = $row['classroom_id'];
    }
}

$sql = ("insert into lessonPlan values (".$newid[0].", '".$plan."', '".$date."', 1, ".$classid[0].");");

if ($conn->query($sql) == TRUE) {
    echo "inserted successfully";
} else {
    echo "failed";
    echo ("Erro description: " . $conn -> error);
}

?>
