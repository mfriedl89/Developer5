<?php


/* to do
1) check if valid input for edit
2) check if valid user 
4) edit

*/

// Include utils
require 'utils.php';

header('Content-type: application/json');


if($_POST) {
	$username 		= $_POST['username'];
	$password 		= $_POST['password']; // is a string of stop names seperated by ';'
	$TutOldTitle	= $_POST['oldtitle'];
	$TutNewTitle 	= $_POST['newtitle'];
	$TutCategory 	= $_POST['category'];
	$TutDifficulty 	= $_POST['difficulty'];
	$TutDuration 	= $_POST['duration'];
	$TutText 		= $_POST['text'];
	
	if($username && $password &&
		$TutOldTitle && $TutNewTitle &&
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
				if(validUser($mysqli,$username, $password) && userOwnsTutorial($mysqli, $username, $TutOldTitle)) { 
					if(validTutorialInformation($TutCategory, $TutDifficulty, $TutDuration)){
						
						$editSuccessful = editTutorial($mysqli, $TutOldTitle, $TutNewTitle, $TutCategory, $TutDifficulty, $TutDuration, $TutText);
						
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


function validTutorialInformation(&$TutCategory, &$TutDifficulty, &$TutDuration){
	if($TutCategory > 0 && $TutCategory < 20 &&
		$TutDifficulty > 0 && $TutDifficulty < 6 &&
		$TutDuration > 0 && $TutDuration < 2880){
		return true;
	}
	
	return false;
}

function editTutorial(&$mysqli, &$TutOldTitle, &$TutNewTitle, &$TutCategory, &$TutDifficulty, &$TutDuration, &$TutText){

	// Check if such a tutorial exists
	if(tutorialExists($TutOldTitle) == false) {
		return false;
	}

	if ($stmt = $mysqli->prepare("UPDATE Tutorial SET Title = ?, Category = ?, Difficulty = ?, Duration = ?, Text = ? WHERE Title = ?")) {

		/* bind parameters for query (security) */
		$stmt->bind_param("ssssss", $TutNewTitle ,$TutCategory,$TutDifficulty,$TutDuration,$TutText,$TutOldTitle);

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
