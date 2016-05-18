<?php

// Contains utilitiy functions used amongst the different scripts

function getPasswordHashedFromDb(&$mysqli, &$username) {
	$password_hashed_db = "";
	if ($stmt = $mysqli->prepare("SELECT Password FROM USER WHERE Username = ?")) {

		/* bind parameters for markers */
		$stmt->bind_param("s", $username);

		/* execute query */
		$stmt->execute();

		/* bind result variables */
		$stmt->bind_result($password_hashed_db);
		
		$stmt->fetch();
		
		/* close statement */
		$stmt->close();
	}
	return $password_hashed_db;
}

// The password comes in plaintext here. This is no problem though, because it was transmitted by HTTPS POST, which is encrypted.
function validUser(&$mysqli,&$username,&$password){

	$userValid = 0;
	$password_hashed_db = getPasswordHashedFromDb($mysqli, $username);

	if($password_hashed_db == "")
		return false;

	$result = password_verify($password, $password_hashed_db);
	return $result;
	
}

function tutorialExists(&$mysqli, &$tutID) {

	$exists = 0;
	if ($stmt = $mysqli->prepare("SELECT Title FROM Tutorial WHERE TutID = ?")) {

		/* bind parameters for markers */
		$stmt->bind_param("i", $tutID);

		/* execute query */
		$stmt->execute();

		/* bind result variables */
		$stmt->bind_result($exists);
		
		$stmt->fetch();
		
		/* close statement */
		$stmt->close();
	}
	
	if($exists){
		return true;
	}
	
	return false;
}

function userOwnsTutorial(&$mysqli, &$username, &$tutID) {

	$exists = 0;
	if ($stmt = $mysqli->prepare("SELECT TutID FROM Tutorial WHERE Author = ? AND TutID = ?")) {

		/* bind parameters for markers */
		$stmt->bind_param("si", $username, $tutID);

		/* execute query */
		$stmt->execute();

		/* bind result variables */
		$stmt->bind_result($exists);
		
		$stmt->fetch();
		
		/* close statement */
		$stmt->close();
	}
	
	if($exists){
		return true;
	}
	
	return false;
}

?>
