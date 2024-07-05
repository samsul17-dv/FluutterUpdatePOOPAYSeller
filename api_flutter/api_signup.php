<?php

// Konfigurasi database
define('DB_HOST', 'localhost'); // Ganti sesuai host database Anda
define('DB_NAME', 'u1574155_samsul'); // Ganti sesuai nama database Anda
define('DB_USER', 'u1574155_samsul'); // Ganti sesuai username database Anda
define('DB_PASS', 'samsul2024'); // Ganti sesuai password database Anda

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");

// Memeriksa apakah request adalah POST dan data yang diperlukan ada
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['username']) && isset($_POST['email']) && isset($_POST['phone']) && isset($_POST['password'])) {
    
    // Ambil nilai dari POST
    $username = $_POST['username'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];
    $password = $_POST['password'];

    // Validasi sederhana (bisa ditambahkan validasi lebih lanjut sesuai kebutuhan)
    if (empty($username) || empty($email) || empty($phone) || empty($password)) {
        // Jika ada field yang kosong
        $response = array(
            'status' => false,
            'message' => 'Semua kolom harus diisi.'
        );
    } else {
        try {
            // Buat koneksi ke database menggunakan PDO
            $pdo = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME, DB_USER, DB_PASS);
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            // Cek apakah email atau nomor telepon sudah terdaftar
            $query_check = "SELECT COUNT(*) as count FROM users WHERE email = :email OR phone = :phone";
            $stmt_check = $pdo->prepare($query_check);
            $stmt_check->bindParam(':email', $email);
            $stmt_check->bindParam(':phone', $phone);
            $stmt_check->execute();
            $row = $stmt_check->fetch(PDO::FETCH_ASSOC);

            if ($row['count'] > 0) {
                // Jika email atau nomor telepon sudah terdaftar
                $response = array(
                    'status' => false,
                    'message' => 'Email atau Nomor Telepon sudah terdaftar.'
                );
            } else {
                // Proses simpan data pengguna ke database
                $query_insert = "INSERT INTO users (username, email, phone, password) VALUES (:username, :email, :phone, :password)";
                $stmt_insert = $pdo->prepare($query_insert);
                $stmt_insert->bindParam(':username', $username);
                $stmt_insert->bindParam(':email', $email);
                $stmt_insert->bindParam(':phone', $phone);
                $stmt_insert->bindParam(':password', $password);
                $stmt_insert->execute();

                // Jika berhasil memasukkan data
                $response = array(
                    'status' => true,
                    'message' => 'Akun kamu berhasil dibuat nih! Ayo Masuk untuk Mendapatkan Layanan POOPAY sepenuhnya.',
                    'username' => $username,
                    'email' => $email,
                    'phone' => $phone
                );
            }

        } catch (PDOException $e) {
            // Jika terjadi kesalahan saat mengakses database
            $response = array(
                'status' => false,
                'message' => 'Error: ' . $e->getMessage()
            );
        }

        // Tutup koneksi database
        $pdo = null;
    }

} else {
    // Jika request bukan POST atau data tidak lengkap
    $response = array(
        'status' => false,
        'message' => 'Permintaan tidak valid.'
    );
}

// Mengirimkan respons dalam format JSON
header('Content-Type: application/json');
echo json_encode($response);

?>
