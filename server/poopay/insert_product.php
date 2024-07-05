<?php

// Koneksi ke database
$servername = "localhost"; // Ganti dengan nama server Anda
$username = "u1574155_samsul"; // Ganti dengan username database Anda
$password = "samsul2024"; // Ganti dengan password database Anda
$dbname = "u1574155_samsul"; // Ganti dengan nama database Anda

// Memastikan koneksi berhasil
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
  die("Koneksi ke database gagal: " . $conn->connect_error);
}

// Menerima data POST dari formulir
$productName = $_POST['productName'];
$price = $_POST['price'];
$storeName = $_POST['storeName'];

// Mengunggah file gambar
$targetDir = ""; // Simpan di root server
$targetFile = $targetDir . basename($_FILES["imageFile"]["name"]);
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($targetFile, PATHINFO_EXTENSION));

// Periksa apakah file gambar yang diunggah valid
if(isset($_POST["submit"])) {
    $check = getimagesize($_FILES["imageFile"]["tmp_name"]);
    if($check !== false) {
        $uploadOk = 1;
    } else {
        echo json_encode(array('status' => 'error', 'message' => 'File bukan file gambar.'));
        $uploadOk = 0;
        exit;
    }
}

// Periksa apakah file sudah ada
if (file_exists($targetFile)) {
    echo json_encode(array('status' => 'error', 'message' => 'Maaf, file sudah ada.'));
    $uploadOk = 0;
    exit;
}

// Periksa ukuran file
if ($_FILES["imageFile"]["size"] > 500000) {
    echo json_encode(array('status' => 'error', 'message' => 'Maaf, file terlalu besar.'));
    $uploadOk = 0;
    exit;
}

// Hanya izinkan beberapa format file
if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
&& $imageFileType != "gif" ) {
    echo json_encode(array('status' => 'error', 'message' => 'Maaf, hanya file JPG, JPEG, PNG & GIF yang diizinkan.'));
    $uploadOk = 0;
    exit;
}

// Periksa jika $uploadOk diatur ke 0 oleh suatu kesalahan
if ($uploadOk == 0) {
    echo json_encode(array('status' => 'error', 'message' => 'Maaf, file tidak terunggah.'));
    exit;
}

// Jika semuanya ok, coba unggah file
if (move_uploaded_file($_FILES["imageFile"]["tmp_name"], $targetFile)) {
    // Memastikan URL gambar
    $imageUrl = $targetFile;

    // Query SQL untuk menyimpan produk ke dalam database
    $sql = "INSERT INTO products (productName, price, storeName, imageUrl) VALUES ('$productName', '$price', '$storeName', '$imageUrl')";

    if ($conn->query($sql) === TRUE) {
        // Jika penyimpanan berhasil
        // Mengembalikan response JSON
        $response = array(
            'status' => 'success',
            'message' => 'Produk berhasil disimpan.',
            'imageUrl' => "https://samsulmuarif.my.id/server/poopay/$imageUrl" // URL gambar yang akan dikirimkan ke Flutter
        );
        echo json_encode($response);
    } else {
        // Jika terjadi kesalahan dalam penyimpanan
        echo json_encode(array('status' => 'error', 'message' => 'Error: ' . $sql . "<br>" . $conn->error));
    }
} else {
    // Jika terjadi kesalahan saat mengunggah file
    echo json_encode(array('status' => 'error', 'message' => 'Maaf, ada kesalahan saat mengunggah file.'));
}

// Menutup koneksi database
$conn->close();

?>
