<?php

/*
	Receives: user, password, firstname, surname
	Returns: true, else(= error)

*/

// Include utils
require 'utils.php';

header('Content-type: application/json');


if($_POST) {
	$username 		= $_POST['username'];
	$password 		= $_POST['password']; 
	$new_firstname 	= $_POST['new_firstname'];
	$new_surname 		= $_POST['new_lastname'];
	
	if($username && $password &&
		$new_firstname && $new_surname) {

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
				
				$changeSuccessful = changeName($mysqli, $username, $password, $new_firstname, $new_surname);
			
				if ($changeSuccessful) {
					echo "true";
				} else {	echo "Name could not be changed.";	}
					
				$mysqli->close();
				
			}
	} else {
		echo '{"success":-1,"error_message":"Invalid Arguments."}';
	}
}else {
	echo '{"success":-1,"error_message":"Invalid Data."}';
}


function changeName(&$mysqli,&$username, &$password, &$new_firstname, &$new_surname){

	if(validUser($mysqli, $username, $password) == false)
		return false;

	if ($stmt = $mysqli->prepare("UPDATE USER SET FirstName=?, Surname=? WHERE Username=?")) {

		/* bind parameters for query (security) */
		$stmt->bind_param("sss", $new_firstname, $new_surname, $username);

		/* execute query */
		$stmt->execute();

		/* close statement */
		$stmt->close();
	}
	
	return true;
}

?>
