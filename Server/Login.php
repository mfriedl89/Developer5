<?php

/*	Receives: username, password*/
/*	Returns: true or "success":-1*/

header('Content-type: application/json');

require 'utils.php';


if($_POST) {
	$username  = $_POST['username'];
	$password = $_POST['password'];
	
	if($username && $password) {

			/* Load config file for connection */
			$config = parse_ini_file("junk/config.ini");


			$mysqli = new mysqli('localhost', $config['db_user'], $config['db_password'], $config['db_name']);
			mysqli_query($mysqli, "SET NAMES 'utf8'");
			
			/* check connection */
			if (mysqli_connect_errno()) {
				error_log("Connect failed: " . mysqli_connect_error());
				echo '{"success":0,"error_message":"' . mysqli_connect_error() . '"}';
			} else {
				$result = false;

				$result = validUser($mysqli, $username, $password);
				if($result == true) {
					echo "true";
				}
				else {
					error_log("Arguments do not match.");
					echo '{"success":-1,"error_message":"We are sorry - This user does not exist!"}';
				}
				
			}
	} else {
		echo '{"success":-1,"error_message":"Invalid Arguments."}';
		
	}
}else {
echo '{"success":-1,"error_message":"Invalid Data."}';
	
}
?>
