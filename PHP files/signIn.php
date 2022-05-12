
<?php
include 'config.php';
$childName = $_GET["childName"];

$getnewid = ("select max(id) as maxID from attendance;");
$result = $conn->query($getnewid);

$newid = array();
if ($result -> num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $newid[] = $row['maxID'];
    }
    //echo json_encode($id);
}

$newid[0] = $newid[0] + 1;

$getchildid = ("select child_id from child where name = '".$childName."';");
$result2 = $conn->query($getchildid);

$childid = array();
if ($result2 -> num_rows > 0) {
    while ($row = $result2->fetch_assoc()) {
        $childid[] = $row['child_id'];
    }
}


$sql = ("insert into attendance values (".$newid[0].", ".$childid[0].", 'check_in', now())");

if ($conn->query($sql) == TRUE) {
    echo "inserted successfully";
} else {
    echo "failed";
}
?>
