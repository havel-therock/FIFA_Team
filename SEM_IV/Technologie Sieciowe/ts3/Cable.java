/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ts3;

import java.util.logging.Level;
import java.util.logging.Logger;
import static ts3.TS3.cable;
import static ts3.TS3.cableSize;
import static ts3.TS3.signal;

/**
 *
 * @author jakub
 */
public class Cable extends Thread {

    boolean transmit;

    @Override
    public void run() {
        try {
            while (true) {
                int i = 0;
                transmit = transmiting();//True jeśli nadajnik zaczął nadawać 
                if (transmit) {
                    //W kablu nadaje sygnał (nr nadajnika+1)  w miejscu nadajnika 
                    for (int k = 0; k < cableSize - 1; k++) {
                        if (signal[k] > 0) {
                            cable[k] = k + 1;
                            signal[k] -= 2;
                        }
                    }
                    //Przesówanie w prawo 
                    for (int j = 0; j < cableSize - 1; j++) {
                        //Jeśli nastąpiła interferencja fal (kolizja ) to nie wchodzę 
                        if (cable[j + 1] < 21 && cable[j] < 21) {
                            // Sytuacja  1 0 jeśli skończył nadawanie nadajnik 10-> 00
                            if (cable[j] != 0 && cable[j + 1] == 0) {
                                if (signal[cable[j] - 1] <= 1) {
                                    cable[j] = 0;
                                }
                            } //Propagacja sygnału 
                               //Przykład  05-> 55 
                               else if (cable[j] != cable[j + 1] && signal[cable[j + 1] - 1] > 0) {
                                    cable[j] += cable[j + 1];
                                } else if (cable[j] == j + 1) { //jesli jesteśmy w miejssu nadajnika
                                    if (signal[j] > 0) { //sprawdzamy czy jest jeszcze co wiadomośc do wysłania 
                                        cable[j] = j + 1;
                                    } else {
                                        cable[j] = 0; // jeśli nie ma wiadomości do wysłania 
                                    }
                                }
                             else  {
                                cable[j] = cable[j + 1]; 
                            }
                        } else {
                            cable[j] += cable[j + 1]; //w przypadku kolizji dalej rozsyłamy sygnał żeby poinformować każdy nadajnik 
                        }
                    }
                    print();
                    //to samo tylko w drugą mańkę 
                    for (int j = cableSize - 1; j > 0; j--) {
                        if (cable[j] < 21 && cable[j - 1] < 21) {
                            if (cable[j] != 0 && cable[j - 1] == 0) {
                                if (signal[cable[j] - 1] <= 1) {
                                    cable[j] = 0;
                                }
                            } else if (cable[j] != cable[j - 1] && signal[cable[j - 1] - 1] > 0) {
                                cable[j] += cable[j - 1];
                            } else if (cable[j] == j + 1) {
                                if (signal[j] > 0) {
                                    cable[j] = j + 1;
                                } else {
                                    cable[j] = 0;
                                }
                            }
                        } else {
                            cable[j] += cable[j - 1];
                        }

                    }
                    sleep(100);
                    print();
                } else {
                    for (i = 0; i < cableSize - 1; i++) {
                        cable[i] = 0;
                         print();
                        cable[cableSize - 1 - i] = 0;
                         print();
                         sleep(100);
                   
                    }
                   
                }
            }
        } catch (InterruptedException ex) {
            Logger.getLogger(Cable.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void print() {
        for (int i = 0; i < cableSize - 1; i++) {
            System.out.print(cable[i] + "-");
        }
        System.out.print(cable[cableSize - 1]);
        System.out.println("");
    }

    private boolean transmiting() {
        for (int i = 0; i < cableSize - 1; i++) {
            if (signal[i] > 0) {
                return true;
            }
        }
        return false;
    }

}
