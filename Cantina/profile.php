<?php 
session_start();
include 'php/Conexio.php';
$userURL = $_GET['user']; // output 2489
$currentidUser =$_SESSION["idUsuari"];

$user = $_SESSION["user"];
$img;
$profText;
$follwing = false;
$sql = "SELECT imgProfile,textProfile,idUsuari,nomUsuari from usuari where nomUsuari = '$userURL' or idUsuari = '$userURL'";
	$result = mysqli_query($conexio,$sql);
	if ($result->num_rows > 0) {
		while ($row = $result->fetch_assoc()) {
			$img = 'img/'.$row['imgProfile'].'';
			$profText =$row['textProfile'];
			$idUser = $row['idUsuari']; 
			$userURL = $row['nomUsuari']; 
		}
	}	


	if(empty($img)){
		echo $img;
		$img = "img/duser.jpg";
	}

	$sql1 = "SELECT * from r_usuari_usuari where idUsuari = '$currentidUser' and idSeguidor = '$idUser'";
	$result1 = mysqli_query($conexio,$sql1);
	if ($result1->num_rows > 0) {
		while ($rowFollow = $result1->fetch_assoc()) {
			$follwing = true;
		}
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
		<h1><?php echo $userURL; ?> </h1> 
		<?php
		$n;
			 $sqlF = "SELECT COUNT(*) as n from r_usuari_usuari where idUsuari = '$idUser'";
				$resultF = mysqli_query($conexio,$sqlF);
				if ($resultF->num_rows > 0) {
				while ($rowF = $resultF->fetch_assoc()) {
					$n = $rowF['n'];
				}
			}	
		?>
		<p> <?php echo '<a href="siguiendo.php?user='.$userURL.'" >' ?>Siguiendo  <?php echo $n; ?> </a></p>

		<?php
		$n;
			 $sqlF = "SELECT COUNT(*) as n from r_usuari_usuari where idSeguidor = '$idUser'";
				$resultF = mysqli_query($conexio,$sqlF);
				if ($resultF->num_rows > 0) {
				while ($rowF = $resultF->fetch_assoc()) {
					$n = $rowF['n'];
				}
			}	
		?>
		<p><?php echo '<a href="seguidores.php?user='.$userURL.'" >' ?> Seguidores <?php echo $n; ?></a> </p>


		<?php if(strcasecmp($userURL,$user) != 0)	 {
			echo '<div class="pbutton">';
			if($follwing == true){	
				echo'<a href="Dseguir.php?user='.$userURL.'" >   Dejar de seguir   </a>';
			}
			else{
				echo'<a href="seguir.php?user='.$userURL.'" >   Seguir   </a>';
			}
			echo'<a href="mensaje.php?user='.$userURL.'" >   Mensaje privado   </a>
		</div>';
		}else{
			echo '<div class="pbutton">
					<a href="publicacion.php?user='.$userURL.'" >Crear publicacion</a>
					<a href="historia.php?user='.$userURL.'">Crear historia</a>
					<a href="edit.php?user='.$userURL.'">Editar perfil</a>
				</div>';
		} ?>
		<table>
			<tr>
				<th class="imgP">
					<?php echo '<img class="iper" src= "'.$img.'" alt="Girl in a jacket" width="100" height="100">'; ?>					
				</th>
				<th class="textP">
					<p > <?php echo $profText; ?>
				</th>
			</tr>
		</table>
		<hr>

<h1>HISTORIAS </h1>
<table>
	<tr>
<?php
	$sql2 = "SELECT * from publicacio where idHistoria != 'null' group by idHistoria";
	$resulth = mysqli_query($conexio,$sql2);
	$id = 0;
	$idd = 0;
	if ($resulth->num_rows > 0) {
		while ($rowh = $resulth->fetch_assoc()) {
			$idHistoria = $rowh['idHistoria'];
			
			$sqhi = "SELECT * from publicacio  join historia where publicacio.idUsuari = '$idUser' and publicacio.idHistoria = historia.idHistoria and historia.idHistoria = '$idHistoria'";
			$resulthi = mysqli_query($conexio,$sqhi);
			if ($resulthi->num_rows > 0) {
				echo "<th>
				<div class='slideshow-container'>";
				while ($rowhi = $resulthi->fetch_assoc()) {
					$img = 'img/'.$rowhi['img'];
					echo"<div class='mySlides fade id".$id."'>
							<div class='numbertext'>1 / 3</div>
							<img src='".$img."' style='width:300px; height:300px'>
							<div class='text'>".$rowhi['nomHistoria']."</div>
						</div>";

					
				}
							
				echo  '<!-- Next and previous buttons -->
					<a class="prev" onclick="plusSlides'.$id.'(-1)">&#10094;</a>
					<a class="next" onclick="plusSlides'.$id.'(1)">&#10095;</a>
				</div>
				<br>
				<!-- The dots/circles -->
				<div style="text-align:center">';
				for ($i=0; $i <$resulthi->num_rows ; $i++) { 								
					echo'<span class="dot'.$id.'" onclick="currentSlide'.$id.'('.$i.')"></span>';
				}

				echo"</div>
				</th>";

				if($idd==2){
					echo "</tr><tr>";
					$idd = 0;
				}else{$idd++;}

				echo'
					<script type="text/javascript">
						let slideIndexid'.$id.' = 1;
						showSlides'.$id.'(slideIndexid'.$id.');

						// Next/previous controls
						function plusSlides'.$id.'(n) {
						  showSlides'.$id.'(slideIndexid'.$id.' += n);
						}

						// Thumbnail image controls
						function currentSlide'.$id.'(n) {
						  showSlides'.$id.'(slideIndexid'.$id.' = n);
						}

						function showSlides'.$id.'(n) {
						  let i'.$id.';
						  let slides'.$id.' = document.getElementsByClassName("id'.$id.'");
						  let dots'.$id.' = document.getElementsByClassName("dot'.$id.'");
						  if (n > slides'.$id.'.length) {slideIndexid'.$id.' = 1}
						  if (n < 1) {slideIndexid'.$id.' = slides'.$id.'.length}
						  for (i = 0; i < slides'.$id.'.length; i++) {
						    slides'.$id.'[i].style.display = "none";
						  }
						  for (i = 0; i < dots'.$id.'.length; i++) {
						    dots'.$id.'[i].className = dots'.$id.'[i].className.replace(" active", "");
						  }
						  slides'.$id.'[slideIndexid'.$id.'-1].style.display = "block";
						  dots'.$id.'[slideIndexid'.$id.'-1].className += " active";
						}
					</script>
				';$id++;
			}
		}
	}
?>
</table>
<br><br><br>
<h1>PUBLICACIONS </h1>
		<table>
			<tr>
		<?php 
			$i = 0;
			$sql = "SELECT * from publicacio where idUsuari = '$idUser'";
			$result = mysqli_query($conexio,$sql);
			if ($result->num_rows > 0) {
				while ($row = $result->fetch_assoc()) {
					$img = 'img/'.$row['img'];
					$textPubli = $row['textPubli'];
					$idHistoria = $row['idHistoria'];
					$date = $row['dataPubli'];

					if($idHistoria != null){

					}else{

						if(empty($row['img'])){
							$img = "img/duser.jpg";
						}else{
							$img = 'img/'.$row['img'];
						}
					?>
						<th>
							<?php echo '<a href="main.php?user='.$user.'""><img src= '.$img.' alt="Girl in a jacket" width="300" height="300"></a>'; ?>
							<p> <?php echo $textPubli; ?> <?php echo $date; ?>	</p>
						</th>

			<?php 
					}
					if($i==2){
						echo "</tr><tr>";
						$i = 0;
					}else{$i++;}
				}
			}	
		?>
			</tr>
		</table>

	</div>
</body>
</html>

