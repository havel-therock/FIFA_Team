
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.List;

class Z2Sender {

    static final int datagramSize = 50;
    static final int sleepTime = 500;
    static final int maxPacket = 50;
    InetAddress localHost;
    int destinationPort;
    DatagramSocket socket;
    SenderThread sender;
    ReceiverThread receiver;

    List<DatagramPacket> toSend = new ArrayList<>();
    int missing = -1;

    public Z2Sender(int myPort, int destPort)
            throws Exception {
        localHost = InetAddress.getByName("127.0.0.1");
        destinationPort = destPort;
        socket = new DatagramSocket(myPort);
        sender = new SenderThread();
        receiver = new ReceiverThread();
        ;
    }

    class SenderThread extends Thread {

        public void run() {
            int i, x;
            try {

                for (i = 0; (x = System.in.read()) >= 0; i++) {
                    Z2Packet p = new Z2Packet(4 + 1);
                    p.setIntAt(i, 0);
                    p.data[4] = (byte) x;
                    DatagramPacket packet = new DatagramPacket(p.data, p.data.length, localHost, destinationPort);
                    socket.send(packet);
                    toSend.add(packet);
                }

            } catch (Exception e) {
                System.out.println("Z2Sender.SenderThread.run: " + e);
            }
        }
    }

    class ReceiverThread extends Thread {

        public void run() {
            try {
                while (true) {
                    byte[] data = new byte[datagramSize];
                    DatagramPacket packet = new DatagramPacket(data, datagramSize);
                    socket.receive(packet);
                    Z2Packet p = new Z2Packet(packet.getData());
                    System.out.println("S:" + p.getIntAt(0) + ": " + (char) p.data[4]);
                    missing = p.getIntAt(0);
                    if (missing == toSend.size()) {
                        Z2Packet end = new Z2Packet(4 + 1);
                        end.setIntAt(-1, 0);
                        end.data[4] = (byte) 'x';
                        DatagramPacket endPacket = new DatagramPacket(end.data, end.data.length, localHost, destinationPort);
                        socket.send(endPacket);
                        toSend.add(endPacket);
                    } else {
                        for (; missing < toSend.size(); missing++) {
                            socket.send(toSend.get(missing));
                            sleep(sleepTime);
                        }
                    }
                }
            } catch (Exception e) {
                System.out.println("Z2Sender.ReceiverThread.run: " + e);
            }
        }
    }

    public static void main(String[] args)
            throws Exception {
        Z2Sender sender = new Z2Sender(Integer.parseInt(args[0]),
                Integer.parseInt(args[1]));
        sender.sender.start();
        sender.receiver.start();
    }

}

