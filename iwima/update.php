<?php
     header('Content-Type: application/json');
     header('access-control-allow-origin: *');
     header('Access-Control-Allow-Headers: *');
     include "dbsql.php";

     $nim    = $_POST['nim'];
     $nama   = $_POST['nama'];
     $prodi  =$_POST['prodi'];

     $stmt   = $db->prepare("UPDATE mahasiswa SET nama = ?, prodi = ? WHERE nim = ?");
     $result = $stmt->execute([$nama, $produ, $nim]);
     echo json_encode(['success' => $result]);
?>