package server;

import java.io.IOException;
import java.net.ServerSocket;

public class Server {

    private int serverPort;
    private ServerSocket serverSocket;
    private ServerListenerThread listener;

    public Server(int port) {
        this.serverPort = port;
        try {
            serverSocket = new ServerSocket(serverPort);
            listener = new ServerListenerThread(serverSocket);

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void start() {
        System.out.println("Server running on: http://localhost:" + getPort() + "/");
        listener.run();
    }

    public int getPort() {
        return serverPort;
    }


}
