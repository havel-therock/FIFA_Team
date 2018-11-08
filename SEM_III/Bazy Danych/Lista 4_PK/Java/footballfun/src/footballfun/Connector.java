package footballfun;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import com.mysql.jdbc.exceptions.MySQLSyntaxErrorException;

public class Connector{

	private static final long serialVersionUID = 1L;
	private String phpLogin = "root";
	private String phpPassword = "piotrek2";
	private String baseName = "footbalfun";
	private String connectionAdres = "jdbc:mysql://localhost/";
	private String sqlOrder;
	public String s1,s2,s3,s4,s5,s6,s7,s8;
	public int i;
	private String salt="324324sdfasadWERfdsfweg234SDAFcvsdfwe324234dfSDAFsdafscsdawe324ASDFsdffasdfc3e3eA";
	
	public void findLeauge(String club) {
		sqlOrder = "CALL ligaZespolu('"+club+"');";
		s1= " ";
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
        			s1 = result.getString("liga");
            	} 
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
	}
	
	public void sort(String leauge) {
		sqlOrder = "CALL ";
		
		switch(leauge) {
			case "Ekstraklasa":
				sqlOrder += "pozycjaEkstraklasa();";
				break;
			case "Bundesliga":
				sqlOrder += "pozycjaBundesliga();";
				break;
			case "La Liga":
				sqlOrder += "pozycjaLaLiga();";
				break;
			case "Serie A":
				sqlOrder += "pozycjaSerieA();";
				break;
			case "Ligue 1":
				sqlOrder += "pozycjaLigue1();";
				break;
			case "Premier Leauge":
				sqlOrder += "pozycjaPremierLeauge();";
				break;
		}
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
            	} 
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
	}
	
	public void sendMatch(String club1,String b1,String b2,String club2) {
		sqlOrder = "CALL rozegrajMecz('"+club1+"','"+b1+"','"+b2+"','"+club2+"');";
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
        			
            	} 
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
	}
	
	public void deleteAM() {
		sqlOrder = "CALL czyszczenieMeczyAbstrakcyjnych();";
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
        			
            	} 
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
	}
	
	public void deleteMatches() {
		sqlOrder = "CALL czyszczenieMeczy();";
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
        			
            	} 
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
	}
	
	public void createAccount(String login,String haslo) {
		 String hashPassword = null;
		 haslo+=salt;
		 try {
			 // Create MessageDigest instance for MD5
	        MessageDigest md = MessageDigest.getInstance("MD5");
	        //Add password bytes to digest
	        md.update(haslo.getBytes());
	        //Get the hash's bytes
	        byte[] bytes = md.digest();
	        //This bytes[] has bytes in decimal format;
	        //Convert it to hexadecimal format
	        StringBuilder sb = new StringBuilder();
	        for(int i=0; i< bytes.length ;i++){
	            sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
	        }
	        //Get complete hashed password in hex format
	        hashPassword = sb.toString();
		 }
       catch (NoSuchAlgorithmException e)
       {
           e.printStackTrace();
       }
		sqlOrder = "CALL tworzenieUzytkownikow('"+login+"','"+hashPassword+"');";
		
		try {
   		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
       	Statement myStmt = myConn.createStatement();
       	ResultSet result = myStmt.executeQuery(sqlOrder);
       	try{
       		while (result.next()) {
                 	s1 = result.getString("wynik");
           	} 
       	}
       	catch(MySQLSyntaxErrorException c) {
       		c.printStackTrace();
       	}
       }
       catch (Exception exc) {
       	exc.printStackTrace();
       }
		
	}
	//
	public void deleteAL(String log) {
		sqlOrder = "CALL usuwanieAbstrakcyjnejLigi('"+log+"');";
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
        			
            	} 
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
	}
	
	//
	public void createAL(String log) {
		sqlOrder = "CALL tworzenieAbstrakcyjnejLigi('"+log+"');";
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
        			
            	} 
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
	}
	
	//
	public void setFC(String club,String log) {
		sqlOrder = "CALL ustawUlubionaDruzyne('"+club+"','"+log+"');";
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
        			
            	} 
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
	}
	
	//
	public void playAM(String club1,String club2,String log) {
		sqlOrder = "CALL rozegrajMeczAbstrakcyjny('"+club1+"','"+club2+"','"+log+"');";
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
        			
            	} 
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
	}
	
	//
	public void deleteAT(String club,String log) {
		sqlOrder = "CALL usunZespolAbstrakcyjny('"+club+"','"+log+"');";
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
        			
            	} 
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
	}
	
	//
	public void addAT(String club,String log) {
		sqlOrder = "CALL dodajZespolAbstrakcyjny('"+club+"','"+log+"');";
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
        			
            	} 
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
	}
	
	//
	public void showAM(String log,int n) {
		sqlOrder = "CALL pokazMeczeAbstrakcyjne();";
		if(n==1) {
			sqlOrder = "CALL pokazAbstrakcyjneMecze('"+log+"');";
		}
		s1 = "<html>Data";
		s2 = "<html>Gospodarze";
		s3 = "<html> ";
		s4 = "<html> ";
		s5 = "<html>Goœcie";
		s6 = "<html>Rozgrywki";
		
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
        			s1 += "<br/>"+result.getString("data");
                  	s2 += "<br/>"+result.getString("nazwa");
                  	s3 += "<br/>"+result.getString("bramki_z1");
                  	s4 += "<br/>"+result.getString("bramki_z2");
                  	s5 += "<br/>"+result.getString("nazwa 2");
                  	s6 += "<br/>"+result.getString("rozgrywki");
            	} 
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
		s1 += "</html>";
		s2 += "</html>";
		s3 += "</html>";
		s4 += "</html>";
		s5 += "</html>";
		s6 += "</html>";
	}
	
	//
	public void showAL(String log) {
		sqlOrder = "CALL pokazAbstrakcyjnyWidok('"+log+"');";
		s1 = "<html>Pozycja";
		s2 = "<html>Druzyna";
		s3 = "<html>Ilosc Meczy";
		s4 = "<html>Bramki stracone";
		s5 = "<html>Bramki zdobyte";
		s6 = "<html>Bilans bramkowy";
		s7 = "<html>Punkty";
		
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
        			s1 += "<br/>"+result.getString("pozycja_w_tabeli");
                  	s2 += "<br/>"+result.getString("nazwa");
                  	s3 += "<br/>"+result.getString("rozegrane_mecze");
                  	s4 += "<br/>"+result.getString("bramki_stracone");
                  	s5 += "<br/>"+result.getString("bramki_strzelone");
                  	s6 += "<br/>"+result.getString("bilans_bramkowy");
                  	s7 += "<br/>"+result.getString("punkty");
            	} 
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
		s1 += "</html>";
		s2 += "</html>";
		s3 += "</html>";
		s4 += "</html>";
		s5 += "</html>";
		s6 += "</html>";
		s7 += "</html>";
	}
	
	public void login(String log,String pass) {
		String hashPassword = null;
		 pass+=salt;
		 try {
			 // Create MessageDigest instance for MD5
	        MessageDigest md = MessageDigest.getInstance("MD5");
	        //Add password bytes to digest
	        md.update(pass.getBytes());
	        //Get the hash's bytes
	        byte[] bytes = md.digest();
	        //This bytes[] has bytes in decimal format;
	        //Convert it to hexadecimal format
	        StringBuilder sb = new StringBuilder();
	        for(int i=0; i< bytes.length ;i++){
	            sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
	        }
	        //Get complete hashed password in hex format
	        hashPassword = sb.toString();
		 }
	      catch (NoSuchAlgorithmException e)
	      {
	          e.printStackTrace();
	      }
		
		sqlOrder = "CALL danekonta('"+log+"','"+hashPassword+"');";
		//System.out.println(hashPassword);
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
                  	s1 = result.getString("login");
                  	s2 = result.getString("poziom_dostepu");
                  	s3 = result.getString("wlasna_liga");
                  	s4 = result.getString("ulubiony_zespol");
                  	System.out.println(log);
            	} 
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
	}
	
	public void preLog(String log,String pass) {
		String hashPassword = null;
		 pass+=salt;
		 try {
			 // Create MessageDigest instance for MD5
	        MessageDigest md = MessageDigest.getInstance("MD5");
	        //Add password bytes to digest
	        md.update(pass.getBytes());
	        //Get the hash's bytes
	        byte[] bytes = md.digest();
	        //This bytes[] has bytes in decimal format;
	        //Convert it to hexadecimal format
	        StringBuilder sb = new StringBuilder();
	        for(int i=0; i< bytes.length ;i++){
	            sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
	        }
	        //Get complete hashed password in hex format
	        hashPassword = sb.toString();
		 }
	      catch (NoSuchAlgorithmException e)
	      {
	          e.printStackTrace();
	      }
		
		sqlOrder = "CALL logowanie('"+log+"','"+hashPassword+"');";
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
                  	s1 = result.getString("wynik");
            	} 
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
	}
	
	public void showLigue(String leauge) {
		sqlOrder = "CALL ";
		s1 = "<html>Pozycja";
		s2 = "<html>Druzyna";
		s3 = "<html>Ilosc Meczy";
		s4 = "<html>Bramki stracone";
		s5 = "<html>Bramki zdobyte";
		s6 = "<html>Bilans bramkowy";
		s7 = "<html>Punkty";
		
		switch(leauge) {
			case "ekstraklasa":
				sqlOrder += "pokazEkstraklasa();";
				break;
			case "bundesliga":
				sqlOrder += "pokazBundesliga();";
				break;
			case "laLiga":
				sqlOrder += "pokazLaLiga();";
				break;
			case "serieA":
				sqlOrder += "pokazSerieA();";
				break;
			case "ligue1":
				sqlOrder += "pokazLigue1();";
				break;
			case "premierLeauge":
				sqlOrder += "pokazPremierLeauge();";
				break;
		}
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
                  	s1 += "<br/>"+result.getString("pozycja_w_tabeli");
                  	s2 += "<br/>"+result.getString("nazwa");
                  	s3 += "<br/>"+result.getString("rozegrane_mecze");
                  	s4 += "<br/>"+result.getString("bramki_stracone");
                  	s5 += "<br/>"+result.getString("bramki_strzelone");
                  	s6 += "<br/>"+result.getString("bilans_bramkowy");
                  	s7 += "<br/>"+result.getString("punkty");
            	} 
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
		s1 += "</html>";
		s2 += "</html>";
		s3 += "</html>";
		s4 += "</html>";
		s5 += "</html>";
		s6 += "</html>";
		s7 += "</html>";
	}
	
	public void showMatches(String leauge) {
		sqlOrder = "CALL pokazMecze(";
		s1 = "<html>Data";
		s2 = "<html>Gospodarze";
		s3 = "<html> ";
		s4 = "<html> ";
		s5 = "<html>Goœcie";
		s6 = "<html>Rozgrywki";
		
		switch(leauge) {
			case "ekstraklasa":
				sqlOrder += "'Ekstraklasa');";
				break;
			case "bundesliga":
				sqlOrder += "'Bundesliga');";
				break;
			case "laLiga":
				sqlOrder += "'La Liga');";
				break;
			case "serieA":
				sqlOrder += "'Serie A');";
				break;
			case "ligue1":
				sqlOrder += "'Ligue 1');";
				break;
			case "premierLeauge":
				sqlOrder += "'Premier Leauge');";
				break;
			case "none":
				sqlOrder += "'none');";
				break;
		}
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
                  	s1 += "<br/>"+result.getString("data");
                  	s2 += "<br/>"+result.getString("nazwa");
                  	s3 += "<br/>"+result.getString("bramki_z1");
                  	s4 += "<br/>"+result.getString("bramki_z2");
                  	s5 += "<br/>"+result.getString("nazwa 2");
                  	s6 += "<br/>"+result.getString("rozgrywki");
            	}
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
		s1 += "</html>";
		s2 += "</html>";
		s3 += "</html>";
		s4 += "</html>";
		s5 += "</html>";
		s6 += "</html>";
	}
	
	public void showTeamInfo(String club) {
		sqlOrder = "CALL informacjeOZespole('"+club+"');";
		s1 = "<html>Nazwa zespo³u";
		s2 = "<html>Miejscowoœc";
		s3 = "<html>Liga";
		s4 = "<html>Trener";
		s5 = "<html>Barwy";
		s6 = "<html>Stadion";
		s7 = "<html>Adres stadionu";
		s8 = "<html>Iloœc miejsc";
		i=0;
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
                  	s1 += "<br/>"+result.getString("nazwa");
                  	s2 += "<br/>"+result.getString("mijescowosc");
                  	s3 += "<br/>"+result.getString("liga");
                  	s4 += "<br/>"+result.getString("trener");
                  	s5 += "<br/>"+result.getString("barwy");
                  	s6 += "<br/>"+result.getString("nazwa2");
                  	s7 += "<br/>"+result.getString("adres");
                  	s8 += "<br/>"+result.getString("ilosc_miejsc");
                  	i++;
            	}
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
		s1 += "</html>";
		s2 += "</html>";
		s3 += "</html>";
		s4 += "</html>";
		s5 += "</html>";
		s6 += "</html>";
		s7 += "</html>";
		s8 += "</html>";
	}
	
	public void showStadionInfo(String stadion) {
		sqlOrder = "CALL informacjeOStadionie('"+stadion+"');";
		s1 = "<html>Nazwa zespo³u";
		s2 = "<html>Stadion";
		s3 = "<html>Adres";
		s4 = "<html>Iloœc miejsc";
		s5 = " ";
		s6 = " ";
		s7 = " ";
		s8 = " ";
		i=0;
		try {
    		Connection myConn = DriverManager.getConnection(connectionAdres+baseName,phpLogin,phpPassword);
        	Statement myStmt = myConn.createStatement();
        	ResultSet result = myStmt.executeQuery(sqlOrder);
        	try{
        		while (result.next()) {
                  	s1 += "<br/>"+result.getString("nazwa");
                  	s2 += "<br/>"+result.getString("nazwa2");
                  	s3 += "<br/>"+result.getString("adres");
                  	s4 += "<br/>"+result.getString("ilosc_miejsc");
                  	i++;
            	}
        	}
        	catch(MySQLSyntaxErrorException c) {
        		c.printStackTrace();
        	}
        }
        catch (Exception exc) {
        	exc.printStackTrace();
        }
		s1 += "</html>";
		s2 += "</html>";
		s3 += "</html>";
		s4 += "</html>";
	}
	
	public static void main(String[] args) {
		Connector c = new Connector();
		c.showTeamInfo("Benfica Dortmund");
	}
}
