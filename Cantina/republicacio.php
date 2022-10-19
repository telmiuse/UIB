<?php 
session_start();
include 'php/Conexio.php';
$idP = $_GET['idP']; // output 2489


$user = $_SESSION["user"];
$idUser;
$img;
$imgPubli;

$profText;
$sql = "SELECT imgProfile,textProfile,idUsuari from usuari where nomUsuari = '$user'";
	$result = mysqli_query($conexio,$sql);
	if ($result->num_rows > 0) {
		while ($row = $result->fetch_assoc()) {
			$img = $row['imgProfile'];
			$profText =$row['textProfile'];
			$idUser = $row['idUsuari']; 
		}
	}	
	if(empty($row['imgProfile'])){
		$img = "img/duser.jpg";
	}

	$sql1 = "SELECT * from publicacio where idPub = '$idP'";
	$result1 = mysqli_query($conexio,$sql1);
	if ($result1->num_rows > 0) {
		while ($row = $result1->fetch_assoc()) {
			$imgPubli = "img/".$row['img'];
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
		<h1><?php echo $user; ?> </h1> 
		<table>
			<tr>
				<th class="imgP">
					<?php echo '<img src= '.$img.' alt="Girl in a jacket" width="100" height="100">'; ?>					
				</th>
				<th class="textP">
					<p > <?php echo $profText; ?>	</p>
				</th>
			</tr>
		</table>
		<hr>

		<table>
			<tr>
				<th class="imgP">
					<?php echo '<img src= '.$imgPubli.' alt="Girl in a jacket" width="300" height="300">'; ?>					
				</th>
			</tr>
		</table>
		<form action="php/RUpublicacio.php" method="post" >
			<input type="hidden" name="idPub" <?php echo "value='".$idP."'" ?> >
  			<textarea  type="textArea" id="fname" name="text"></textarea><br><br>
		  	<input type="submit" value="Upload Image" name="submit">
		</form>
	</div>
</body>

</html>