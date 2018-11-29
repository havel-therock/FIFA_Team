<?php
    session_start();
	
	if(!isset($_SESSION['logged'])) {
		header('Location: https://mateuszbank.pl/index.php');
		exit();
    }
    
    require_once "config.php";
    include_once "cleaner_session.php";

    $polaczenie = @new mysqli($host, $db_user, $db_password, $db_name);	

    if($polaczenie->connect_errno!=0) {
        header('Location: https://mateuszbank.pl/logout.php');
        exit();
    }
    else {
        $num_konta = $_SESSION['num_konta'];
        $result = $polaczenie->query(sprintf("SELECT stan_konta FROM uzytkownicy WHERE numer_konta = '%s'", 
        mysqli_real_escape_string($polaczenie, $num_konta)));
        $result = $result->fetch_assoc();
        $_SESSION['stan_konta'] = $result['stan_konta'];
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

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="scripts/activeNumber.js"></script>

    <title>mateuszBank - zalogowany</title>
    <style>
        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        td, th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        tr:nth-child(even) {
            background-color: #dddddd;
        }
    </style>
</head>
<body>
Witamy w banku, biednym banku.
<a href="https://mateuszbank.pl/formPay.php"><button>Utwórz przelew</button></a>
<a href="https://mateuszbank.pl/historiaPrzelewow.php"><button>Sprawdź historię przelewów</button></a>
<a href="https://mateuszbank.pl/logout.php"><button>Wyloguj</button></a>
<br />
<br />
<table>
    <tr>
        <th>Imie</th>
        <th>Nazwisko</th>
        <th>Numer konta</th>
        <th>Stan konta</th>
    </tr>
    <tr>
        <td><?php echo $_SESSION['imie'] ?></td>
        <td><?php echo $_SESSION['nazwisko'] ?></td>
        <td><?php echo $_SESSION['num_konta'] ?></td>
        <td><?php echo $_SESSION['stan_konta'] ?> PLN</td>
    </tr>
</table>
<br />
<?php 

    if(isset($_SESSION['error_hist'])) {
        echo '<p style="color: red;">'.$_SESSION['error_hist'].'</p>';
        unset($_SESSION['error_hist']);
    }

?>

</body>
</html>