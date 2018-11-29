<?php
    session_start();
    
    if(!isset($_SESSION['logged'])) {
        header('Location: https://mateuszbank.pl/index.php');
        exit();
    }
	
	if(!isset($_SESSION['przelew'])) {
		header('Location: https://mateuszbank.pl/home.php');
		exit();
	}
	elseif($_SESSION['przelew'] == true) {
		unset($_SESSION['przelew']);
    }
    else {
        unset($_SESSION['przelew']);
        header('Location: https://mateuszbank.pl/home.php');
		exit();
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

	<h1><?php echo $_SESSION['message_przelew']; ?></h1><br/>
	
	<p><a href="https://mateuszbank.pl/home.php"><img class="header-left" src="images/gold-piggy.jpg"
         width="107" height="40" alt="Link do gł&#243;wnej strony mateuszBank"><br/>Przejdź do swojego konta</a></p>

</body>
</html>