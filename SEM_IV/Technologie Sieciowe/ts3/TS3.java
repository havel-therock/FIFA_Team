/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ts3;

/**
 *
 * @author jakub
 */
public class TS3 {

    static int[] cable;
    public static int[] signal;
    static int cableSize;

    public static void main(String[] args) {
        cableSize = 21;
        cable = new int[cableSize];
        signal = new int[cableSize];
        Cable c = new Cable();
        for (int i = 0; i < cableSize-1; i++) {
            cable[i]=0;
        }
        Transmitter t1 = new Transmitter(0);
        Transmitter t2 = new Transmitter(10);
        Transmitter t3 = new Transmitter(18);
        Transmitter t4 = new Transmitter(5);
        Transmitter t5 = new Transmitter(15);
        c.start();
        //t2.start();
        //t3.start();
        t1.start();
        t4.start();
        //  t5.start();

    }
}
