<?PHP
$user="root";

$pass="";

$Dbase="Db_Interface";

mysql_connect("localhost",$user,$pass) or die( "Erro de acesso ao BD");

@mysql_select_db($Dbase) or die( "Erro ao selecionar tabela");

mysql_close();

?>
