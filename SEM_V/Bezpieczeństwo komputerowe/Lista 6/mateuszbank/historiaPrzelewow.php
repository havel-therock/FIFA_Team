<?php

    session_start();

    if(!isset($_SESSION['logged'])) {
        header('Location: https://mateuszbank.pl/index.php');
        exit();
    }

    if(!isset($_SESSION['ID'])) {
        header('Location: https://mateuszbank.pl/index.php');
        exit();
    }

    require_once "config.php";
	
	$polaczenie = @new mysqli($host, $db_user, $db_password, $db_name);				// @ - wycisza błędy, czyli nie wyrzuca info o errorze
	
	if($polaczenie->connect_errno!=0) {
        echo "ERROR ".$polaczenie->connect_errno." Opis: ".$polaczenie->connect_error;
        header('Location: https://mateuszbank.pl/index.php');
		exit();
    }
    else {
        // OK
        if($result = $polaczenie->query(sprintf("SELECT * FROM przelewy WHERE id_nad='%s' ORDER BY ID DESC LIMIT 20",
		mysqli_real_escape_string($polaczenie, $_SESSION['ID'])))) {
            // silence is golden
        }
        else {
            $_SESSION['error_hist'] = 'Nie można połączyć się z serwisem. Proszę spróbować później lub skontaktować się z obsługą.';
            header('Location: https://mateuszbank.pl/home.php');
            exit();
        }
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
    <script type="text/javascript" src="scripts/changerHist.js"></script>

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
    <img class="header-left" src="images/gold-piggy.jpg"
         width="107" height="40" alt="Link do gł&#243;wnej strony mateuszBank">

<a href="https://mateuszbank.pl/home.php"><button>Powróć</button></a>
<a href="https://mateuszbank.pl/logout.php"><button>Wyloguj</button></a>
<br />
<br />
<table>
    <tr style="float: right;">
        <td><?php echo $_SESSION['imie'] ?></td>
        <td><?php echo $_SESSION['nazwisko'] ?></td>
        <td>Numer konta</td>
        <td><?php echo $_SESSION['num_konta'] ?></td>
        <td>Stan konta</td>
        <td><?php echo $_SESSION['stan_konta'] ?></td>
        <td>PLN</td>
    </tr>
</table>
<br />
<br />
<table>
    <tr>
        <th>Data</th>
        <th>Nazwa odbiorcy</th>
        <th>Numer konta odbiorcy</th>
        <th>Tytuł</th>
        <th>Kwota</th>
        <th>Status</th>
    </tr>
    <?php

        while($row = mysqli_fetch_array($result)) {
            echo '<tr>';
            echo '<td>'.$row['data'].'</td>';
            echo '<td>'.$row['nazwa_odb'].'</td>';
            echo '<td>'.$row['num_konta_odb'].'</td>';
            echo '<td>'.$row['tytul'].'</td>';
            echo '<td>'.$row['kwota'].' PLN</td>';
            echo '<td>';
            switch($row['status']) {
                case '0': echo "Oczekiwanie";
                    break;
                case '1': echo "Zatwierdzony";
                    break;
                case '2': echo "Niezatwierdzony";
                    break;
                default: echo "Błąd przelewu";
                    break;
            }
            echo '</td>';
            echo '</tr>';
        }

    ?>
</table>

</body>
</html>