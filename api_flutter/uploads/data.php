<?php
// File: fetch_products.php

// Database credentials
$servername = "localhost"; // Ganti dengan nama server Anda
$username = "u1574155_samsul"; // Ganti dengan username database Anda
$password = "samsul2024"; // Ganti dengan password database Anda
$dbname = "u1574155_samsul"; // Ganti dengan nama database Anda

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// Query to fetch products
$sql = "SELECT name, price, storeName, image FROM products";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  // Output data of each row
  $products = array();
  while($row = $result->fetch_assoc()) {
    $products[] = $row;
  }
  header('Content-Type: application/json');
  echo json_encode($products);
} else {
  echo "0 results";
}
$conn->close();
?>
