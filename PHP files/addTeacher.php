<?php
include 'config.php';
$name = $_GET["name"];
$age = $_GET["age"];
$gender = $_GET["gender"];
$email = $_GET["email"];
$phoneNumber = $_GET["phoneNumber"];
$classroom = $_GET["classroom"];

$getnewid = ("select max(teacher_id) as maxID from teacher;");
$result = $conn->query($getnewid);

$newid = array();
if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $newid[] = $row['maxID'];
    }
}

$newid[0] = $newid[0] + 1;

$getID = ("select classroom_id from classroom where name = '".$classroom."';");
$result2 = $conn->query($getID);

$classroom_id = array();
if ($result2 -> num_rows > 0) {
    while ($row = $result2->fetch_assoc()) {
        $classroom_id[] = $row['classroom_id'];
    }
}

$sql = ("insert into teacher values (".$newid[0].", '".$name."', ".$age.", '".$gender."', '".$email."', '".$phoneNumber."', ".$classroom_id[0].");");

if ($conn->query($sql) == TRUE) {
    echo "inserted successfully";
} else {
    echo "failed";
    echo ("Error description: " . $conn -> error);
}

?>
