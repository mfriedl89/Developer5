<?php

// Contains various tests for the PHP functions

require_once 'utils.php';
require_once 'CreateTutorial.php';
require_once 'EditTutorial.php';
require_once 'DeleteTutorial.php';
require_once 'CreateUser.php';
require_once 'ChangePassword.php';
require_once 'ChangeMail.php';
require_once 'ChangeName.php';

// Make sure to clear $_POST (even if it shouldn't be populated)
$_POST = array();

function testPasswordFromDb($mysqli) {
	if(!(getPasswordHashedFromDb($mysqli, "anton") != ""))
		return false;
	if(!(getPasswordHashedFromDb($mysqli, "anto1") == ""))
		return false;
	if(!(getPasswordHashedFromDb($mysqli, "antom") == ""))
		return false;

	return true;
}

function testValidUser($mysqli) {
	if(!(validUser($mysqli, "anton", "Test1234@") == true))
		return false;
	if(!(validUser($mysqli, "anto1", "Test1234@") == false))
		return false;
	if(!(validUser($mysqli, "anton", "Test1235@") == false))
		return false;

	return true;
}

function testTutorials($mysqli) {
	// Create
	$new_tut_id = insertTutorial($mysqli, "TestTitleFirstLast", "1", "1", "1", "This is the tutorial content.", "anton");
	if(!($new_tut_id > 0))
		return false;

	// User owns tutorial
	if(!(userOwnsTutorial($mysqli, "anton", 0) == false))
		return false;
	if(!(userOwnsTutorial($mysqli, "anton", $new_tut_id) == true))
		return false;

	// Edit
	if(!(editTutorial($mysqli, 0, "TestTitleFirstLastNew", "1", "1", "1", "This is the new tutorial content") == false))
		return false;
	if(!(editTutorial($mysqli, $new_tut_id, "TestTitleFirstLastNew", "1", "1", "1", "This is the new tutorial content") == true))
		return false;

	// Delete
	if(!(deleteTutorial($mysqli, 0) == false))
		return false;
	if(!(deleteTutorial($mysqli, $new_tut_id) == true))
		return false;

	return true;
}

function testUsers($mysqli) {
	// Change password
	if(!(changePassword($mysqli, "anton", "falsepw", "Test1234@") == false))
		return false;
	if(!(changePassword($mysqli, "anton", "Test1234@", "Test1234@") == true))
		return false;

	// Change mail
	if(!(changeMail($mysqli, "anton", "falsepw", "newmail@mail.com") == false))
		return false;
	if(!(changeMail($mysqli, "anton", "Test1234@", "newmail@mail.com") == true))
		return false;

	// Change name
	if(!(changeName($mysqli, "anton", "falsepw", "NewFirstname", "NewLastname") == false))
		return false;
	if(!(changeName($mysqli, "anton", "Test1234@", "NewFirstname", "NewLastname") == true))
		return false;

	return true;
}

function echoWithNewline($message) {
	echo $message . "<br/>";
}

/* Load config file for connection */
$config = parse_ini_file("junk/config.ini");

$mysqli = new mysqli('localhost', $config['db_user'], $config['db_password'], $config['db_name']);
mysqli_query($mysqli, "SET NAMES 'utf8'");

/* check connection */
if (mysqli_connect_errno()) {
	error_log("Connect failed: " . mysqli_connect_error());
	echo '{"success":0,"error_message":"' . mysqli_connect_error() . '"}';
} else {
	
	// Begin testing
	echoWithNewline("Tests started");

	// Password from DB
	if(testPasswordFromDb($mysqli) == true)
		echoWithNewline("Password from DB tests successful");
	else
		echoWithNewline("Password from DB tests failed");

	// Valid user
	if(testValidUser($mysqli) == true)
		echoWithNewline("Valid user tests successful");
	else
		echoWithNewline("Valid user tests failed");

	// Tutorials
	if(testTutorials($mysqli) == true)
		echoWithNewline("Tutorial administration tests successful");
	else
		echoWithNewline("Tutorial administration tests failed");

	// Users
	if(testUsers($mysqli) == true)
		echoWithNewline("User administration tests successful");
	else
		echoWithNewline("User administration tests failed");

	// Finish testing
	echoWithNewline("Tests finished");

}

?>
