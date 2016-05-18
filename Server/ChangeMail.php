<?php

/*
	Receives: user, password, new_email
	Returns: true, else(= error)

*/

// Include utils
require 'utils.php';

header('Content-type: application/json');


if($_POST) {
	$username 		= $_POST['username'];
	$pw_new 		= $_POST['password']; 
	$pw_old 		= $_POST['new_email'];
	
	if($username && $pw_new &&
		$pw_old) {

			/* Load config file for connection */
			$config = parse_ini_file("junk/config.ini");

			$mysqli = new mysqli('localhost', $config['db_user'], $config['db_password'], $config['db_name']);
			mysqli_query($mysqli, "SET NAMES 'utf8'");
			
			/* check connection */
			if (mysqli_connect_errno()) {
				error_log("Connect failed: " . mysqli_connect_error());
				echo '{"success":0,"error_message":"' . mysqli_connect_error() . '"}';
			} else {
				
				$changeSuccessful = 0;
				
				$changeSuccessful = changeMail($mysqli, $username, $password, $new_email);
			
				if ($changeSuccessful) {
					echo "true";
				} else {	echo "Mail could not be changed.";	}
					
				$mysqli->close();
				
			}
	} else {
		echo '{"success":-1,"error_message":"Invalid Arguments."}';
	}
}else {
	echo '{"success":-1,"error_message":"Invalid Data."}';
}


function changeMail(&$mysqli,&$username, &$password, &$new_email){

	if(validUser($mysqli, $username, $password) == false)
		return false;

	if ($stmt = $mysqli->prepare("UPDATE USER SET Email=? WHERE Username=?")) {

		/* bind parameters for query (security) */
		$stmt->bind_param("ss", $new_email , $username);

		/* execute query */
		$stmt->execute();

		/* close statement */
		$stmt->close();
	}
	
	return true;
}

?>
