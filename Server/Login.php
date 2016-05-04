<?php

/*	Receives: username, password*/
/*	Returns: true or "success":-1*/

header('Content-type: application/json');


if($_POST) {
	$username  = $_POST['username'];
	$password = $_POST['password']; // is a string of stop names seperated by ';'
	
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
				$UserID = 0;
			
				/* Check login*/
				if ($stmt = $mysqli->prepare("SELECT UserID FROM USER WHERE Username = ? AND Password = ?")) {

					// Build SHA512 value of password (bcrypt would be better, but this should be enough)
					$password_hashed =  hash('sha512', $password);

					/* bind parameters for markers */
					$stmt->bind_param("ss", $username, $password_hashed);

					/* execute query */
					$stmt->execute();

					/* bind result variables */
					$stmt->bind_result($UserID);
					
					$stmt->fetch();
					

					/* close statement */
					$stmt->close();
				}

					
				if ($UserID) {
					echo "true";
					/*error_log("Inserted requsted stations!");
					*/
					
			
				} else {
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
