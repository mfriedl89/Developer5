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

function testPasswordFromDb($mysqli) {
	$username = "anton";
	if(!(getPasswordHashedFromDb($mysqli, $username) != ""))
		return false;
	if(!(getPasswordHashedFromDb($mysqli, $username) == ""))
		return false;
	if(!(getPasswordHashedFromDb($mysqli, $username) == ""))
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
	$tut_duration = "1";;
	$tut_text = "This is the tutorial content.";
	$tut_username = "anton";
	$new_tut_id = insertTutorial($mysqli, $tut_name, $tut_category, $tut_difficulty, $tut_duration, $tut_text, $tut_username);
	if(!($new_tut_id > 0))
		return false;

	$new_tut_id_false = 0;

	// User owns tutorial
	if(!(userOwnsTutorial($mysqli, $tut_username, $new_tut_id_false) == false))
		return false;
	if(!(userOwnsTutorial($mysqli, $tut_username, $new_tut_id) == true))
		return false;

	$tut_name_new = "TestTitleFirstLastNew";
	$tut_text_new = "This is the new tutorial content";

	// Edit
	if(!(editTutorial($mysqli, $new_tut_id_false, $tut_name_new, $tut_category, $tut_difficulty, $tut_duration, $tut_text_new) == false))
		return false;
	if(!(editTutorial($mysqli, $new_tut_id, $tut_name_new, $tut_category, $tut_difficulty, $tut_duration, $tut_text_new) == true))
		return false;

	// Delete
	if(!(deleteTutorial($mysqli, $new_tut_id_false) == false))
		return false;
	if(!(deleteTutorial($mysqli, $new_tut_id) == true))
		return false;

	return true;
}

function testUsers($mysqli) {
	$username = "anton";
	$password = "Test1234@";
	$password_false = "falsepw";

	// Change password
	if(!(changePassword($mysqli, $username, $password_false, $password) == false))
		return false;
	if(!(changePassword($mysqli, $username, $password, $password) == true))
		return false;

	$mail_new = "newmail@mail.com";

	// Change mail
	if(!(changeMail($mysqli, $username, $password_false, $mail_new) == false))
		return false;
	if(!(changeMail($mysqli, $username, $password, $mail_new) == true))
		return false;

	$firstname_new = "NewFirstname";
	$surname_new = "NewSurname";

	// Change name
	if(!(changeName($mysqli, $username, $password_false, $firstname_new, $surname_new) == false))
		return false;
	if(!(changeName($mysqli, $username, $password, $firstname_new, $surname_new) == true))
		return false;

	return true;
}

function echoWithNewline($message) {
	echo $message . "<br/>";
}

echo "Loading MySQL config file";

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
	echo "Tests started";

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
