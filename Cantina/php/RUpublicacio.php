<?php
include 'Conexio.php';
session_start();

$user = $_SESSION["user"];
$idUsuario = $_SESSION["idUsuari"];

$idOrigin = $_POST["idPub"];
$text = $_POST["text"];

 $sql = "INSERT INTO publicacio(`idRevPub`, `idUsuari`, `textPubli`) VALUES 
    ('$idOrigin','$idUsuario','$text')";

    if ($conexio->query($sql) === TRUE) {
      echo "New record created successfully";
      header("Location: ../profile.php?user=$user");
    } else {
      echo "Error: " . $sql . "<br>" . $conexio->error;
    }
