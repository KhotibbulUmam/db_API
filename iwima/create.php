<?php
     header('Content-Type: application/json');
     header('access-control-allow-origin: *');
     header('Access-Control-Allow-Headers: *');
     include "dbsql.php";

     $nim    = $_POST['nim'];
     $nama   = $_POST['nama'];
     $prodi  = $_POST['prodi'];

     $stmt   = $db->prepare("INSERT INTO mahasiswa (nim, nama, prodi) VALUES (?, ?, ?)");
     $result = $stmt->execute([$nim, $nama, $prodi]);
     echo json_encode(['success' => $result]);
?>