<?php
$servername = "localhost";
$username = "u1574155_samsul";
$password = "samsul2024";
$dbname = "u1574155_samsul";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
