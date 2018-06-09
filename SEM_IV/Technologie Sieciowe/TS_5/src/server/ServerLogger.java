package server;

import java.util.Date;

public class ServerLogger {
    public static void log(String message) {
        Date dateNow = new Date();
        System.out.println(dateNow.toString().substring(0, 19) + ": " + message);
    }
}