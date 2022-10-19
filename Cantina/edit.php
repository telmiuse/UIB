<?php 
session_start();
include 'php/Conexio.php';
$userURL = $_GET['user']; // output 2489


$user = $_SESSION["user"];
$idUser;
$img;
$pass;
$profText;
$sql = "SELECT imgProfile,textProfile,idUsuari,pass from usuari where nomUsuari = '$user'";
	$result = mysqli_query($conexio,$sql);
	if ($result->num_rows > 0) {
		while ($row = $result->fetch_assoc()) {
			$img = $row['imgProfile'];
			$profText =$row['textProfile'];
			$idUser = $row['idUsuari']; 
			$pass = $row['pass']; 
		}
	}	
	if(empty($img)){
		$img = "img/duser.jpg";
	}else{
		$img = 'img/'.$img;
	}
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
				<img src= "img/reenviar.png" alt="Girl in a jacket" width="30" height="30">
			</th>
			<th>
				<?php echo '<a href="profile.php?user='.$user.'"">'; ?> <img class="iper" <?php echo 'src= "'.$img.'"'?> alt="Girl in a jacket" width="30" height="30"></a>
			</th>
		</tr>
	</table>
</div>
<br>
	<div align="center" class="main">
		<h1><?php echo $user; ?> </h1> 
		<?php if($userURL != $user)	 {
			echo '<div class="pbutton">
					<button type="button">Mensaje</button>
					<button type="button">Seguir</button>	
				</div>';
		}else{
			echo '<div class="pbutton">
					<a href="publicacion.php?user='.$user.'" >Crear publicacion</a>
					<a href="historia.php?user='.$user.'">Crear historia</a>
					<a href="edit.php?user='.$user.'">Editar perfil</a>
				</div>';
		} ?>

		<form runat="server" action="php/Uedit.php"  method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<th class="textP">
  							<label for="fname">Usuari:</label>
  							<input type="text" id="fname" name="fname" <?php echo 'value="'.$user.'"' ?>  ><br>
					</th>
				</tr>
				<tr>
					<th class="imgP">
							<label for="fileToUpload">Imagen:</label>
  							<input name="fileToUpload" accept="image/*" type='file' id="imgInp" /><br>
  							<img id="blah" <?php echo 'src= "'.$img.'"' ;?>  width="100" height="100" alt="your image"/>			
					</th>
				</tr>
				<tr>
					<th class="textP">
						<textarea  type="textArea" id="fname" name="desc"><?php echo $profText; ?></textarea><br><br>
					</th>
				</tr>
				<tr>
					<th>
							<label for="pass">Contraseña:</label>
  							<input type="text" id="fname" name="pass" <?php echo 'value="'.$pass.'"' ?>  ><br>
					</th>
				</tr>
				<tr>
					<th>
						<label for="privi">Privacitat:</label>
					  <select id="privi" name="privi">
					    <option value="Privat">Privat</option>
					    <option value="Public">Public</option>
					  </select>
					</th>
				</tr>
				<tr>
					<th>
						<input type="submit" value="Submit">
					</th>
				</tr>
			</table>
		</form>
		<hr>
	</div>
</body>
</html>

<script type="text/javascript">
	imgInp.onchange = evt => {
  const [file] = imgInp.files
  if (file) {
    blah.src = URL.createObjectURL(file)
  }
}

</script>