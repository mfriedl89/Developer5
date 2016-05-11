<?php


/* to do
1) [*] check if user is valid
2) [*] delete tutorial with the given name

*/

// Include utils
require 'utils.php';

header('Content-type: application/json');


if($_POST) {
	$username 		= $_POST['username'];
	$password 		= $_POST['password']; // is a string of stop names seperated by ';'
	$TutID 		= $_POST['tutid'];
	
	if($username && $password && $TutTitle) {

			/* Load config file for connection */
			$config = parse_ini_file("junk/config.ini");

			$mysqli = new mysqli('localhost', $config['db_user'], $config['db_password'], $config['db_name']);
			mysqli_query($mysqli, "SET NAMES 'utf8'");
			
			/* check connection */
			if (mysqli_connect_errno()) {
				error_log("Connect failed: " . mysqli_connect_error());
				echo '{"success":0,"error_message":"' . mysqli_connect_error() . '"}';
			} else {
				
				$deleteSuccessful = 0;
				if(validUser($mysqli,$username, $password) && userOwnsTutorial($mysqli, $username, $TutID)) {
						
					$deleteSuccessful = deleteTutorial($mysqli, $TutID);
					
					if ($deleteSuccessful) {
				
						echo "success";
					} else {
						
						echo 'Tutorial could not be deleted!';
					}

				} else {	echo "User not logged in!";	}
				

				$mysqli->close();
					
				
				
			}
	} else {
		echo '{"success":-1,"error_message":"Invalid arguments."}';
	}
}else {
	echo '{"success":-1,"error_message":"Invalid data."}';
}

function deleteTutorial(&$mysqli, &$TutID){

	if ($stmt = $mysqli->prepare("DELETE FROM Tutorial WHERE TutID = ?")) {

		/* bind parameters for query (security) */
		$stmt->bind_param("i", $TutID);

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
