<?php
session_start();
include 'php/Conexio.php';
$userURL = $_GET['user']; // output 2489
$user = $_SESSION["user"];
$idUser =$_SESSION["idUsuari"];
$idUserFollow;

$sql = "SELECT * from usuari where nomUsuari = '$userURL'";
$result = mysqli_query($conexio,$sql);
	if ($result->num_rows > 0) {
		while ($row = $result->fetch_assoc()) {
			$idUserFollow = $row['idUsuari'];
		}
	}	


$sql = "INSERT INTO r_usuari_usuari(`idUsuari`, `idSeguidor`) VALUES 
    ('$idUser','$idUserFollow')";

    if ($conexio->query($sql) === TRUE) {
      echo "New record created successfully";
      header("Location: profile.php?user=$userURL");
    } else {
      echo "Error: " . $sql . "<br>" . $conexio->error;
    }
?>