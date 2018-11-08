package footballfun;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

public class Footballfun extends JFrame implements ActionListener{
	
	private static final long serialVersionUID = 1L;
	private String userName = "niezalogowano",favoriteTeam,abstractLeauge;
	private int acces=0;
	private JPanel pMain,pTable,pMatches,pTeamInfo,pLog,pAL,pAM,pAlEdit,pAdmin;
	private JButton bEkstraklasa,bBundesliga,bLaLiga,bLigue1,bSerieA,bPL,bMecze,bLogin,bLogin2,bLogin3,bBack,bBack2,bBack3,bBack4,bBack5;
	private JButton bEk2,bBu2,bLL2,bL12,bSA2,bPL2,bTeamInfo,bLogin4,bLogin5,bITeam,bIStadion,bLogIn,bLogin8,bLogOut,bCreateAcount,bFa,bAL,bAM;
	private JButton bSearchAL,bMyAL,bAdmin,bBack6,bLogin6,bMyAM,bRestartAM,bEditAL,bLogin7,bBack8,bBack7,bAddTeam,bRestartMatches,bDeleteTeam,bPlayAM,bFT,bDeleteAL,bCreateAL,bZagrajMecz;
	private JLabel lHead,l1,l2,l3,l4,l5,l6,l7,l8,l9,l10,l11,l12,l13,lHead2,lHead3,lI1,lI2,lI3,lI4,lI5,lI6,lI7,lI8,lLog,lPas,lHead4,lHead5;
	private JLabel lAL1,lAL2,lAL3,lAL4,lAL5,lAL6,lAL7,lAM5,lAM4,lAM3,lAM2,lAM1,lAM6,lHead6,lHead7,lEdit,lPlay,lHead8;
	private JTextField tserch,tLogin,tPassword,tSearchAL,tTeamName,tTeam1,tTeam2,tFT,tMecz1,tMecz2,tMecz3,tMecz4;
	private Connector connector = new Connector();
	private enum logState{
		online,offline
	}
	private logState state=logState.offline;
	
	public Footballfun() {
		setTitle("FootballFun");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setMinimumSize(new Dimension(900, 700));
		tableScreen();
		add(pTable);
		matchesScreen();
		add(pMatches);
		teamInfoScreen();
		add(pTeamInfo);
		loginScreen();
		add(pLog);
		abLeaugeScreen();//
		add(pAL);//
		abMatchesScreen();//
		add(pAM);//
		alEditScreen();//
		add(pAlEdit);//
		adminScreen();
		add(pAdmin);
		mainScreen();
		add(pMain);
		setVisible(true);
	}
	
	public void adminScreen() {
		pAdmin = new JPanel();
		pAdmin.setSize(900, 700);
		pAdmin.setLayout(null);
		pAdmin.setBackground(Color.WHITE);
		
		bZagrajMecz = new JButton("Wprowadz wynik");
		bZagrajMecz.setBounds(450,100,150,50);
		pAdmin.add(bZagrajMecz);
		bZagrajMecz.addActionListener(this);
		
		tMecz1 = new JTextField("Gospodarze");
		tMecz1.setBounds(50, 100, 150, 50);
		pAdmin.add(tMecz1);
		tMecz1.addActionListener(this);
		
		tMecz2 = new JTextField();
		tMecz2.setBounds(200, 100, 50, 50);
		pAdmin.add(tMecz2);
		tMecz2.addActionListener(this);
		
		tMecz3 = new JTextField();
		tMecz3.setBounds(250, 100, 50, 50);
		pAdmin.add(tMecz3);
		tMecz3.addActionListener(this);
		
		tMecz4 = new JTextField("Goœcie");
		tMecz4.setBounds(300, 100, 150, 50);
		pAdmin.add(tMecz4);
		tMecz4.addActionListener(this);
		
		bLogin8 = new JButton(userName);
		bLogin8.setBounds(680, 20, 150, 50);
		pAdmin.add(bLogin8);
		bLogin8.addActionListener(this);
		
		bBack8 = new JButton("Powrót");
		bBack8.setBounds(30, 600, 150, 50);
		pAdmin.add(bBack8);
		bBack8.addActionListener(this);
		
		lHead8 = new JLabel("Okno Admina");
		lHead8.setBounds(50, 10, 800, 30);
		pAdmin.add(lHead8);
		
		bRestartMatches = new JButton("Usun wszsytkie mecze");
		bRestartMatches.setBounds(100,400,200,50);
		pAdmin.add(bRestartMatches);
		bRestartMatches.addActionListener(this);
		
		bRestartAM = new JButton("Usun wszsytkie mecze abstrakcyjne");
		bRestartAM.setBounds(350,400,250,50);
		pAdmin.add(bRestartAM);
		bRestartAM.addActionListener(this);
		
		pAdmin.setVisible(false);
		
	}
	
	//
	public void alEditScreen() {
		pAlEdit = new JPanel();
		pAlEdit.setSize(900, 700);
		pAlEdit.setLayout(null);
		pAlEdit.setBackground(Color.WHITE);
		
		lHead7 = new JLabel("Edycja ligi abstrakcyjnej");
		lHead7.setBounds(50, 10, 800, 30);
		pAlEdit.add(lHead7);
		
		bLogin7 = new JButton(userName);
		bLogin7.setBounds(680, 20, 150, 50);
		pAlEdit.add(bLogin7);
		bLogin7.addActionListener(this);
		
		bBack7 = new JButton("Powrót");
		bBack7.setBounds(30, 600, 150, 50);
		pAlEdit.add(bBack7);
		bBack7.addActionListener(this);
		
		lEdit = new JLabel("Dodaj/Usun zespó³");
		lEdit.setBounds(250, 90, 200, 30);
		pAlEdit.add(lEdit);
		
		lPlay = new JLabel("Rozegraj mecz");
		lPlay.setBounds(250, 350, 200, 30);
		pAlEdit.add(lPlay);
		
		tTeamName = new JTextField("wprowadz nazwe dru¿yny");
		tTeamName.setBounds(50, 120, 450, 50);
		pAlEdit.add(tTeamName);
		
		bAddTeam = new JButton("Dodaj");
		bAddTeam.setBounds(500, 120, 175, 50);
		pAlEdit.add(bAddTeam);
		bAddTeam.addActionListener(this);
		
		bDeleteTeam = new JButton("Usuñ");
		bDeleteTeam.setBounds(675, 120, 175, 50);
		pAlEdit.add(bDeleteTeam);
		bDeleteTeam.addActionListener(this);
		
		bPlayAM = new JButton("Rozegraj");
		bPlayAM.setBounds(650, 380, 200, 50);
		pAlEdit.add(bPlayAM);
		bPlayAM.addActionListener(this);
		
		tTeam1 = new JTextField("druzyna 1");
		tTeam1.setBounds(50, 380, 300, 50);
		pAlEdit.add(tTeam1);
		
		tTeam2 = new JTextField("druzyna 2");
		tTeam2.setBounds(350, 380, 300, 50);
		pAlEdit.add(tTeam2);
		
		pAlEdit.setVisible(false);
	}
	
	//
	public void abMatchesScreen() {
		pAM = new JPanel();
		pAM.setSize(900, 700);
		pAM.setLayout(null);
		pAM.setBackground(Color.WHITE);
		
		lHead6 = new JLabel("Mecze lig abstrakycjnych");
		lHead6.setBounds(50, 10, 800, 30);
		pAM.add(lHead6);
		
		lAM1 = new JLabel();
		lAM1.setBounds(150, 120, 125, 600);
		pAM.add(lAM1);
		
		lAM2 = new JLabel();
		lAM2.setBounds(280, 120, 145, 600);
		pAM.add(lAM2);
		
		lAM3 = new JLabel();
		lAM3.setBounds(425, 120, 30, 600);
		pAM.add(lAM3);
		
		lAM4 = new JLabel();
		lAM4.setBounds(455, 120, 30, 600);
		pAM.add(lAM4);
		
		lAM5 = new JLabel();
		lAM5.setBounds(495, 120, 145, 600);
		pAM.add(lAM5);
		
		lAM6 = new JLabel();
		lAM6.setBounds(650, 120, 125, 600);
		pAM.add(lAM6);
		
		bLogin6 = new JButton(userName);
		bLogin6.setBounds(680, 20, 150, 50);
		pAM.add(bLogin6);
		bLogin6.addActionListener(this);
		
		bBack6 = new JButton("Powrót");
		bBack6.setBounds(30, 600, 150, 50);
		pAM.add(bBack6);
		bBack6.addActionListener(this);
		
		bMyAM = new JButton("Mecze mojej ligi");
		bMyAM.setBounds(680, 90, 150, 20);
		pAM.add(bMyAM);
		bMyAM.addActionListener(this);
		
		pAM.setVisible(false);
	}
	//
	public void abLeaugeScreen() {
		pAL = new JPanel();
		pAL.setSize(900, 700);
		pAL.setLayout(null);
		pAL.setBackground(Color.WHITE);
		
		lHead5 = new JLabel("Ligi Abstrakcyjne");
		lHead5.setBounds(50, 10, 800, 30);
		pAL.add(lHead5);
		
		bBack5 = new JButton("Powrót");
		bBack5.setBounds(30, 600, 150, 50);
		pAL.add(bBack5);
		bBack5.addActionListener(this);
		
		bLogin5 = new JButton(userName);
		bLogin5.setBounds(680, 20, 150, 50);
		pAL.add(bLogin5);
		bLogin5.addActionListener(this);
		
		bSearchAL = new JButton("Wyszukaj");
		bSearchAL.setBounds(700, 90, 150, 50);
		pAL.add(bSearchAL);
		bSearchAL.addActionListener(this);
		
		bMyAL = new JButton("Moja Liga");
		bMyAL.setBounds(700, 140, 150, 50);
		pAL.add(bMyAL);
		bMyAL.addActionListener(this);
		
		tSearchAL = new JTextField("wprowadz login gracza");
		tSearchAL.setBounds(50, 90, 650, 50);
		pAL.add(tSearchAL);
		
		lAL1 = new JLabel();
		lAL1.setBounds(50, 50, 90, 600);
		pAL.add(lAL1);
		
		lAL2 = new JLabel();
		lAL2.setBounds(150, 50, 200, 600);
		pAL.add(lAL2);
		
		lAL3 = new JLabel();
		lAL3.setBounds(360, 50, 90, 600);
		pAL.add(lAL3);
		
		lAL4 = new JLabel();
		lAL4.setBounds(440, 50, 120, 600);
		pAL.add(lAL4);
		
		lAL5 = new JLabel();
		lAL5.setBounds(550, 50, 90, 600);
		pAL.add(lAL5);
		
		lAL6 = new JLabel();
		lAL6.setBounds(650, 50, 100, 600);
		pAL.add(lAL6);
		
		lAL7 = new JLabel();
		lAL7.setBounds(760, 50, 90, 600);
		pAL.add(lAL7);
		
		pAL.setVisible(false);
	}
	
	
	public void loginScreen() {
		pLog = new JPanel();
		pLog.setSize(900, 700);
		pLog.setLayout(null);
		pLog.setBackground(Color.WHITE);
		
		lHead4 = new JLabel("Ektran Logowania");
		lHead4.setBounds(50, 10, 800, 30);
		pLog.add(lHead4);
		
		bBack4 = new JButton("Powrót");
		bBack4.setBounds(30, 600, 150, 50);
		pLog.add(bBack4);
		bBack4.addActionListener(this);
		
		bLogOut = new JButton("Wyloguj");
		bLogOut.setBounds(680, 20, 150, 50);
		pLog.add(bLogOut);
		bLogOut.addActionListener(this);
		
		lLog = new JLabel("Login");
		lLog.setBounds(100, 200, 100, 50);
		pLog.add(lLog);
		
		lPas = new JLabel("Has³o");
		lPas.setBounds(100, 260, 100, 50);
		pLog.add(lPas);
		
		tLogin = new JTextField();
		tLogin.setBounds(200, 200, 200, 50);
		pLog.add(tLogin);
		tLogin.addActionListener(this);
		
		tPassword = new JTextField();
		tPassword.setBounds(200, 260, 200, 50);
		pLog.add(tPassword);
		tPassword.addActionListener(this);
		
		bLogIn = new JButton("Zaloguj");
		bLogIn.setBounds(225, 330, 150, 50);
		pLog.add(bLogIn);
		bLogIn.addActionListener(this);
		
		bCreateAcount = new JButton("Stwórz konto");
		bCreateAcount.setBounds(450, 230, 150, 50);
		pLog.add(bCreateAcount);
		bCreateAcount.addActionListener(this);
		
		bEditAL = new JButton("Edytuj lige abstrakcyjn¹");//
		bEditAL.setBounds(150, 100, 220, 50);//
		bEditAL.addActionListener(this);//
		
		tFT = new JTextField("Wybierz ulubiony zespó³");//
		tFT.setBounds(100, 400, 400, 50);//
		
		bFT = new JButton("Zmieñ ulubiony klub");//
		bFT.setBounds(500, 400, 200, 50);//
		bFT.addActionListener(this);//
		
		bDeleteAL = new JButton("Usuñ lige abstrakcyjn¹");//
		bDeleteAL.setBounds(370, 100, 220, 50);//
		bDeleteAL.addActionListener(this);//
		
		bCreateAL = new JButton("Stwórz lige abstrakcyjn¹");//
		bCreateAL.setBounds(590, 100, 220, 50);//
		bCreateAL.addActionListener(this);//
		
		pLog.setVisible(false);
	}
	
	public void teamInfoScreen() {
		pTeamInfo = new JPanel();
		pTeamInfo.setSize(900, 700);
		pTeamInfo.setLayout(null);
		pTeamInfo.setBackground(Color.WHITE);
		
		lHead3 = new JLabel("Informacje o zespo³ach i stadionach");
		lHead3.setBounds(50, 10, 800, 30);
		pTeamInfo.add(lHead3);
		
		bBack3 = new JButton("Powrót");
		bBack3.setBounds(30, 600, 150, 50);
		pTeamInfo.add(bBack3);
		bBack3.addActionListener(this);
		
		bLogin4 = new JButton(userName);
		bLogin4.setBounds(680, 20, 150, 50);
		pTeamInfo.add(bLogin4);
		bLogin4.addActionListener(this);
		
		tserch = new JTextField("wprowadz nazwe druzyny lub stadionu");
		tserch.setBounds(50, 120, 750, 50);
		pTeamInfo.add(tserch);
		
		bITeam = new JButton("Dru¿yna");
		bITeam.setBounds(300, 170, 150, 50);
		pTeamInfo.add(bITeam);
		bITeam.addActionListener(this);
		
		bIStadion = new JButton("Stadion");
		bIStadion.setBounds(450, 170, 150, 50);
		pTeamInfo.add(bIStadion);
		bIStadion.addActionListener(this);
		
		lI1 = new JLabel();
		lI1.setBounds(50, 230, 200, 200);
		pTeamInfo.add(lI1);
		
		lI2 = new JLabel();
		lI2.setBounds(250, 230, 200, 200);
		pTeamInfo.add(lI2);
		
		lI3 = new JLabel();
		lI3.setBounds(450, 230, 200, 200);
		pTeamInfo.add(lI3);
		
		lI4 = new JLabel();
		lI4.setBounds(650, 230, 200, 200);
		pTeamInfo.add(lI4);
		
		lI5 = new JLabel();
		lI5.setBounds(50, 400, 150, 200);
		pTeamInfo.add(lI5);
		
		lI6 = new JLabel();
		lI6.setBounds(250, 400, 150, 200);
		pTeamInfo.add(lI6);
		
		lI7 = new JLabel();
		lI7.setBounds(450, 400, 150, 200);
		pTeamInfo.add(lI7);
		
		lI8 = new JLabel();
		lI8.setBounds(650, 400, 150, 200);
		pTeamInfo.add(lI8);
		
		pTeamInfo.setVisible(false);
	}
	
	public void matchesScreen() {
		pMatches = new JPanel();
		pMatches.setSize(900, 700);
		pMatches.setLayout(null);
		pMatches.setBackground(Color.WHITE);
		
		lHead2 = new JLabel();
		lHead2.setBounds(50, 10, 800, 30);
		pMatches.add(lHead2);
		
		l8 = new JLabel();
		l8.setBounds(150, 120, 125, 600);
		pMatches.add(l8);
		
		l9 = new JLabel();
		l9.setBounds(280, 120, 145, 600);
		pMatches.add(l9);
		
		l10 = new JLabel();
		l10.setBounds(425, 120, 30, 600);
		pMatches.add(l10);
		
		l11 = new JLabel();
		l11.setBounds(455, 120, 30, 600);
		pMatches.add(l11);
		
		l12 = new JLabel();
		l12.setBounds(495, 120, 145, 600);
		pMatches.add(l12);
		
		l13 = new JLabel();
		l13.setBounds(650, 120, 125, 600);
		pMatches.add(l13);
		
		bLogin3 = new JButton(userName);
		bLogin3.setBounds(680, 20, 150, 50);
		pMatches.add(bLogin3);
		bLogin3.addActionListener(this);
		
		bBack2 = new JButton("Powrót");
		bBack2.setBounds(30, 600, 150, 50);
		pMatches.add(bBack2);
		bBack2.addActionListener(this);
		
		bEk2 = new JButton("Mecze Ekstraklasy");
		bEk2.setBounds(30, 90, 150, 20);
		pMatches.add(bEk2);
		bEk2.addActionListener(this);
		
		bBu2 = new JButton("Mecze Bundesligi");
		bBu2.setBounds(180, 90, 145, 20);
		pMatches.add(bBu2);
		bBu2.addActionListener(this);
		
		bLL2 = new JButton("Mecze La Ligi");
		bLL2.setBounds(325, 90, 125, 20);
		pMatches.add(bLL2);
		bLL2.addActionListener(this);
		
		bL12 = new JButton("Mecze Ligue 1");
		bL12.setBounds(450, 90, 120, 20);
		pMatches.add(bL12);
		bL12.addActionListener(this);
		
		bSA2 = new JButton("Mecze Serie A");
		bSA2.setBounds(570, 90, 120, 20);
		pMatches.add(bSA2);
		bSA2.addActionListener(this);
		
		bPL2 = new JButton("Mecze Premier Leauge");
		bPL2.setBounds(690, 90, 170, 20);
		pMatches.add(bPL2);
		bPL2.addActionListener(this);
		
		pMatches.setVisible(false);
	}
	
	public void tableScreen() {
		pTable = new JPanel();
		pTable.setSize(900, 700);
		pTable.setLayout(null);
		pTable.setBackground(Color.WHITE);
		
		lHead = new JLabel();
		lHead.setBounds(50, 10, 800, 30);
		pTable.add(lHead);
		
		l1 = new JLabel();
		l1.setBounds(50, 50, 90, 600);
		pTable.add(l1);
		
		l2 = new JLabel();
		l2.setBounds(150, 50, 200, 600);
		pTable.add(l2);
		
		l3 = new JLabel();
		l3.setBounds(360, 50, 90, 600);
		pTable.add(l3);
		
		l4 = new JLabel();
		l4.setBounds(440, 50, 120, 600);
		pTable.add(l4);
		
		l5 = new JLabel();
		l5.setBounds(550, 50, 90, 600);
		pTable.add(l5);
		
		l6 = new JLabel();
		l6.setBounds(650, 50, 100, 600);
		pTable.add(l6);
		
		l7 = new JLabel();
		l7.setBounds(760, 50, 90, 600);
		pTable.add(l7);
		
		bLogin2 = new JButton(userName);
		bLogin2.setBounds(680, 20, 150, 50);
		pTable.add(bLogin2);
		bLogin2.addActionListener(this);
		
		bBack = new JButton("Powrót");
		bBack.setBounds(30, 600, 150, 50);
		pTable.add(bBack);
		bBack.addActionListener(this);
		
		pTable.setVisible(false);
	}
	
	
	public void mainScreen() {
		pMain = new JPanel();
		pMain.setSize(900, 700);
		pMain.setLayout(null);
		pMain.setBackground(Color.WHITE);
		
		bEkstraklasa = new JButton("Ekstraklasa");
		bEkstraklasa.setBounds(375, 90, 150, 50);
		pMain.add(bEkstraklasa);
		bEkstraklasa.addActionListener(this);
		
		bBundesliga = new JButton("Bundesliga");
		bBundesliga.setBounds(375, 150, 150, 50);
		pMain.add(bBundesliga);
		bBundesliga.addActionListener(this);
		
		bLaLiga = new JButton("La Liga");
		bLaLiga.setBounds(375, 210, 150, 50);
		pMain.add(bLaLiga);
		bLaLiga.addActionListener(this);
		
		bLigue1 = new JButton("Ligue 1");
		bLigue1.setBounds(375, 270, 150, 50);
		pMain.add(bLigue1);
		bLigue1.addActionListener(this);
		
		bSerieA = new JButton("Serie A");
		bSerieA.setBounds(375, 330, 150, 50);
		pMain.add(bSerieA);
		bSerieA.addActionListener(this);
		
		bPL = new JButton("Premier Leauge");
		bPL.setBounds(375, 390, 150, 50);
		pMain.add(bPL);
		bPL.addActionListener(this);
		
		bMecze = new JButton("Wyniki Meczów");
		bMecze.setBounds(375, 450, 150, 50);
		pMain.add(bMecze);
		bMecze.addActionListener(this);
		
		bLogin = new JButton(userName);
		bLogin.setBounds(680, 20, 150, 50);
		pMain.add(bLogin);
		bLogin.addActionListener(this);
		
		bTeamInfo = new JButton("Zespo³y/Stadiony");
		bTeamInfo.setBounds(375, 510, 150, 50);
		pMain.add(bTeamInfo);
		bTeamInfo.addActionListener(this);
		
		bAL = new JButton("Ligi Abstrakcyjne");//
		bAL.setBounds(540, 315, 150, 50);//
		bAL.addActionListener(this);//
		
		bAM = new JButton("Mecze Abstrakcyjne");//
		bAM.setBounds(540, 375, 150, 50);//
		bAM.addActionListener(this);//
		
		bAdmin = new JButton("Opcje Admina");//
		bAdmin.setBounds(540, 435, 150, 50);//
		bAdmin.addActionListener(this);//
		
		pMain.setVisible(true);
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		Object o = e.getSource();
		if(o==bEkstraklasa) {
			lHead.setText("Ekstraklasa");
			connector.showLigue("ekstraklasa");
			l1.setText(connector.s1);
			l2.setText(connector.s2);
			l3.setText(connector.s3);
			l4.setText(connector.s4);
			l5.setText(connector.s5);
			l6.setText(connector.s6);
			l7.setText(connector.s7);
			pMain.setVisible(false);
			pTable.setVisible(true);
		}else if(o==bBundesliga) {
			lHead.setText("Bundesliga");
			connector.showLigue("bundesliga");
			l1.setText(connector.s1);
			l2.setText(connector.s2);
			l3.setText(connector.s3);
			l4.setText(connector.s4);
			l5.setText(connector.s5);
			l6.setText(connector.s6);
			l7.setText(connector.s7);
			pMain.setVisible(false);
			pTable.setVisible(true);
		}else if(o==bLaLiga) {
			lHead.setText("La Liga");
			connector.showLigue("laLiga");
			l1.setText(connector.s1);
			l2.setText(connector.s2);
			l3.setText(connector.s3);
			l4.setText(connector.s4);
			l5.setText(connector.s5);
			l6.setText(connector.s6);
			l7.setText(connector.s7);
			pMain.setVisible(false);
			pTable.setVisible(true);
		}else if(o==bLigue1) {
			lHead.setText("Ligue 1");
			connector.showLigue("ligue1");
			l1.setText(connector.s1);
			l2.setText(connector.s2);
			l3.setText(connector.s3);
			l4.setText(connector.s4);
			l5.setText(connector.s5);
			l6.setText(connector.s6);
			l7.setText(connector.s7);
			pMain.setVisible(false);
			pTable.setVisible(true);
		}else if(o==bSerieA) {
			lHead.setText("Serie A");
			connector.showLigue("serieA");
			l1.setText(connector.s1);
			l2.setText(connector.s2);
			l3.setText(connector.s3);
			l4.setText(connector.s4);
			l5.setText(connector.s5);
			l6.setText(connector.s6);
			l7.setText(connector.s7);
			pMain.setVisible(false);
			pTable.setVisible(true);
		}else if(o==bPL) {
			lHead.setText("Premier Leauge");
			connector.showLigue("premierLeauge");
			l1.setText(connector.s1);
			l2.setText(connector.s2);
			l3.setText(connector.s3);
			l4.setText(connector.s4);
			l5.setText(connector.s5);
			l6.setText(connector.s6);
			l7.setText(connector.s7);
			pMain.setVisible(false);
			pTable.setVisible(true);
		}else if(o==bBack || o==bBack2 || o==bBack3 || o==bBack4 || o==bBack5 || o==bBack6 || o==bBack7 || o==bBack8) {
			pMatches.setVisible(false);
			pLog.setVisible(false);
			pTable.setVisible(false);
			pAdmin.setVisible(false);
			pAM.setVisible(false);
			pTeamInfo.setVisible(false);
			pAlEdit.setVisible(false);//
			pAL.setVisible(false);//
			pMain.setVisible(true);
		}else if(o==bMecze) {
			lHead2.setText("Wyniki meczów");
			connector.showMatches("none");
			l8.setText(connector.s1);
			l9.setText(connector.s2);
			l10.setText(connector.s3);
			l11.setText(connector.s4);
			l12.setText(connector.s5);
			l13.setText(connector.s6);
			pMain.setVisible(false);
			pMatches.setVisible(true);
		}else if(o==bEk2) {
			connector.showMatches("ekstraklasa");
			l8.setText(connector.s1);
			l9.setText(connector.s2);
			l10.setText(connector.s3);
			l11.setText(connector.s4);
			l12.setText(connector.s5);
			l13.setText(connector.s6);
		}else if(o==bBu2) {
			connector.showMatches("bundesliga");
			l8.setText(connector.s1);
			l9.setText(connector.s2);
			l10.setText(connector.s3);
			l11.setText(connector.s4);
			l12.setText(connector.s5);
			l13.setText(connector.s6);
		}else if(o==bLL2) {
			connector.showMatches("laLiga");
			l8.setText(connector.s1);
			l9.setText(connector.s2);
			l10.setText(connector.s3);
			l11.setText(connector.s4);
			l12.setText(connector.s5);
			l13.setText(connector.s6);
		}else if(o==bL12) {
			connector.showMatches("ligue1");
			l8.setText(connector.s1);
			l9.setText(connector.s2);
			l10.setText(connector.s3);
			l11.setText(connector.s4);
			l12.setText(connector.s5);
			l13.setText(connector.s6);
		}else if(o==bSA2) {
			connector.showMatches("serieA");
			l8.setText(connector.s1);
			l9.setText(connector.s2);
			l10.setText(connector.s3);
			l11.setText(connector.s4);
			l12.setText(connector.s5);
			l13.setText(connector.s6);
		}else if(o==bPL2) {
			connector.showMatches("premierLeauge");
			l8.setText(connector.s1);
			l9.setText(connector.s2);
			l10.setText(connector.s3);
			l11.setText(connector.s4);
			l12.setText(connector.s5);
			l13.setText(connector.s6);
		}else if(o==bTeamInfo){
			pMain.setVisible(false);
			pTeamInfo.setVisible(true);
		}else if(o==bITeam) {
			connector.showTeamInfo(tserch.getText());
			if(connector.i==0) {
				tserch.setText("Nie ma takiej dru¿yny");
			}else {
				lI1.setText(connector.s1);
				lI2.setText(connector.s2);
				lI3.setText(connector.s3);
				lI4.setText(connector.s4);
				lI5.setText(connector.s5);
				lI6.setText(connector.s6);
				lI7.setText(connector.s7);
				lI8.setText(connector.s8);
			}
		}else if(o==bIStadion) {
			connector.showStadionInfo(tserch.getText());
			if(connector.i==0) {
				tserch.setText("Nie ma takiego stadionu");
			}else {
				lI1.setText(connector.s1);
				lI2.setText(connector.s2);
				lI3.setText(connector.s3);
				lI4.setText(connector.s4);
				lI5.setText(connector.s5);
				lI6.setText(connector.s6);
				lI7.setText(connector.s7);
				lI8.setText(connector.s8);
			}
		}else if(o==bLogin || o==bLogin2 || o==bLogin3 || o==bLogin4 || o==bLogin5 || o==bLogin6 || o==bLogin7 || o==bLogin8) {
			pMatches.setVisible(false);
			pTable.setVisible(false);
			pTeamInfo.setVisible(false);
			pAM.setVisible(false);
			pMain.setVisible(false);
			pAdmin.setVisible(false);
			pAlEdit.setVisible(false);//
			pAL.setVisible(false);//
			pLog.setVisible(true);
		}else if(o==bLogIn) {
			connector.preLog(tLogin.getText(),tPassword.getText());
			if(connector.s1.equals("false")) {
				tLogin.setText("Z³y login...");
				tPassword.setText("...lub has³o");
			}else if(connector.s1.equals("true")) {
				connector.login(tLogin.getText(),tPassword.getText());
				userName = connector.s1;
				acces = Integer.parseInt(connector.s2);
				favoriteTeam = connector.s4;
				abstractLeauge = connector.s3;
				afterLogin();
				pLog.setVisible(false);
				pMain.setVisible(true);
			}
		}else if(o==bLogOut) {//
			userName = "niezalogowano";
			afterLogout();
			acces = 0;
			favoriteTeam = " ";
			abstractLeauge = " ";
			pLog.setVisible(false);
			pMain.setVisible(true);
		}else if(o==bAL) {//
			pMain.setVisible(false);
			pAL.setVisible(true);
		}else if(o==bSearchAL) {//
			connector.showAL(tSearchAL.getText());
			lAL1.setText(connector.s1);
			lAL2.setText(connector.s2);
			lAL3.setText(connector.s3);
			lAL4.setText(connector.s4);
			lAL5.setText(connector.s5);
			lAL6.setText(connector.s6);
			lAL7.setText(connector.s7);
		}else if(o==bMyAL) {//
			connector.showAL(userName);
			lAL1.setText(connector.s1);
			lAL2.setText(connector.s2);
			lAL3.setText(connector.s3);
			lAL4.setText(connector.s4);
			lAL5.setText(connector.s5);
			lAL6.setText(connector.s6);
			lAL7.setText(connector.s7);
		}else if(o==bAM || o==bMyAM) {
			if(o==bMyAM) {
				connector.showAM(userName,1);
			}else {
				connector.showAM(userName,0);
			}
			lAM1.setText(connector.s1);
			lAM2.setText(connector.s2);
			lAM3.setText(connector.s3);
			lAM4.setText(connector.s4);
			lAM5.setText(connector.s5);
			lAM6.setText(connector.s6);
			pMain.setVisible(false);
			pAM.setVisible(true);
		}else if(o==bEditAL) {
			pMain.setVisible(false);
			pLog.setVisible(false);
			pAlEdit.setVisible(true);
		}else if(o==bAddTeam) {
			connector.addAT(tTeamName.getText(), userName);
		}else if(o==bDeleteTeam) {
			connector.deleteAT(tTeamName.getText(), userName);
		}else if(o==bPlayAM) {
			connector.playAM(tTeam1.getText(),tTeam2.getText(),userName);
		}else if(o==bFT) {
			connector.setFC(tFT.getText(), userName);
			favoriteTeam = tFT.getText();
			tserch.setText(favoriteTeam);
		}else if(o==bDeleteAL) {
			connector.deleteAL(userName);
		}else if(o==bCreateAL) {
			connector.createAL(userName);
		}else if(o==bCreateAcount){
			connector.createAccount(tLogin.getText(), tPassword.getText());
			if(connector.s1.equals("false")) {
				tLogin.setText("Taki login juz istnieje");
				tPassword.setText("");
			}else if(connector.s1.equals("true")){
				tLogin.setText("Utworzono konto! teraz sie zaloguj");
				tPassword.setText("");	
			}
		}else if(o==bAdmin) {
			pMain.setVisible(false);
			pAdmin.setVisible(true);
		}else if(o==bRestartMatches) {
			connector.deleteMatches();
		}else if(o==bRestartAM) {
			connector.deleteAM();
		}else if(o==bZagrajMecz) {
			connector.sendMatch(tMecz1.getText(), tMecz2.getText(), tMecz3.getText(), tMecz4.getText());
			connector.findLeauge(tMecz1.getText());
			connector.sort(connector.s1);
		}
	}
	//
	private void afterLogout() {
		state=logState.offline;
		bLogin.setText(userName);
		bLogin2.setText(userName);
		bLogin3.setText(userName);
		bLogin4.setText(userName);
		bLogin5.setText(userName);
		bLogin6.setText(userName);
		bLogin7.setText(userName);
		bLogin8.setText(userName);
		tserch.setText("Informacje o zespo³ach i stadionach");
		pLog.remove(tFT);
		pLog.remove(bFT);
		pLog.remove(bDeleteAL);
		pLog.remove(bCreateAL);
		pLog.add(lLog);
		pLog.add(lPas);
		pLog.add(tLogin);
		pLog.add(tPassword);
		pLog.add(bCreateAcount);
		pLog.add(bLogIn);
		pLog.remove(bEditAL);
		lHead4.setText("Ektran Logowania");
		pMain.remove(bAL);
		pMain.remove(bAM);
		if(acces==2) {
			pLog.remove(bAdmin);
		}
	}
	
	
	private void afterLogin() {
		state=logState.online;
		bLogin.setText(userName);
		bLogin2.setText(userName);
		bLogin3.setText(userName);
		bLogin4.setText(userName);
		bLogin5.setText(userName);//
		bLogin6.setText(userName);//
		bLogin7.setText(userName);//
		bLogin8.setText(userName);
		tserch.setText(favoriteTeam);
		pLog.add(tFT);//
		pLog.add(bFT);//
		pLog.add(bDeleteAL);//
		pLog.add(bCreateAL);//
		pLog.remove(lLog);//
		pLog.remove(lPas);//
		pLog.remove(tLogin);//
		pLog.remove(tPassword);//
		pLog.remove(bCreateAcount);//
		pLog.remove(bLogIn);//
		pLog.add(bEditAL);//
		lHead4.setText(userName);//
		pMain.add(bAL);//
		pMain.add(bAM);//
		tLogin.setText(" ");//
		tPassword.setText(" ");//
		if(acces==2) {
			pMain.add(bAdmin);
		}
	}
	
	public static void main(String[] args) {
		Footballfun ff = new Footballfun();
	}
}
