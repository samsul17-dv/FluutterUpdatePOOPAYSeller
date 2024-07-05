<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Form Input Produk dengan Gambar</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        form {
            max-width: 600px;
            margin: 0 auto;
            background: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        input[type="text"], input[type="number"], input[type="file"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            float: right;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<h2>Form Input Produk dengan Gambar</h2>

<form action="insert_product.php" method="post" enctype="multipart/form-data">
    <label for="productName">Nama Produk:</label><br>
    <input type="text" id="productName" name="productName" required><br><br>

    <label for="price">Harga:</label><br>
    <input type="number" id="price" name="price" step="0.01" required><br><br>

    <label for="storeName">Nama Toko:</label><br>
    <input type="text" id="storeName" name="storeName" required><br><br>

    <label for="imageFile">Gambar Produk:</label><br>
    <input type="file" id="imageFile" name="imageFile" accept="image/*" required><br><br>

    <input type="submit" value="Simpan">
</form>

</body>
</html>
