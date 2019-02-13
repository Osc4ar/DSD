/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package practica1;

public class ControlClock {
    

    private int hora;
    private int minutos;
    private int segundos;
    

    public ControlClock() {
        setHora(0);
        setMinutos(0);
        setSegundos(0);
    }
    
    public ControlClock(int hora, int minutos, int segundos) {
        setHora(hora);
        setMinutos(minutos);
        setSegundos(segundos);
    }
    
    public final void setHora(int hora) {
        this.hora = ((hora >= 0 && hora < 24) ? hora : 0);
    }
    
    public final void setMinutos(int minutos) {
        this.minutos = ((minutos >= 0 && minutos < 60) ? minutos : 0);
    }
    
    public final void setSegundos(int segundos) {
        this.segundos = ((segundos >= 0 && segundos < 60) ? segundos : 0);
    }
    
    public int getHora() {
        return hora;
    }
    
    public int getMinutos() {
        return minutos;
    }
    
    public int getSegundos() {
        return segundos;
    }
    
    public void incrementarSegundo() {
        incrementarSegundo();
    }
    
    public void incrementarSegundo(int segundos) {
        this.segundos += segundos;
        int minutos = this.segundos/60;
        
        if(minutos>0){
            incrementarMinuto(minutos);
            this.segundos %= 60;
        }
    }
    
    public void incrementarMinuto() {
        incrementarMinuto(1);
    }

    public void incrementarMinuto(int minutos) {
        this.minutos += minutos;
        int horas = this.minutos/60;
        
        if(horas>0){
            incrementarHora(horas);
            this.minutos %= 60;
        }
    }

    public void incrementarHora() {
        incrementarHora(1);
    }
    
    public void incrementarHora(int horas) {
        this.hora = (this.hora + horas) % 24;
    }

    public String darFormatoNumeros(int numero) {
      String numeroFormateado; 
      if (numero >= 0 && numero < 10) {
          numeroFormateado = "0" + numero;
      } else {
          numeroFormateado = numero + "";
      }
      return numeroFormateado;
    }
    
    
}