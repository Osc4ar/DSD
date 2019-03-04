/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package practica2;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;
import practica1.Clock;

/**
 *
 * @author oscar
 */
public class ClientThread extends Thread {
    
    //Para pruebas
    String ip = "127.0.0.1";
    int port = 10000;
    int id;
    BufferedReader input;
    Socket socket;
    Clock clock;
    
    public ClientThread(int id, Clock clock) {
        this.id = id;
        this.port += this.id;
        this.clock = clock;
    }
        
    @Override 
    public void run() {
        try {
            socket = new Socket(ip, port);
            input = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            while(true) {
                int i = 0;
                String time = input.readLine();
                clock.setTime(time);
                clock.sendUpdate();
            }
        } catch (IOException ioe) {
            System.err.println(ioe);
        }
    }
}
