/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package practica1;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
*/
import java.util.Date;
import java.util.GregorianCalendar;
import java.text.SimpleDateFormat;
/**
 *
 * @author oscar
 */
public class Clock extends Thread {
    ClockListener listener;
    int sec, min, hours;
    String time;
    Date localTime;
    GregorianCalendar calendar;
    
    
    public Clock(ClockListener listener, boolean flag) {
        this.listener = listener;
        localTime = new Date();
        calendar =  new GregorianCalendar();
        if (flag){//true == random time
            sec = (int)(Math.random()*60);
            min = (int)(Math.random()*60);
            hours = (int)(Math.random()*24);
            localTime.setHours(hours);
            localTime.setMinutes(min);
            localTime.setSeconds(sec);
        }
        calendar.setTime(localTime);
    }
    
    public String formatTime(){
        SimpleDateFormat ft = new SimpleDateFormat("HH:mm:ss");
        time = ft.format(calendar.getTime());
        return time;
    }
     
    @Override 
    public void run() {
        try { 
            while(true) {
                Thread.sleep(1000/2);
                calendar.add(GregorianCalendar.SECOND, 1);
                listener.updateTime(formatTime());
            }
        } catch (InterruptedException ie) {
            ie.printStackTrace();
        }
    }
}

