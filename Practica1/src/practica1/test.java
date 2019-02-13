/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package practica1;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;



/**
 *
 * @author mary_
 */
public class test {

    public static void main(String[] args) {
        Calendar calendario = new GregorianCalendar();
        Date fechaHoraActual = new Date();
        calendario.setTime(fechaHoraActual);
        
        int hora, minutos, segundos;
        hora =calendario.get(Calendar.HOUR_OF_DAY);
        minutos = calendario.get(Calendar.MINUTE);
        segundos = calendario.get(Calendar.SECOND);
        System.out.println(hora + ":" + minutos + ":" + segundos);
        ControlClock clock = new ControlClock();
        
        hora=clock.getHora();
        minutos=clock.getMinutos();
        segundos=clock.getSegundos();
        System.out.println(hora + ":" + minutos + ":" + segundos);
        
    }
}
