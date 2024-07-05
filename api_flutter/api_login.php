<?php

// Konfigurasi database
define('DB_HOST', 'localhost');
define('DB_NAME', 'u1574155_samsul');
define('DB_USER', 'u1574155_samsul');
define('DB_PASS', 'samsul2024');

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");

// Memeriksa apakah request adalah POST dan data yang diperlukan ada
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['email']) && isset($_POST['password'])) {

    // Ambil nilai dari POST
    $email = $_POST['email'];
    $password = $_POST['password'];

    try {
        // Buat koneksi ke database menggunakan PDO
        $pdo = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME, DB_USER, DB_PASS);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // Cari pengguna berdasarkan email dan password
        $query = "SELECT username, email FROM users WHERE email = :email AND password = :password";
        $stmt = $pdo->prepare($query);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':password', $password);
        $stmt->execute();

        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user) {
            // Jika pengguna ditemukan, kirim respons berhasil
            $response = array(
                'success' => true,
                'user' => $user
            );
        } else {
            // Jika pengguna tidak ditemukan
            $response = array(
                'success' => false,
                'message' => 'Email atau Password salah.'
            );
        }

    } catch (PDOException $e) {
        // Jika terjadi kesalahan saat mengakses database
        $response = array(
            'success' => false,
            'message' => 'Error: ' . $e->getMessage()
        );
    }

    // Tutup koneksi database
    $pdo = null;

} else {
    // Jika request bukan POST atau data tidak lengkap
    $response = array(
        'success' => false,
        'message' => 'Permintaan tidak valid.'
    );
}

// Mengirimkan respons dalam format JSON
header('Content-Type: application/json');
echo json_encode($response);

?>
