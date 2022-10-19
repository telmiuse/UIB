<?php
 $conexio=mysqli_connect("localhost","root","") or die("Connection failed: " . mysqli_connect_error());
 $bd=mysqli_select_db($conexio,"Cantina") or die("Connection failed: " . mysqli_connect_error());
 

?>