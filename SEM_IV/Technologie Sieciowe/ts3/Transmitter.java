package ts3;

import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import static ts3.TS3.cable;
import static ts3.TS3.cableSize;
import static ts3.TS3.signal;

/**
 *
 * @author jakub
 */
public class Transmitter extends Thread {

    int id, size, failedTransmissions;
    private Thread thread;
    Random rand = new Random();
    boolean deliver = false;

    public Transmitter(int id) {
        this.id = id;
    }

    @Override
    public void start() {
        thread = new Thread(this, "Node");
        System.out.println("Startuje nadajnik " + (id + 1));
        thread.start();

    }

    @Override
    public void run() {
        while (!deliver) {
            try {
                if (freeCable()) {
                    signal[id] = ((cableSize - 1) * 2) - 1;
                    System.out.println("Nadaje sygnał nadajnik " + (id + 1));
                    boolean transmiting = true;
                    while (transmiting) {
                        //  System.out.println("długośc  " + signal[id]);
                        sleep(100);
                        if (signal[id] <= 1) {
                            System.out.println("Dostarczono");
                            transmiting = false;
                            deliver();
                        } else if (cable[id] > id + 1) {
                            System.out.println("JAM!!");
                            transmiting = false;
                            collision();

                        }
                    }
                } else {
                    System.out.println("Czekam na wolną linię | nadajnik- " + (id + 1));
                    this.sleep(500);
                }

            } catch (InterruptedException ex) {
                Logger.getLogger(Transmitter.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private void collision() throws InterruptedException {
        failedTransmissions++;
        signal[id] = 0;
        System.out.println("Kolizja nr " + failedTransmissions + " || " + (id + 1));
        if (failedTransmissions < 10) {
            this.sleep((rand.nextInt(10) + 1) * failedTransmissions * 100);
        } else if (failedTransmissions < 16) {
            this.sleep((rand.nextInt(10) + 1) * 100);
        } else {
            System.out.println("[ " + id + " ] - 16 kolizji pod rząd -> Węzeł kończy wysyłanie.");
            deliver = true;
            return;
        }
    }

    private void transmit() throws InterruptedException {

        if (freeCable()) {
            signal[id] = (cableSize - 1) * 2;
            System.out.println("Nadaje sygnał nadajnik " + (id + 1));

            while (signal[id] > 0) {
                if (signal[id] == 1) {
                    deliver();
                    return;
                } else if (cable[id] > id + 1) {
                    collision();
                    return;
                }
            }
        } else {
            System.out.println("Czekam na wolną linię | nadajnik- " + (id + 1));
            this.sleep(100);
            transmit();
        }
    }

    private void deliver() {
        signal[id] = 0;
        System.out.println("Dostarczono nadajnik " + (id + 1));
        deliver = true;
    }

    private boolean freeCable() {
        return cable[id] != 0 ? false : true;
    }
}
