<?php
// File: upload_product.php

// Koneksi ke database (contoh menggunakan PDO)
$host = 'localhost';
$dbname = 'u1574155_samsul';
$username = 'u1574155_samsul';
$password = 'samsul2024';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    die("Gagal terkoneksi dengan database: " . $e->getMessage());
}

// Tangkap data dari form pengunggahan
$name = $_POST['name'];
$price = $_POST['price'];
$storeName = $_POST['storeName'];
$image = file_get_contents($_FILES['image']['tmp_name']); // Baca gambar sebagai BLOB

// Query untuk menyimpan data produk ke database
$query = "INSERT INTO products (name, price, storeName, image) VALUES (:name, :price, :storeName, :image)";
$stmt = $pdo->prepare($query);
$stmt->bindParam(':name', $name);
$stmt->bindParam(':price', $price);
$stmt->bindParam(':storeName', $storeName);
$stmt->bindParam(':image', $image, PDO::PARAM_LOB); // Bind BLOB parameter

// Eksekusi query
if ($stmt->execute()) {
    echo "Produk berhasil diunggah ke database.";
} else {
    echo "Gagal mengunggah produk ke database.";
}
?>
