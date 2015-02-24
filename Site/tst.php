<?PHP
$user="root";

$pass="";

$Dbase="Db_Interface";

$con=mysqli_connect("localhost",$user,$pass,$Dbase);
// Check connection
if (mysqli_connect_errno()) {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$result = mysqli_query($con,"SELECT * FROM Tb_Palavras");

while($row = mysqli_fetch_array($result)) {
	
?>
<tr>
	<td><? echo $row['Palavra'] ?></td>
	<td><? echo $row['File'] ?></td>
	<td><? echo $row['Ordem'] ?></td>
</tr>

<?
  //echo $row['Palavra'] . " " . $row['File'];
  echo "<br>";
}

mysqli_close($con);
?>
