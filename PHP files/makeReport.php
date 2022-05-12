<?php
include 'config.php';
$report = $_GET["report"];
$childName = $_GET["childName"];

$getnewid = ("select max(report_id) as maxID from dailyReport;");
$result = $conn->query($getnewid);

$newid = array();
if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $newid[] = $row['maxID'];
    }
}

$newid[0] = $newid[0] + 1;

$getID = ("select child_id from child where name = '".$childName."';");
$result2 = $conn->query($getID);

$childid = array();
if ($result2 -> num_rows > 0) {
    while ($row = $result2->fetch_assoc()) {
        $childid[] = $row['child_id'];
    }
}

$sql = ("insert into dailyReport values (".$newid[0].", '".$report."', null, now(), ".$childid[0].");");

if ($conn->query($sql) == TRUE) {
    echo "inserted successfully";
} else {
    echo "failed";
}

?>
