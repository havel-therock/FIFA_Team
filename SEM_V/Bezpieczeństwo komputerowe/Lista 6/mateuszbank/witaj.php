<?php
	session_start();
	
	if(!isset($_SESSION['registered'])) {
		header('Location: https://mateuszbank.pl/index.php');
		exit();
	}
	else {
		unset($_SESSION['registered']);
	}
?>

<!DOCTYPE HTML>
<html lang="pl">
<head>
	<meta charset="utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrom=1"/>
	<title>mateuszBank wita nowego klienta</title>
	
	<style>
	
	body {
		text-align: center;
		background-color: #342323;
		color: white;
	}
	
	a {
		color: #993;
		text-decoration: none;
		text-decoration: underline;
	}
	
	a:hover {
		color: white;
	}
	
	
	</style>
</head>

<body>

	<h1>"Dziękujemy za rejestracje. Możesz już przejść do swojego konta. W najbliższym czasie przyjdzie e-mail z potwierdzeniem.</h1><br/>
	
	<p><a href="https://mateuszbank.pl/index.php"><img class="header-left" src="images/gold-piggy.jpg"
         width="107" height="40" alt="Link do gł&#243;wnej strony mateuszBank"><br/>Zaloguj się na swoje konto</a></p>

</body>
</html>