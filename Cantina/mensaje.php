
<?php
session_start();
include 'php/Conexio.php';
$userURL = $_GET['user']; // output 2489
$user = $_SESSION["user"];
$idUser =$_SESSION["idUsuari"];
$idUserFollow;

$img;
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
	if(empty($img)){
		$img = "img/duser.jpg";
	}else{
		$img = 'img/'.$img;
	}
$imgSeguidor;
$nomSeguidor;
	$sql = "SELECT * from usuari where nomUsuari = '$userURL'";
	$resultF = mysqli_query($conexio,$sql);
			if ($resultF->num_rows > 0) {
				if ($rowF = $resultF->fetch_assoc()) {
					$idUserFollow = $rowF['idUsuari'];
				}
			}

if(isset($_POST['submit'])){ //check if form was submitted
	$result = "";
	$msg = $_POST['text'];




	$sql = "INSERT INTO missatge(`idUsusariEmisor`, `idUsusariReceptor`, `textMissatge`) VALUES ('$idUser','$idUserFollow','$msg')";
		if ($conexio->query($sql) === TRUE) {
			header("Location:mensaje.php?user=$userURL");
    	} else {
      		echo "Error: " . $sql . "<br>" . $conexio->error;
    	}
}

?>


<!DOCTYPE html>
<html>
<head>
	<link  rel="stylesheet" href="CS/Cantina.css">
	<meta charset="utf-8">
	<meta http-equiv="refresh" content="10" > 
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title></title>
</head>
<body>

<div class="header1">
	<table style="border-bottom: 1px solid #D7D7D7 ; width: 100%;margin: 0 auto; padding: 0;">
		<tr>
			<th align="left">
				<a href="main.php?user=null"><img src= "img/insta.png" alt="Girl in a jacket" width="125" height="50"></a>
			</th>
			<th>
				<a href="convers.php"><img src= "img/reenviar.png" alt="Girl in a jacket" width="30" height="30"></a>
			</th>
			<th>
				<?php echo '<a href="profile.php?user='.$user.'"">'; ?> <img class="iper" <?php echo 'src= "'.$img.'"'?> alt="Girl in a jacket" width="30" height="30"></a>
			</th>
		</tr>
	</table>
</div>
<br>

<div align="center" class="main">
		<?php 
			$sqlF = "SELECT * from missatge join usuari where (missatge.idUsusariEmisor = '$idUser' or missatge.idUsusariReceptor = '$idUser') 

				and (missatge.idUsusariEmisor = '$idUserFollow' or missatge.idUsusariReceptor = '$idUserFollow')
				and(missatge.idUsusariEmisor = usuari.idUsuari) ";

			$resultF = mysqli_query($conexio,$sqlF);
			if ($resultF->num_rows > 0) {
				while ($rowF = $resultF->fetch_assoc()) {
					$imgSeguidor = 'img/'.$rowF['imgProfile'];
					$nomSeguidor = $rowF['nomUsuari'];
					$idSeg = $rowF['idUsuari'];
					$msg = $rowF['textMissatge'];
					?>
				<table align="center" style="width: 500px;">
					<tr>
						<?php if(strcasecmp($nomSeguidor,$user) != 0){
							echo '<th align="left" style="width:10%;">
									<a href="profile.php?user='.$nomSeguidor.'"> <img class="iper" src= "'.$imgSeguidor.'" alt="Girl in a jacket" width="40" height="40"></a>
							</th>
							<td align="left">
								<p> '.$msg.'</p>
							</td>
					</tr>
				</table>';
						}else{
							echo '

							<td align="right">
								<p> '.$msg.'</p>
							</td>
							<th align="right"style="width:10%;">
									<a href="profile.php?user='.$nomSeguidor.'""> <img class="iper" src= '.$imgSeguidor.' alt="Girl in a jacket" width="40" height="40"></a>
							</th>
						</tr>
				</table>';
						} 
					?>
			<?php
				}
			}	
		?>
	</table>

	<form action="" method="post">
		<textarea  type="textArea" id="fname" name="text"></textarea><br><br>
		<input type="submit" value="Enviar" name="submit">
	</form>
</div>
</body>
</html>