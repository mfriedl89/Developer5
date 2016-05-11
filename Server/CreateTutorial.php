<?php


/* to do
1) [*] 	check if valid input for insert
2) check if valid user 
4) [*] 	insert
5) [*] 	return something?

*/

// Include utils
require 'utils.php';

header('Content-type: application/json');


if($_POST) {
	$username 		= $_POST['username'];
	$password 		= $_POST['password']; // is a string of stop names seperated by ';'
	$TutTitle 		= $_POST['title'];
	$TutCategory 	= $_POST['category'];
	$TutDifficulty 	= $_POST['difficulty'];
	$TutDuration 	= $_POST['duration'];
	$TutText 		= $_POST['text'];
	
	if($username && $password &&
		$TutTitle && $TutCategory &&
		$TutDifficulty && $TutDuration &&
		$TutText) {

			/* Load config file for connection */
			$config = parse_ini_file("junk/config.ini");

			$mysqli = new mysqli('localhost', $config['db_user'], $config['db_password'], $config['db_name']);
			mysqli_query($mysqli, "SET NAMES 'utf8'");
			
			/* check connection */
			if (mysqli_connect_errno()) {
				error_log("Connect failed: " . mysqli_connect_error());
				echo '{"success":0,"error_message":"' . mysqli_connect_error() . '"}';
			} else {
				
				$insertSuccessful = 0;
				if(validUser($mysqli,$username, $password)) { 
					if(validTutorialInformation($TutCategory, $TutDifficulty, $TutDuration)){
						
						$insertSuccessful = insertTutorial($mysqli,$TutTitle, $TutCategory, $TutDifficulty, $TutDuration, $TutText, $username);
						
						if ($insertSuccessful) {
					
							echo "success";
						} else {
							
							echo 'Tutorial could not be saved!';
						}
					
					}else{	echo "Tutorial Info not valid!";	}
				}else{	echo "User not logged in!";	}
				

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

function insertTutorial(&$mysqli,&$TutTitle, &$TutCategory, &$TutDifficulty, &$TutDuration, &$TutText, &$username){

	$tut_id = 0;

	if ($stmt = $mysqli->prepare("INSERT INTO Tutorial(Title, Category, Difficulty, Duration, Text, Author) VALUES (?,?,?,?,?,?)")) {

		/* bind parameters for query (security) */
		$stmt->bind_param("ssssss", $TutTitle ,$TutCategory,$TutDifficulty,$TutDuration,$TutText,$username);

		/* execute query */
		$stmt->execute();
	
		/* get id of inserted object */
		$tut_id = $stmt->insert_id;

		/* close statement */
		$stmt->close();
	}
	
	return $tut_id;
}

?>
