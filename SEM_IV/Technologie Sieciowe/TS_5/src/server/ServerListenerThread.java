package server;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.ServerSocket;
import java.net.Socket;

public class ServerListenerThread extends Thread {

    private ServerSocket server;

    ServerListenerThread(ServerSocket socket) {
        this.server = socket;
    }


    @Override
    public void run() {
        while (true) {
            try (Socket socket = server.accept()) {

                InputStreamReader isr = new InputStreamReader(socket.getInputStream());
                BufferedReader reader = new BufferedReader(isr);

                StringBuilder requestContent = new StringBuilder();
                String line = reader.readLine();

                while (!line.isEmpty()) {
                    requestContent.append(line);
                    requestContent.append("\r\n");
                    line = reader.readLine();
                    if(line == null) {
                        break;
                    }
                }

                byte[] response = parseRequest(requestContent.toString());
                socket.getOutputStream().write(response);

            } catch (IOException e) {
                System.out.println("Internal error has occured");
            }
        }
    }

    private byte[] parseRequest(String requestString) throws UnsupportedEncodingException {

        ServerLogger.log(requestString.substring(0, requestString.indexOf("\r\n")));
        ServerRequest serverRequest = new ServerRequest(requestString);
        return serverRequest.getResponse().getBytes("UTF-8");
    }
}