/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.javamaster.config;

//import com.sun.jdi.connect.spi.Connection;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;



/**
 *
 * @author hp
 */
public class DBConnectionConfig {
    public static Connection getConnection() throws SQLException{
        try {
        Class.forName("com.mysql.jdbc.Driver");
    }catch(ClassNotFoundException ex){
        Logger.getLogger(DBConnectionConfig.class.getName()).log(Level.SEVERE,null,ex );
    
}
        DriverManager.getConnection("jdbc:mysql://localhost/mysql","root","");
        return null;
    }

}