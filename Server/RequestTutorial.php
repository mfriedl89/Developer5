<?php

/*	Receives: tutorialID */
/*  Returns Array: {[Title,Category,Difficulty,Duration,Text]} */

header('Content-type: application/json');


if($_POST) {
	$tutorialID   = $_POST['tutorialID'];

	if($tutorialID) {
	
			/* Load config file for connection */
			$config = parse_ini_file("junk/config.ini");


			$mysqli = new mysqli('localhost', $config['db_user'], $config['db_password'], $config['db_name']);

			/* check connection */
			if (mysqli_connect_errno()) {
				error_log("Connect failed: " . mysqli_connect_error());
				echo '{"success":0,"error_message":"' . mysqli_connect_error() . '"}';
			} else {			
				
				if ($stmt = $mysqli->prepare("SELECT Title,Category,Difficulty,Duration,Text,Author FROM Tutorial WHERE TutID = ?")) {
				
					$stmt->bind_param("s",$tutorialID);

					/* execute query */
					$stmt->execute();

					/* bind result variables */
					$stmt->bind_result($tTitle,$tCat,$tDif,$tDur,$tText,$tAuthor);
					
					$foundTutorials = array();
					
					/* fetch values */
					while ( $stmt->fetch() ){
						$foundTutorials[] = utf8_encode($tTitle);
						$foundTutorials[] = $tCat;
						$foundTutorials[] = $tDif;
						$foundTutorials[] = $tDur;
						$foundTutorials[] = utf8_encode($tText);
						$foundTutorials[] = utf8_encode($tAuthor);
					}

					/* close statement */
					$stmt->close();
				}
	
				/* close connection */
				$mysqli->close();
				
				$json_encoded_output = json_encode($foundTutorials);
				echo $json_encoded_output;
				
				
			}
	} else {
		
		echo '{"success":-1,"error_message":"Invalid Arguments."}';
	}

}else {
	
	echo '{"success":-1,"error_message":"Invalid Data."}';
}

?>
