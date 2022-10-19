<?php
include 'Conexio.php';
session_start();

$user = $_SESSION["user"];
$idUsuario = $_SESSION["idUsuari"];
$myFile = $_FILES['fileToUpload'];
$fileCount = count($myFile["name"]);
$nomHistoria = $_POST['desc'];
$idHistoria = 0;

$sqlH = "INSERT INTO  historia (`idUsuari`, `nomHistoria`) VALUES ('$idUsuario','$nomHistoria')";
if ($conexio->query($sqlH) === TRUE) {
  echo "New record created successfully";
  $idHistoria = $conexio->insert_id;
} else {
  echo "Error: " . $sqlH . "<br>" . $conexio->error;
}


for ($i = 0; $i < $fileCount; $i++) {
  $target_dir = "../img/";
  $target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]["$i"]);
  $uploadOk = 1;
  $imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));

  // Check if image file is a actual image or fake image
  if(isset($_POST["submit"])) {
    $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]["$i"]);
    if($check !== false) {
      echo "File is an image - " . $check["mime"] . ".";
      $uploadOk = 1;
    } else {
      echo "File is not an image.";
      $uploadOk = 0;
    }
  }

  // Check if file already exists
  // if (file_exists($target_file)) {
   // echo "Sorry, file already exists.";
    // $uploadOk = 0;
   //}


  // Allow certain file formats
  if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
  && $imageFileType != "gif" ) {
    echo "Sorry, only JPG, JPEG, PNG & GIF files are allowed.";
    $uploadOk = 0;
  }

  // Check if $uploadOk is set to 0 by an error
  if ($uploadOk == 0) {
    echo "Sorry, your file was not uploaded.";
  // if everything is ok, try to upload file
  } else {
    if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"]["$i"], $target_file)) {
      echo "The file ". htmlspecialchars( basename( $_FILES["fileToUpload"]["name"]["$i"])). " has been uploaded.";

      $img = $_FILES["fileToUpload"]["name"]["$i"];
      $text = $_POST["desc"];

      $sql = "INSERT INTO publicacio(`idUsuari`,`idHistoria`, `img`, `textPubli`) VALUES 
      ('$idUsuario','$idHistoria','$img','$text')";

      if ($conexio->query($sql) === TRUE) {
        echo "New record created successfully";
      } else {
        echo "Error: " . $sql . "<br>" . $conexio->error;
      }

    } else {
      echo "Sorry, there was an error uploading your file.";
    }
  }
}

header("Location: ../profile.php?user=$user");

?>