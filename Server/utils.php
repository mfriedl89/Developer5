<?php

// Contains utilitiy functions used amongst the different scripts

// The password comes in plaintext here. This is no problem though, because it was transmitted by HTTPS POST, which is encrypted.
function validUser(&$mysqli,&$username,&$password){

	$userValid = 0;
	
	if ($stmt = $mysqli->prepare("SELECT UserID FROM USER WHERE Username = ? AND Password = ?")) {

		// Build SHA512 value of password (bcrypt would be better, but this should be enough)
		$password_hashed =  hash('sha512', $password);

		/* bind parameters for markers */
		$stmt->bind_param("ss", $username, $password_hashed);

		/* execute query */
		$stmt->execute();

		/* bind result variables */
		$stmt->bind_result($userValid);
		
		$stmt->fetch();
		
		/* close statement */
		$stmt->close();
	}
	
	if($userValid){
		return true;
	}
	
	return true;
}

?>
