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
public class ServerThread extends Thread implements ClockListener {
    ServerSocket serverSocket;
    Socket socket;
    PrintWriter output;
    Clock clock;
    int port = 10000;
    int id;
    
    public ServerThread(int id, Clock clock) {
        this.id = id;
        this.port += this.id;
        this.clock = clock;
        clock.addListener(this);
    }
    
    @Override 
    public void run() {
        try {
            serverSocket = new ServerSocket(port);
            socket = serverSocket.accept();
            System.out.println("Conectado");
            output = new PrintWriter(socket.getOutputStream(), true);
        } catch(IOException e) {
            System.err.println(e);
        }
    }

    @Override
    public void updateTime(String time) {
        if (socket != null)
            output.println(time + ":" + clock.speed);
    }
}
