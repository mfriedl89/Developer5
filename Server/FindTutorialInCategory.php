<?php
/*	Reveives: title, category */
/*  Returns Array: {[TutID,Title,Category,Difficulty,Duration]} */

header('Content-type: application/json');


if($_POST) {
	$title   	= $_POST['title'];
	$category   = $_POST['category'];

	if(1) {

			/* Load config file for connection */
			$config = parse_ini_file("junk/config.ini");


			$mysqli = new mysqli('localhost', $config['db_user'], $config['db_password'], $config['db_name']);


			/* check connection */
			if (mysqli_connect_errno()) {
				error_log("Connect failed: " . mysqli_connect_error());
				echo '{"success":0,"error_message":"' . mysqli_connect_error() . '"}';
			} else {
      if($title){
      $query = 	"SELECT TutID,Title,Category,Difficulty,Duration,Author FROM Tutorial WHERE Title LIKE ?";
      if ($category) {
        $query .= " AND Category = ".$category;
      }
      }else
      {
      	$query = 	"SELECT TutID,Title,Category,Difficulty,Duration,Author FROM Tutorial";
      	if ($category) {
       		 $query .= " WHERE Category = ".$category;
    	  }
      }
      

      $title = "%$title%";

				if ($stmt = $mysqli->prepare($query)) {

					$stmt->bind_param("s",$title);

					/* execute query */
					$stmt->execute();

					/* bind result variables */
					$stmt->bind_result($tID,$tTitle,$tCat,$tDif,$tDur,$tAuthor);

					$foundTutorials = array();

					/* fetch values */
					while ( $stmt->fetch() ){

          $foundTutorials[] = array('id' => $tID,
                                    'title' => $tTitle,
                                    'category' => $tCat,
                                    'difficulty' => $tDif,
                                    'duration' => $tDur,
                                    'author' => $tAuthor);

						/*$foundTutorials[] = $tID;
						$foundTutorials[] = $tTitle;
						$foundTutorials[] = $tCat;
						$foundTutorials[] = $tDif;
						$foundTutorials[] = $tDur;*/
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

		//echo '{"success":-1,"error_message":"Invalid Arguments."}';
		echo "Invalid Arguments.";
	}

}else {

	//echo '{"success":-1,"error_message":"Invalid Data."}';
	echo "Invalid Data.";
}

?>
