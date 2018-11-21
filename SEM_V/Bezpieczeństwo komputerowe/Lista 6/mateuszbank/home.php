<?php
    session_start();
	
	if(!isset($_SESSION['logged'])) {
		header('Location: index.php');
		exit();
	}
?>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="description" content="Logowanie do serwisu transakcyjnego MateuszBanku" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>mateuszBank - zalogowany</title>
</head>
<body>
Witamy w banku, biednym banku.
<button>Utwórz przelew</button>
<button>Sprawdź historię przelewów</button>
<a href="logout.php"><button>Wyloguj</button></a>

</body>
</html>