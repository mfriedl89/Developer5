<?php

/*
	Receives: username, password, firstName, surName, email
	Returns: true, else(= Invalid Email, User could not be saved )

*/

header('Content-type: application/json');


if($_POST) {
	$username 		= $_POST['username'];
	$password 		= $_POST['password']; 
	$firstName 		= $_POST['firstName'];
	$surName 	= $_POST['surName'];
	$email 		= $_POST['email'];
	
	if($username && $password &&
		$firstName && $surName &&
		$email ) {

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
				if( !userAlreadyExists($mysqli,$username)){
					if( validUserInformation($username, $password, $firstName, $surName, $email)){
					
						$insertSuccessful = insertUser($mysqli,$username, $password, $firstName, $surName, $email);
					
						if ($insertSuccessful) {
							echo "true";
						} else {	echo "User could not be saved";	}
						
					}else{	echo "Invalid Email!";	}
					
				} else {	echo "User already exists!";	}
				$mysqli->close();
					
				
				
				
			}
	} else {
		echo '{"success":-1,"error_message":"Invalid Arguments."}';
	}
}else {
	echo '{"success":-1,"error_message":"Invalid Data."}';
}

function userAlreadyExists(&$mysqli, &$username){

	$userExists = 0;
	
	if ($stmt = $mysqli->prepare("SELECT UserID FROM USER WHERE Username = ?")) {

		/* bind parameters for markers */
		$stmt->bind_param("s", $username);

		/* execute query */
		$stmt->execute();

		/* bind result variables */
		$stmt->bind_result($userExists);
		
		$stmt->fetch();
		
		/* close statement */
		$stmt->close();
	}
	
	if($userExists){
		return true;
	}

	return false;
}

function validUserInformation(&$username, &$password, &$firstName, &$surName, &$email){

	if (!preg_match('/^[A-Z0-9._-]+@[A-Z0-9][A-Z0-9.-]{0,61}[A-Z0-9]\.[A-Z.]{2,6}$/i', $email)){ 
		return false;
	} 

	if (!function_exists('checkdnsrr'))
	{
		function checkdnsrr($host, $type)
		{
			@exec('nslookup -type=' . $type . ' ' . $host, $output);
			foreach($output as $line)
		
			if (preg_match('/^' . $host . '/i', $line)) return true;
			return false;
		}
	}


	$host = substr(strrchr($email, '@'), 1);
	if (checkdnsrr($host, 'MX') or checkdnsrr($host, 'A'))
	{
		return true;
	}
	else
	{
		return false; 
	}
	
	return false;
}

function insertUser(&$mysqli,&$username, &$password, &$firstName, &$surName, &$email){

	if ($stmt = $mysqli->prepare("INSERT INTO USER( Username, Password, FirstName, Surname, Email) VALUES (?,?,?,?,?)")) {

		// Build SHA512 value of password (bcrypt would be better, but this should be enough)
		$password_hashed =  hash('sha512', $password);

		/* bind parameters for query (security) */
		$stmt->bind_param("sssss", $username ,$password_hashed,$firstName,$surName,$email);

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
