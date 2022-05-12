<?php
include 'config.php';
$name = $_GET["name"];

$getnewid = ("select max(classroom_id) as maxID from classroom;");
$result = $conn->query($getnewid);

$newid = array();
if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $newid[] = $row['maxID'];
    }
}

$newid[0] = $newid[0] + 1;

$sql = ("insert into classroom values (".$newid[0].", '".$name."');");

if ($conn->query($sql) == TRUE) {
    echo "inserted successfully";
} else {
    echo "failed\n";
    echo ("Erro description: " . $conn -> error);
}

?>
