<?php 
session_start();
include 'php/Conexio.php';
$userURL = $_GET['user']; // output 2489
$iduser = $_SESSION["idUsuari"];
$autor;
$i = 0;
$imgAutor;
$user = $_SESSION["user"];
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


	if(isset($_POST['Publicar'])){ //check if form was submitted
		$result = "";
		$comentari = $_POST['coment'];
		$idPub = $_POST['idPub'];
		$sql = "INSERT INTO comentario(`idPub`, `idUsuari`, `textComent`) VALUES 
	    ('$idPub','$iduser','$comentari')";

	    if ($conexio->query($sql) === TRUE) {
			header("Location: main.php?user=null");
	    } else {
	      echo "Error: " . $sql . "<br>" . $conexio->error;
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


<?php
	$sql2 = "SELECT * from publicacio join usuari where usuari.idUsuari = publicacio.idUsuari and idHistoria != 'null' group by idHistoria";
	$resulth = mysqli_query($conexio,$sql2);
	$id = 0;
	if ($resulth->num_rows > 0) {
		while ($rowh = $resulth->fetch_assoc()) {
			$idHistoria = $rowh['idHistoria'];
			$autor=$rowh['nomUsuari'];
			$imgAutor='img/'.$rowh['imgProfile'];

			$sqhi = "SELECT * from publicacio  join historia where publicacio.idHistoria = historia.idHistoria and historia.idHistoria = '$idHistoria'";
			$resulthi = mysqli_query($conexio,$sqhi);
			if ($resulthi->num_rows > 0) {
				echo '<table style="width: 500px;">
					<tr>
						<th align="left" style="width: 15%;">
							<img class="iper" src= "'.$imgAutor.'" alt="Girl in a jacket" width="50" height="50">
							</th>
							<th align="left" style=" width: 85%;">
								<p align="left"> <a href="profile.php?user='.$autor.'"">'.$autor.'</a></p>
							</th>
						</tr>
					</table>';

				echo "<table style='width: 500px;'><tr><th>
				<div class='slideshow-container'>";
				while ($rowhi = $resulthi->fetch_assoc()) {
					$img = 'img/'.$rowhi['img'];
					echo"<div class='mySlides fade id".$id."'>
							<!-- <div class='numbertext'>1 / 3</div> -->
							<img src='".$img."' style='width:500px; height:500px'>
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
				</th></tr>";

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


		<table>
		<?php 
			$date;
			$idRev;
			$isRev = false;
			$originAutor;
			$idPub;
			$sql = "SELECT * from publicacio order by(dataPubli)";
			$result = mysqli_query($conexio,$sql);
			if ($result->num_rows > 0) {
				while ($row = $result->fetch_assoc()) {
					$id = $row['idUsuari'];
					$idRev = null;
					$isRev = false;
					$sqlUsuari = "SELECT * from usuari where idUsuari = '$id'";
					$resultUsuari = mysqli_query($conexio,$sqlUsuari);
					if ($resultUsuari->num_rows > 0) {
						if ($rowAutor = $resultUsuari->fetch_assoc()) {
							$idPub =$row['idPub'];
							$autor=$rowAutor['nomUsuari'];
							$imgAutor='img/'.$rowAutor['imgProfile'];
							$idRev = $row['idRevPub'];
							$date = $row['dataPubli'];
						}
					}
					$img = 'img/'.$row['img'];
					$textPubli =$row['textPubli'];
					if(empty($row['img'])){
						$img = "img/duser.jpg";
					}
					if ($idRev != null){
						$isRev = true;
						$sqlRev = "SELECT * from publicacio join usuari where idPub = '$idRev' and publicacio.idUsuari = usuari.idUsuari order by(dataPubli) ";
						$resultRev = mysqli_query($conexio,$sqlRev);
						if ($resultRev->num_rows > 0) {
							if ($rowRev= $resultRev->fetch_assoc()) {
								$img = 'img/'.$rowRev['img'];
								$originAutor =$rowRev['nomUsuari'];
								$idRev = $rowRev['idRevPub'];
								$date = $rowRev['dataPubli'];
							}
						}
					}
					while ($idRev != null){
						$sqlRev = "SELECT * from publicacio join usuari where idPub = '$idRev' and publicacio.idUsuari = usuari.idUsuari ";
						$resultRev = mysqli_query($conexio,$sqlRev);
						if ($resultRev->num_rows > 0) {
							if ($rowRev= $resultRev->fetch_assoc()) {
								$img = 'img/'.$rowRev['img'];
								$idRev = $rowRev['idRevPub'];
							}
						}
					}
			?>

					<table style="width: 500px;">
						<tr>
							<th align="left" style="width: 15%;">
								<?php echo '<img class="iper" src= "'.$imgAutor.'" alt="Girl in a jacket" width="50" height="50">'; ?>
							</th>
							<th align="left" style=" width: 85%;">
								<p align="left"> <?php echo '<a href="profile.php?user='.$autor.'"">'; ?><?php echo $autor ?></a></p>
							</th>
						</tr>
					</table>
					<table>
					<?php 
						if ($isRev == true and $originAutor != $user){
							echo'
							<tr>
								<th>
									<p> @ '.$originAutor.'</p>
								</th>
							</tr>';
						}
					?>
						<tr>
							<th>
								<?php echo '<img src= "'.$img.'" alt="Girl in a jacket" width="500" height="500">'; ?>
							</th>
						</tr>
					</table>
					<table>
						<tr>
							<th style="vertical-align:middle;" align="left">
								<img <?php echo 'id="Scoments'.$i.'"' ;?> src= "img/comentar.png" alt="Girl in a jacket" width="30" height="30">

								<a style="text-decoration: none;" <?php echo 'href="republicacio.php?idP='.$idPub.'"'; ?> > <img src= "img/reenviar.png" alt="Girl in a jacket" width="30" height="30"> </a>
								 <?php echo $textPubli; ?>
							</th>
							<th>
								<?php echo $date; ?>
							<th>
						</tr>
					</table>

					<?php echo 
					'<script>
						$(document).ready(function(){
						  $("#Scoments'.$i.'").click(function(){
						    $("#comentaris'.$i.'").toggle();
						  });
						});
					</script>';
					?>
					<table <?php echo 'id="comentaris'.$i.'"' ;?> style="display: none;"   >
					<?php 
						$sql3 = "SELECT * from comentario join usuari where idPub = '$idPub' and comentario.idUsuari = usuari.idUsuari ";
						$result3 = mysqli_query($conexio,$sql3);
						if ($result3->num_rows > 0) {
							while ($row3 = $result3->fetch_assoc()) {
								$autorComent =$row3['nomUsuari'];
								$coment = $row3['textComent'];
								$dateComent = $row3['dataComentari'];
								?>
								<tr>
									<td align="left">
										<?php echo '<a style="text-decoration:none" href="profile.php?user='.$autorComent.'"">'; ?> <?php echo '<strong> '.$autorComent. ": </strong></a>  ".$coment ?>
									</td>
									<td align="right">
										<?php echo $dateComent; ?>
									</td>
								</tr>
							<?php 
							}
						}	
					?>
					<tr>
						<th>
							<form action="" method="post">
								<!--Comentari-->
								<input type="hidden" name="idPub" <?php echo "value='".$idPub."'" ?> >
								<textarea  type="textArea" id="fname" name="coment" required></textarea>
								<input type="submit" name="Publicar" value="Publicar">
							</form>
						</th>
					</tr>
				</table>
				<br><br>
			<?php 
				$i++;}
			}
		?>


	</div>
</body>
</html>