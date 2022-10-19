<?php 

include 'php/Conexio.php';
$result = "";
if(isset($_POST['subButton'])){ //check if form was submitted
	$result = "";
	$user = $_POST['user'];
	$pass = $_POST['pass'];

	$sql = "SELECT * from usuari where nomUsuari = '$user' and pass = '$pass'";
	$result = mysqli_query($conexio,$sql);
	if ($result->num_rows > 0) {
		if ($row = $result->fetch_assoc()) {
			$result = "";
			session_start();
			$_SESSION["user"]=$user;
			$_SESSION["idUsuari"]= $row['idUsuari'];
		}
		header("Location: profile.php?user=$user");
	} else {
		$result = "Usuario no Encontrado";
	}
}

$exist = false;
if(isset($_POST['SingIn'])){ //check if form was submitted
	$result = "";
	$user = $_POST['user1'];
	$pass = $_POST['pass1'];
	$sql = "SELECT * from usuari where nomUsuari = '$user'";
	$result1 = mysqli_query($conexio,$sql);
	if ($result1->num_rows > 0) {
		if ($row = $result1->fetch_assoc()) {
			$exist = true;
		}
	} else {
		$sql = "INSERT INTO usuari(`nomUsuari`, `pass`, `privacitat`) VALUES ('$user', '$pass', 'Publica')";
		if ($conexio->query($sql) === TRUE) {
			session_start();
			$_SESSION["user"]=$user;
			$_SESSION["idUsuari"]= $row['idUsuari'];
			echo "New record created successfully";
      		header("Location: profile.php?user=$user");
    	} else {
      		echo "Error: " . $sql . "<br>" . $conexio->error;
    	}
	}
}
?>

<!DOCTYPE html>
<html>
<head>
	 <link rel="stylesheet" href="css/Cantina.css">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title></title>
</head>
<body>
	<div align="center" class="main">
		<h1 align="center">Hello There!</h1>
		<h2 align="center">Login</h2>
		<form action="" method="post">
		 	<p>User: <input type="text" name="user" required /></p>
		 	<p>Pass: <input type="text" name="pass" required/></p>
		 	<p><input type="submit"name="subButton" value="login" /></p>
		 	<p><?php echo $result; ?></p>
		</form>
		<hr>
		<h2 align="center">Sing in</h2>
		<form action="" method="post">
		 	<p>User: <input type="text" name="user1" required/></p>
		 	<p><?php if($exist == true){ echo" Este usuario ya existe";} ?></p>
		 	<p>Pass: <input type="text" name="pass1" required/></p>
		 	<p><input type="submit" name="SingIn" value="SingIn" /></p>
		</form>
	</div>
</body>
</html>