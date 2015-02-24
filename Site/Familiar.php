<?PHP
header('Content-Type: text/html; charset=utf-8');
 
$user="root";

$pass="";

$Dbase="db_interface";

$con=mysqli_connect("localhost",$user,$pass,$Dbase);
// Check connection
if (mysqli_connect_errno()) {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
mysqli_query($con,"SET NAMES 'utf8'");

$resultI = mysqli_query($con,"SELECT * FROM tb_palavras");


$resultII = mysqli_query($con,"SELECT * FROM registros");


?>


<html lang="pt-Br">

<head> 	
	
    <meta http-equiv = "Content-Type" content = "text/html; charset=utf-8" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Daniel de Castro Rodrigues">
    <link rel="icon" href=" img/speech_icon.png">

   <title>Interface Speech</title>

    <!-- Bootstrap core CSS -->
    <link href="dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="dist/css/justified-nav.css" rel="stylesheet">
	
	<style>
	
	
	</style>
   
	
  </head>

  <body>
	  
	  
    <script>
		
	if (navigator.appName == "Microsoft Internet Explorer") {
			document.location = "ie.html"; 
	} 
		
    </script>

    <div class="container">

      <div class="masthead">
       
        <ul class="nav nav-justified" >
          <li><a href="index.html">Home</a></li>
          <li><a  href="Projeto.html">Projeto</a></li>
          <li><a  href="Downloads.html">Downloads</a></li>
          <li><a  href="Contato.html">Contato</a></li>
          <li><a  href="Acesso.php">Acesso</a></li>
        </ul>
      </div>

      <!-- Jumbotron -->
      
      <div class="jumbotron" style="color:#FFFFFF">
        <h1>Interface <span style="color:#c0150d">Speech</span></h1>
        <h2 class="lead"><span style="color:#c0150d">S</span>istema <span style="color:#c0150d">P</span>aliativo <span style="color:#c0150d">E</span>specializado 
        <span style="color:#c0150d">E</span>m <span style="color:#c0150d">C</span>omunicação <span style="color:#c0150d">H</span>umana.</h2>
       <hr>
      </div>

      <!-- Example row of columns -->
      <div class="row" style="color:#FFFFFF; margin-top:-70px">
	  <div class="col-md-5">
		<h2 align="center">Opções de palavras</h2>
	  
		  <table class="table">
		  <thead>
		  <tr>
			<th>Palavra</th>
			<th>Audio</th>
			<th>Posição</th>
		  </tr>
		  </thead>
		  <?
		while($row = mysqli_fetch_array($resultI)) {
	
		?>
<tr>
	<td><? echo $row['Palavra']; ?></td>
	<td><? echo $row['File'] ?></td>
	<td><? echo $row['Ordem'] ?></td>
</tr>

	<? } ?>
		  </table>
       
	  </div>
	   <div class="col-md-5 pull-right" style="color:#c0150d; background: url('img/Speech_balao.png'); background-size: 100% 110%">
		<h2 align="center" style="margin-top:-3px">Solicitações</h2>
	  
		  <table class="table">
		  <thead>
		  <tr>
			<th>Palavra</th>
			<th>Data</th>
			<th>Hora</th>
		  </tr>
		  </thead>
		  <?
		while($row = mysqli_fetch_array($resultII)) {
	
?>
<tr>
	<td><? echo $row['Palavra'] ?></td>
	<td><? echo date("d/m/o",strtotime($row['Data'])) ?></td>
	<td><? echo date("H:i:s",strtotime($row['Data'])) ?></td>
</tr>

	<? } ?>
		  
		  </table>
       
	  </div>
	  
      </div> 
 
       <!-- Site footer -->
      
      <div class="footer" >
	
      </div>

</div><!-- /container -->
</body>
</html>
