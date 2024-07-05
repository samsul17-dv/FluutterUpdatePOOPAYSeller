<?php

// Koneksi ke database
$servername = "localhost"; // Ganti dengan nama server Anda
$username = "u1574155_samsul"; // Ganti dengan username database Anda
$password = "samsul2024"; // Ganti dengan password database Anda
$dbname = "u1574155_samsul"; // Ganti dengan nama database Anda

// Buat koneksi
$conn = new mysqli($servername, $username, $password, $dbname);

// Periksa koneksi
if ($conn->connect_error) {
  die("Koneksi ke database gagal: " . $conn->connect_error);
}

// Query SQL untuk mendapatkan produk
$sql = "SELECT productName, price, storeName, imageUrl FROM products";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  // Array untuk menyimpan produk
  $products = array();

  // Mengambil data setiap baris dari hasil query
  while ($row = $result->fetch_assoc()) {
    // Menambahkan data produk ke dalam array
    $products[] = $row;
  }

  // Menyusun hasil dalam format JSON
  $response = array(
    'success' => true,
    'message' => 'Data produk berhasil diambil',
    'products' => $products
  );
} else {
  // Jika tidak ada produk yang ditemukan
  $response = array(
    'success' => false,
    'message' => 'Tidak ada produk yang ditemukan'
  );
}

// Mengembalikan respons dalam format JSON
header('Content-Type: application/json');
echo json_encode($response);

// Menutup koneksi database
$conn->close();

?>
