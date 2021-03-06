<?php

/*
	Receives: Nothing
	Returns: New access token for video upload

	Remark: This is not secure. However, it seems to be the only method to let the user upload videos to our account without compromising usability.
*/

header('Content-type: application/json');

function getRefreshToken(&$mysqli) {
	$refresh_token = "";
	if ($stmt = $mysqli->prepare("SELECT token FROM Token WHERE ID = ?")) {

		/* bind parameters for markers */
		$id = 1;
		$stmt->bind_param("i", $id);

		/* execute query */
		$stmt->execute();

		/* bind result variables */
		$stmt->bind_result($refresh_token);
		
		$stmt->fetch();
		
		/* close statement */
		$stmt->close();
	}
	return $refresh_token;
}

/* Load config file for connection */
$config = parse_ini_file("junk/config.ini");

$mysqli = new mysqli('localhost', $config['db_user'], $config['db_password'], $config['db_name']);
mysqli_query($mysqli, "SET NAMES 'utf8'");

/* check connection */
if (mysqli_connect_errno()) {
	error_log("Connect failed: " . mysqli_connect_error());
	echo '{"success":0,"error_message":"' . mysqli_connect_error() . '"}';
} else {

	$refresh_token = getRefreshToken($mysqli);

	$client_id = "234918812842-5jlqchqd5oc53tvq4s3l754ah1vhvglc.apps.googleusercontent.com";
	$client_secret = "ElQiVGifufIdwIBF5T609ZVN";

	$url = 'https://accounts.google.com/o/oauth2/token';
	$data = array('client_secret' => $client_secret,
		'grant_type' => 'refresh_token',
		'refresh_token' => $refresh_token,
		'client_id' => $client_id);

	$options = array(
	    'http' => array(
	        'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
	        'method'  => 'POST',
	        'content' => http_build_query($data)
	    )
	);

	$context  = stream_context_create($options);
	$result = file_get_contents($url, false, $context);
	if ($result === FALSE) {
		echo "Error";
	}
	else {
		$json_decoded = json_decode($result, true);
		$access_token = $json_decoded['access_token'];
		echo $access_token;
	}
		
	$mysqli->close();
	
}

?>