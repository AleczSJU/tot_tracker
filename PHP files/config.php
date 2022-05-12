<?php

$host =  "10.0.0.144:3306";
$username = "alecRemote";
$password = "alecZubyk12";
$dbname = "tot_tracker";

$conn = new mysqli($host, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

?>
