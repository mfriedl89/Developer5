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
	
	return false;
}

function tutorialExists(&$mysqli, &$tutTitle) {
	echo "8";
	$exists = 0;
	if ($stmt = $mysqli->prepare("SELECT Title FROM Tutorial WHERE Title = ?")) {

		/* bind parameters for markers */
		$stmt->bind_param("s", $tutTitle);

		/* execute query */
		$stmt->execute();

		/* bind result variables */
		$stmt->bind_result($exists);
		
		$stmt->fetch();
		
		/* close statement */
		$stmt->close();
	}

	echo "9";
	
	if($exists){
		return true;
	}

	echo "10";
	
	return false;
}

function userOwnsTutorial(&$mysqli, &$username, &$tutTitle) {
	echo "11";
	$exists = 0;
	if ($stmt = $mysqli->prepare("SELECT TutID FROM Tutorial WHERE Author = ? AND Title = ?")) {

		/* bind parameters for markers */
		$stmt->bind_param("ss", $username, $tutTitle);

		/* execute query */
		$stmt->execute();

		/* bind result variables */
		$stmt->bind_result($exists);
		
		$stmt->fetch();
		
		/* close statement */
		$stmt->close();
	}

	echo "12";
	
	if($exists){
		return true;
	}

	echo "13";
	
	return false;
}

?>
