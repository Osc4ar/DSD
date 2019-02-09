/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package practica1;

/**
 *
 * @author oscar
 */
public class Clock extends Thread {
    ClockListener listener;
    int sec, min, hours;
    String time;
    
    public Clock(ClockListener listener) {
        this.listener = listener;
    }
    
    @Override
    public void run() {
        try {
            while(true) {
                Thread.sleep(1000);
                sec++;
                listener.updateTime("" + sec);
            }
        } catch (InterruptedException ie) {
            ie.printStackTrace();
        }
    }
}
