<?php
	session_start();
	
	// if(isset($_SESSION['logged']) && $_SESSION['logged'] == true) {
	// 	header('Location: home.php');
	// 	exit();
    // }
?> 
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="description" content="Logowanie do serwisu transakcyjnego MateuszBanku" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="Stylesheet" type="text/css" href="https://online.mbank.pl/LoginMain/Resources/par_axd/LoginMain?file=ResponsiveLogin%2FStyles%2FResponsiveLogin.css&amp;v=8d58f9019156b5f11993430100b318d2" />
    <title>mBank serwis transakcyjny</title>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <style>
        .inputs {
            padding-bottom: 10px;
        }

        .error {
		    color: red;
		    margin-bottom: 5px;
        }
    </style>
    <script src="scripts/validRejestr.js"></script>
</head>
<body>
<a href="index.php">
    <img class="header-left" src="images/gold-piggy.jpg"
         width="107" height="40" alt="Link do gł&#243;wnej strony mateuszBank">
</a>
<br/><br/>
<h1>Rejestracja</h1>
<br/>
<form name="signForm" method="post" style="margin-left:20px;">
    <div class="inputs">
        Identyfikator / Login <br/>
        <input name="login" id="login" minlength="5" type="text" required autocomplete="off"/> <br/>
    </div>
    <div class="inputs">
        Imie <br/>
        <input type="text" name="imie" id="imie" required pattern="[a-zA-Z]*" autocomplete="off" title="Nie mogą występować cyfry, ani znaki specjalne"/> <br/>
    </div>
    <div class="inputs">
        Nazwisko <br/>
        <input type="text" name="nazwisko" required pattern="[a-zA-Z]*" title="Nie mogą występować cyfry, ani znaki specjalne" autocomplete="off"/> <br/>
    </div>
    <div class="inputs">
        Mail <br/>
        <input type="email" name="mail" required autocomplete="off"/> <br/>
    </div>
    <div class="inputs">
        Hasło <br/>
        <input type="password" minlength="8" id="haslo" name="haslo" required autocomplete="off"/> <br/>
    </div>
    <div class="inputs">
        Powtórz hasło <br/>
        <input type="password" minlength="8" id="hasloPowtorz" name="hasloPowtorz" required autocomplete="off"/> <br/>
    </div>
    <div class="inputs">
        <input type="checkbox" name="regulamin" required/>
        Akceptuje regulamin
    </div>
    <div class="inputs">
        <br/>
        <input type="submit" value="Utwórz konto" /> <br/>
    </div>
    <div class="inputs">
        <br/>
        <?php
            if(isset($_SESSION['error_server'])) {
                echo '<div class="error">'.$_SESSION['error_server'].'</div>';
                unset($_SESSION['error_server']);
            }

            if(isset($_SESSION['error_email'])) {
                echo '<div class="error">'.$_SESSION['error_email'].'</div>';
                unset($_SESSION['error_email']);
            }

            if(isset($_SESSION['error_login'])) {
                echo '<div class="error">'.$_SESSION['error_login'].'</div>';
                unset($_SESSION['error_login']);
            }
        ?>
    </div>
</form>
</body>
</html>

<?php
    $validation = true;

    if(isset($_POST['mail'])) {
        require_once "config.php";
        try{
            $connect_database = new mysqli($host, $db_user, $db_password, $db_name);
			if($connect_database->connect_errno != 0) {
				throw new Exception(mysqli_connect_errno()); 
			}
			else {
                // vars from POST
                $email  = $_POST['mail'];
                $login  = $_POST['login'];
                $haslo  = password_hash($_POST['haslo'], PASSWORD_DEFAULT);
                $imie   = $_POST['imie'];
                $nazw   = $_POST['nazwisko'];

				// Whether email already exists?
				$result = $connect_database->query("SELECT id FROM uzytkownicy WHERE email='$email'");
				
				if(!$result) {
					throw new Exception($connect_database->error);
				}
				
				$num_email = $result->num_rows;
				if($num_email > 0) {
                    $validation = false;
					$_SESSION['error_email'] = "Istnieje już konto z tym e-mailem.";
				}
				
				// Whether login already exists?
				$result = $connect_database->query("SELECT id FROM uzytkownicy WHERE identyfikator='$login'");
				
				if(!$result) {
					throw new Exception($connect_database->error);
				}
				
				$num_nick = $result->num_rows;
				if($num_nick > 0) {
					$validation = false;
					$_SESSION['error_login'] = "Istnieje już konto z tym Identyfikatorem/Loginem";
				}
				
                // If false return ERROR
				if($validation == true) {
                    $numer_konta = '';
                    for($i = 0; $i < 16; $i++) {
                        $new_rand = rand(0, 9);
                        $numer_konta .= $new_rand;
                    }
					if($connect_database->query("INSERT INTO uzytkownicy VALUES(NULL, '$login', '$haslo', '$email', '$imie', '$nazw', '$numer_konta')")) {
						$_SESSION['registered'] = true;
						header('Location: witaj.php');
					}
					else {
						throw new Exception($connect_database->error);
					}
				}
				
				$connect_database->close();
			}
		
        } catch (Exception $e) {
            $_SESSION['error_server'] = "Błąd łączenia się z serwerem. Proszę spróbować później lub skontaktować się z obsługą mateuszBanku.";
        }

    }
?>