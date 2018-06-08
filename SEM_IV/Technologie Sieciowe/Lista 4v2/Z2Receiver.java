import java.net.*;
import java.util.ArrayList;
import java.util.List;
import java.util.TreeMap;

public class Z2Receiver {

    static final int datagramSize = 50;
    InetAddress localHost;
    int destinationPort;
    DatagramSocket socket;
    int counter;
    List<DatagramPacket> receiv = new ArrayList<>();
    TreeMap<Integer, Character> chars = new TreeMap<Integer, Character>();
    ReceiverThread receiver;
    SendConfirmationThread sender;
    boolean deliver = false;

    public Z2Receiver(int myPort, int destPort)
            throws Exception {
        localHost = InetAddress.getByName("127.0.0.1");
        destinationPort = destPort;
        socket = new DatagramSocket(myPort);
        receiver = new ReceiverThread();
        sender = new SendConfirmationThread();
    }

    class ReceiverThread extends Thread {

        public void run() {
            try {
                while (true) {

                    byte[] data = new byte[datagramSize];
                    DatagramPacket packet = new DatagramPacket(data, datagramSize);
                    socket.receive(packet);
                    Z2Packet p = new Z2Packet(packet.getData());
                    int i = p.getIntAt(0);
                    char c = (char) p.data[4];
                    if (i < 0) {
                        System.out.println("Dostarczono");
                        deliver = true;
                    }
                    if (i > counter) {
                        chars.put(i, c);
                    } else if (i == counter) {
                        System.out.println("R:" + i + ":" + c);
                        counter++;
                    }
                    while (chars.containsKey(counter)) {
                        System.out.println("R:" + counter + ":" + chars.get(counter));
                        chars.remove(counter);
                        counter++;
                    }
                }
            } catch (Exception e) {
                System.out.println("Z2Receiver.ReceiverThread.run: " + e);
            }
        }

    }

    class SendConfirmationThread extends Thread {

        public void run() {
            try {
                long sTime = System.currentTimeMillis();
                while (!deliver) {
                    long eTime = System.currentTimeMillis() - sTime;
                    if ((counter + 1) * 500 + 5000 < eTime) {
                        //System.out.println("Brakuje " + counter);
                        Z2Packet s = new Z2Packet(4 + 1);
                        s.setIntAt(counter, 0);
                        s.data[4] = (byte) 'x';
                        DatagramPacket miss = new DatagramPacket(s.data, s.data.length, localHost, destinationPort);
                        socket.send(miss);
                        sTime = System.currentTimeMillis();
                    }
                }

            } catch (Exception e) {
                System.out.println("Z2Receiver.SendConfirmationThread.run: " + e);
            }
        }
    }

    public static void main(String[] args)
            throws Exception {
        Z2Receiver receiver = new Z2Receiver(Integer.parseInt(args[0]),
                Integer.parseInt(args[1]));
        receiver.receiver.start();
        receiver.sender.start();
    }

}

