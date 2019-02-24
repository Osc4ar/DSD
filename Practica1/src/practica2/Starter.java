/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package practica2;

/**
 *
 * @author oscar
 */
public class Starter {
    public static void main(String[] args) {
        new ServerUI().setVisible(true);
        for(int i = 0; i < 3; i++)
            new ClientUI().setVisible(true);
    }
}
