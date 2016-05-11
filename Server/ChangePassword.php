<?php

/*
	Receives: user, new_password, old_password
	Returns: true, else(= error)

*/

header('Content-type: application/json');


if($_POST) {
	$username 		= $_POST['username'];
	$pw_new 		= $_POST['new_password']; 
	$pw_old 		= $_POST['old_password'];
	
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
				
				$changeSuccessful = changePassword($mysqli,$username, $pw_new, $pw_old);
			
				if ($changeSuccessful) {
					echo "true";
				} else {	echo "Password could not be changed.";	}
					
				$mysqli->close();
				
			}
	} else {
		echo '{"success":-1,"error_message":"Invalid Arguments."}';
	}
}else {
	echo '{"success":-1,"error_message":"Invalid Data."}';
}


function changePassword(&$mysqli,&$username, &$pw_new, &$pw_old){

	if(validUser($mysqli, $username, $pw_old) == false)
		return false;

	if ($stmt = $mysqli->prepare("UPDATE USER WHERE Username=? SET Password=?")) {

		// Build SHA512 value of password (bcrypt would be better, but this should be enough)
		$password_hashed =  hash('sha512', $pw_new);

		/* bind parameters for query (security) */
		$stmt->bind_param("si", $username , $password_hashed);

		/* execute query */
		$stmt->execute();

		/* close statement */
		$stmt->close();
	}
	
	return true;
}

?>
