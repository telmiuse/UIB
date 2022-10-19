
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

?>


<!DOCTYPE html>
<html>
<head>
<link  rel="stylesheet" href="CS/Cantina.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title></title>
</head>
<body style="margin: 0 auto;">
<div class="header1">
	<table style="border-bottom: 1px solid #D7D7D7 ; width: 100%;margin: 0 auto; padding: 0;">
		<tr>
			<th align="left">
				<a href="main.php?user=null"><img src= "img/insta.png" alt="Girl in a jacket" width="125" height="50"></a>
			</th>
			<th>
				<a href="converses.php"><img src= "img/reenviar.png" alt="Girl in a jacket" width="30" height="30"></a>
			</th>
			<th>
				<?php echo '<a href="profile.php?user='.$user.'"">'; ?> <img class="iper" <?php echo 'src= "'.$img.'"'?> alt="Girl in a jacket" width="30" height="30"></a>
			</th>
		</tr>
	</table>
</div>
<br>
<div align="center" class="main">
	<table align="center" style="width: 500px;">
		<?php 
			$sqlF = "SELECT * from r_usuari_usuari join usuari where r_usuari_usuari.idUsuari = '$idUser' and usuari.idUsuari =  r_usuari_usuari.idSeguidor";
			$resultF = mysqli_query($conexio,$sqlF);
			if ($resultF->num_rows > 0) {
				while ($rowF = $resultF->fetch_assoc()) {
					$imgSeguidor = 'img/'.$rowF['imgProfile'];
					$nomSeguidor = $rowF['nomUsuari'];

					?>
					<tr>
						<th>
							<?php echo '<img class="iper" src= "'.$imgSeguidor.'" alt="Girl in a jacket" width="50" height="50">'; ?>
						</th>
						<th align="left" >
							<p align="left"> <?php echo '<a href="profile.php?user='.$nomSeguidor.'"">'; ?><?php echo $nomSeguidor; ?></a></p>
						</th>
					</tr>
			<?php
				}
			}	
		?>
	</table>
</div>
</body>
</html>