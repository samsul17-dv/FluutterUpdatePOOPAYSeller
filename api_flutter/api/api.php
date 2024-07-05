<?php
// Database credentials
$servername = "localhost"; // Ganti dengan nama server MySQL Anda
$username = "u1574155_samsul"; // Ganti dengan username MySQL Anda
$password = "samsul2024"; // Ganti dengan password MySQL Anda
$dbname = "u1574155_samsul"; // Ganti dengan nama database MySQL Anda

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// Query to fetch products
$sql = "SELECT * FROM products";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  // Array to hold products
  $products = array();

  // Fetch data and push to array
  while($row = $result->fetch_assoc()) {
    $products[] = $row;
  }

  // Close connection
  $conn->close();

  // Set content type header
  header('Content-Type: application/json');

  // Output JSON
  echo json_encode($products);
} else {
  echo "No products found";
}

?>
