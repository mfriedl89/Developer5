<?php


/* to do
1) check if valid input for edit
2) check if valid user 
4) edit

*/

// Include utils
require_once 'utils.php';

header('Content-type: application/json');


if($_POST) {
	$username 		= $_POST['username'];
	$password 		= $_POST['password']; // is a string of stop names seperated by ';'
	$TutID			= $_POST['tutid'];
	$TutNewTitle 	= $_POST['newtitle'];
	$TutCategory 	= $_POST['category'];
	$TutDifficulty 	= $_POST['difficulty'];
	$TutDuration 	= $_POST['duration'];
	$TutText 		= $_POST['text'];
	
	if($username && $password &&
		$TutID && $TutNewTitle &&
		$TutCategory && $TutDifficulty &&
		$TutDuration && $TutText) {

			/* Load config file for connection */
			$config = parse_ini_file("junk/config.ini");

			$mysqli = new mysqli('localhost', $config['db_user'], $config['db_password'], $config['db_name']);
			mysqli_query($mysqli, "SET NAMES 'utf8'");
			
			/* check connection */
			if (mysqli_connect_errno()) {
				error_log("Connect failed: " . mysqli_connect_error());
				echo '{"success":0,"error_message":"' . mysqli_connect_error() . '"}';
			} else {
				
				$editSuccessful = 0;
				
				if(validUser($mysqli,$username, $password) && userOwnsTutorial($mysqli, $username, $TutID)) {
					if(validTutorialInformation($TutCategory, $TutDifficulty, $TutDuration)) {

						$editSuccessful = editTutorial($mysqli, $TutID, $TutNewTitle, $TutCategory, $TutDifficulty, $TutDuration, $TutText);
						
						if ($editSuccessful) {
					
							echo "success";
						} else {
							
							echo 'Tutorial could not be edited!';
						}
					
					}else{	echo "Tutorial Info not valid!";	}
				}else{	echo "User not logged in or not owner of tutorial!";	}
				

				$mysqli->close();
					
				
				
			}
	} else {
		echo '{"success":-1,"error_message":"Invalid Arguments."}';
	}
}else {
	echo '{"success":-1,"error_message":"Invalid Data."}';
}

function editTutorial(&$mysqli, &$TutID, &$TutNewTitle, &$TutCategory, &$TutDifficulty, &$TutDuration, &$TutText){

	if(tutorialExists($mysqli, $TutID) == false) {
		return false;
	}

	if ($stmt = $mysqli->prepare("UPDATE Tutorial SET Title = ?, Category = ?, Difficulty = ?, Duration = ?, Text = ? WHERE TutID = ?")) {

		/* bind parameters for query (security) */
		$stmt->bind_param("sssssi", $TutNewTitle ,$TutCategory,$TutDifficulty,$TutDuration,$TutText,$TutID);

		/* execute query */
		$stmt->execute();

		/* close statement */
		$stmt->close();
	}
	else {
		return false;
	}
	
	return true;
}

?>
