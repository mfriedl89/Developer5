<?php

ini_set('display_errors', 'On');
error_reporting(E_ALL);

// Contains various tests for the PHP functions

// Make sure to clear $_POST (even if it shouldn't be populated)
$_POST = array();

require_once 'utils.php';
require_once 'CreateTutorial.php';
require_once 'EditTutorial.php';
require_once 'DeleteTutorial.php';
require_once 'CreateUser.php';
require_once 'ChangePassword.php';
require_once 'ChangeMail.php';
require_once 'ChangeName.php';

function echoWithNewline($message) {
	echo $message . "<br>";
}

function testPasswordFromDb($mysqli) {
	$username = "anton";
	$username_false = "anto1";
	if(!(getPasswordHashedFromDb($mysqli, $username) != ""))
		return false;
	if(!(getPasswordHashedFromDb($mysqli, $username_false) == ""))
		return false;

	return true;
}

function testValidUser($mysqli) {
	$username = "anton";
	$username_false = "anto1";
	$password = "Test1234@";
	$password_false = "falsepw";
	if(!(validUser($mysqli, $username, $password) == true))
		return false;
	if(!(validUser($mysqli, $username_false, $password) == false))
		return false;
	if(!(validUser($mysqli, $username, $password_false) == false))
		return false;

	return true;
}

function testTutorials($mysqli) {
	// Create
	$tut_name = "TestTitleFirstLast";
	$tut_category = "1";
	$tut_difficulty = "1";
	$tut_duration = "1";
	$tut_text = "This is the tutorial content";
	$tut_username = "anton";
	$new_tut_id = insertTutorial($mysqli, $tut_name, $tut_category, $tut_difficulty, $tut_duration, $tut_text, $tut_username);
	if(!($new_tut_id > 0)) {
		echoWithNewline("New tutorial ID should be >0");
		return false;
	}

	$new_tut_id_false = 0;

	// User owns tutorial
	if(!(userOwnsTutorial($mysqli, $tut_username, $new_tut_id_false) == false)) {
		echoWithNewline("User " . $tut_username . " should not own tutorial with ID " . $new_tut_id_false);
		return false;
	}
	if(!(userOwnsTutorial($mysqli, $tut_username, $new_tut_id) == true)) {
		echoWithNewline("User " . $tut_username . " should own tutorial with ID " . $new_tut_id);
		return false;
	}

	$tut_name_new = "TestTitleFirstLastNew";
	$tut_text_new = "This is the new tutorial content";

	// Edit
	if(!(editTutorial($mysqli, $new_tut_id_false, $tut_name_new, $tut_category, $tut_difficulty, $tut_duration, $tut_text_new) == false)) {
		echoWithNewline("It should not be possible to edit tutorial with ID " . $new_tut_id_false);
		return false;
	}
	if(!(editTutorial($mysqli, $new_tut_id, $tut_name_new, $tut_category, $tut_difficulty, $tut_duration, $tut_text_new) == true)) {
		echoWithNewline("It should be possible to edit tutorial with ID " . $new_tut_id);
		return false;
	}

	// Delete
	if(!(deleteTutorial($mysqli, $new_tut_id_false) == false)) {
		echoWithNewline("It should not be possible to delete tutorial with ID " . $new_tut_id_false);
		return false;
	}
	if(!(deleteTutorial($mysqli, $new_tut_id) == true)) {
		echoWithNewline("It should be possible to delete tutorial with ID " . $new_tut_id);
		return false;
	}

	return true;
}

function testUsers($mysqli) {
	$username = "anton";
	$password = "Test1234@";
	$password_false = "falsepw";

	// Change password
	if(!(changePassword($mysqli, $username, $password, $password) == false)) {
		echoWithNewline("It should not be possible to change password providing a false old password");
		return false;
	}
	if(!(changePassword($mysqli, $username, $password, $password_false) == true)) {
		echoWithNewline("It should be possible to change password providing a correct old password");
		return false;
	}

	$mail_new = "newmail@mail.com";

	// Change mail
	if(!(changeMail($mysqli, $username, $password_false, $mail_new) == false)) {
		echoWithNewline("It should not be possible to change mail providing a false old password");
		return false;
	}
	if(!(changeMail($mysqli, $username, $password, $mail_new) == true)) {
		echoWithNewline("It should be possible to change mail providing a correct old password");
		return false;
	}

	$firstname_new = "NewFirstname";
	$surname_new = "NewSurname";

	// Change name
	if(!(changeName($mysqli, $username, $password_false, $firstname_new, $surname_new) == false)) {
		echoWithNewline("It should not be possible to change names providing a false old password");
		return false;
	}
	if(!(changeName($mysqli, $username, $password, $firstname_new, $surname_new) == true)) {
		echoWithNewline("It should be possible to change names providing a correct old password");
		return false;
	}

	return true;
}

echoWithNewline("Loading MySQL config file");

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
