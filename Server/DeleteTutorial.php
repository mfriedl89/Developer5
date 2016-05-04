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
	$TutTitle 		= $_POST['title'];
	
	if($username && $password && $TutTitle {

			/* Load config file for connection */
			$config = parse_ini_file("junk/config.ini");

			$mysqli = new mysqli('sql04.sprit.org', $config['db_user'], $config['db_password'], $config['db_name']);
			mysqli_query($mysqli, "SET NAMES 'utf8'");
			
			/* check connection */
			if (mysqli_connect_errno()) {
				error_log("Connect failed: " . mysqli_connect_error());
				echo '{"success":0,"error_message":"' . mysqli_connect_error() . '"}';
			} else {
				
				$deleteSuccessful = 0;
				if(validUser($mysqli,$username, $password)) {
						
					$deleteSuccessful = deleteTutorial($mysqli, $TutTitle);
					
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

function deleteTutorial(&$mysqli, &$TutTitle){

	if ($stmt = $mysqli->prepare("DELETE FROM Tutorial WHERE Title='?'")) {

		/* bind parameters for query (security) */
		$stmt->bind_param("s", $TutTitle);

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
