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
import java.util.GregorianCalendar;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
/**
 *
 * @author oscar
 */
public class Clock extends Thread {
    ArrayList<ClockListener> listeners;
    int sec, min, hours;
    public volatile double speed = 1;
    String time;
    GregorianCalendar calendar;
    SimpleDateFormat ft;
    
    
    public Clock(boolean randomTime) {
        this.listeners = new ArrayList<ClockListener>();
        ft = new SimpleDateFormat("HH:mm:ss");
        calendar =  new GregorianCalendar();
        if (randomTime) {
            sec = (int)(Math.random()*60);
            min = (int)(Math.random()*60);
            hours = (int)(Math.random()*24);
            setTime(hours, min, sec);
        }
    }
    
    public void addListener(ClockListener listener) {
        listeners.add(listener);
    }
    
    public void sendUpdate() {
       time = getFormattedTime();
       for(ClockListener listener : listeners)
            listener.updateTime(time);
    }
    
    public void setTime(int hours, int min, int sec) {
        calendar.set(Calendar.HOUR_OF_DAY, hours);
        calendar.set(Calendar.MINUTE, min);
        calendar.set(Calendar.SECOND, sec);
    }
    
    public void setTime(String time) {
        String[] clockData = time.split(":");
        int hours = Integer.parseInt(clockData[0]);
        int min = Integer.parseInt(clockData[1]);
        int sec = Integer.parseInt(clockData[2]);
        this.speed = Double.parseDouble(clockData[3]);
        setTime(hours, min, sec);
    }
    
    public String getFormattedTime() {
        time = ft.format(calendar.getTime());
        return time;
    }
     
    @Override 
    public void run() {
        try { 
            while(true) {
                if(speed != 0) {
                    Thread.sleep(Math.round(1000 / speed));
                    calendar.add(GregorianCalendar.SECOND, 1);
                    sendUpdate();
                }
            }
        } catch (InterruptedException ie) {
            ie.printStackTrace();
        }
    }
}

