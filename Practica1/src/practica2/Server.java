/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package practica2;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import practica1.Clock;
import practica1.ClockListener;

/**
 *
 * @author oscar
 */
public class Server extends Thread implements ClockListener {
    ServerSocket serverSocket;
    Socket socket;
    PrintWriter output;
    Clock clock;
    int port = 10000;
    
    public Server() {
        clock = new Clock(false);
        clock.start();
        clock.addListener(this);
        try {
            serverSocket = new ServerSocket(port);
        } catch (IOException e) {
            System.err.println(e);
        }
    }
    
    public void createConnection() {
        try {
            socket = serverSocket.accept();
            output = new PrintWriter(socket.getOutputStream(), true);
        } catch(IOException e) {
            System.err.println(e);
        }
    }
    
    @Override 
    public void run() {
        createConnection();
    }

    @Override
    public void updateTime(String time) {
        if (socket != null)
            output.println(time);
    }
    
    public static void main(String[] args) {
        Server server = new Server();
        server.start();
    }
}
