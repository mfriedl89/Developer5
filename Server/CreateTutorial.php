<?php


/* to do
1) [*] 	check if valid input for insert
2) check if valid user 
4) [*] 	insert
5) [*] 	return something?

*/

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

			$mysqli = new mysqli('sql04.sprit.org', $config['db_user'], $config['db_password'], $config['db_name']);
			mysqli_query($mysqli, "SET NAMES 'utf8'");
			
			/* check connection */
			if (mysqli_connect_errno()) {
				error_log("Connect failed: " . mysqli_connect_error());
				echo '{"success":0,"error_message":"' . mysqli_connect_error() . '"}';
			} else {
				
				$insertSuccessful = 0;
				if(checkIfValidUser($username, $password) && checkIfValidTutorialInformation($TutCategory, $TutDifficulty, $TutDuration)){
					$insertSuccessful = insertTutorial($mysqli,$TutTitle, $TutCategory, $TutDifficulty, $TutDuration, $TutText);
				}
				

				$mysqli->close();
					
				if ($insertSuccessful) {
					/*error_log("Inserted requsted stations!");
					
					return success!
					*/
					echo "success";
			
				} else {
					error_log("Arguments do not match.");
					echo '{"success":-1,"error_message":"We are sorry - This Tutorial does already exist!"}';
				}
				
			}
	} else {
		echo '{"success":-1,"error_message":"Invalid Arguments."}';
	}
}else {
	echo '{"success":-1,"error_message":"Invalid Data."}';
}





function checkIfValidUser(&$username,&$password){
	
	return true;
}

function checkIfValidTutorialInformation(&$TutCategory, &$TutDifficulty, &$TutDuration){
	if($TutCategory > 0 && $TutCategory < 20 &&
		$TutDifficulty > 0 && $TutDifficulty < 6 &&
		$TutDuration > 0 && $TutDuration < 2880){
		return true;
	}
	
	return false;
}

function insertTutorial(&$mysqli,&$TutTitle, &$TutCategory, &$TutDifficulty, &$TutDuration, &$TutText){

	if ($stmt = $mysqli->prepare("INSERT INTO Tutorial( Title, Category, Difficulty,Duration,Text) VALUES (?,?,?,?,?)")) {

		/* bind parameters for query (security) */
		$stmt->bind_param("sssss", $TutTitle ,$TutCategory,$TutDifficulty,$TutDuration,$TutText);

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
