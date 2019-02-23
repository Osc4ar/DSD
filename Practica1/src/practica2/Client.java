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

/**
 *
 * @author oscar
 */
public class Client extends Thread {
    
    //Para pruebas
    String ip = "127.0.0.1";
    int port = 10000;
    BufferedReader input;
    Socket socket;
    
    public Client() {
        
    }
    
    public void createConnection() {
        try {
            socket = new Socket(ip, port);
            input = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            while(true) {
                String time = input.readLine();
                System.out.println(time);
            }
        } catch (IOException ioe) {
            System.err.println(ioe);
        }
    }
    
    @Override 
    public void run() {
        createConnection();
    }
    
    public static void main(String[] args) {
        Client client = new Client();
        client.start();
    }
}
