<?php

/*	Receives: tutorialID */
/*  Returns Array: {[Title,Category,Difficulty,Duration,Text]} */

header('Content-type: application/json');


if($_POST) {
	$username   = $_POST['username'];

	if($username) {
	
			/* Load config file for connection */
			$config = parse_ini_file("junk/config.ini");


			$mysqli = new mysqli('localhost', $config['db_user'], $config['db_password'], $config['db_name']);

			/* check connection */
			if (mysqli_connect_errno()) {
				error_log("Connect failed: " . mysqli_connect_error());
				echo '{"success":0,"error_message":"' . mysqli_connect_error() . '"}';
			} else {			
				
				if ($stmt = $mysqli->prepare("SELECT Email,FirstName,Surname FROM USER WHERE Username = ?")) {
				
					$stmt->bind_param("s",$username);

					/* execute query */
					$stmt->execute();

					/* bind result variables */
					$stmt->bind_result($user_email,$user_firstname,$user_surname);
					
					$foundUser = array();
					
					/* fetch values */
					while ( $stmt->fetch() ){
						$foundUser[] = $user_email;
						$foundUser[] = $user_firstname;
						$foundUser[] = $user_surname;
						
					}

					/* close statement */
					$stmt->close();
				}
	
				/* close connection */
				$mysqli->close();
				
				$json_encoded_output = json_encode($foundUser);
				echo $json_encoded_output;
				
				
			}
	} else {
		
		echo '{"success":-1,"error_message":"Invalid Arguments."}';
	}

}else {
	
	echo '{"success":-1,"error_message":"Invalid Data."}';
}

?>
