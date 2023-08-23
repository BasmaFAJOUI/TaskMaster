/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.javamaster.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;



import com.javamaster.config.DBConnectionConfig;
import com.javamaster.model.UsersModel;
import java.sql.SQLException;

/**
 *
 * @author hp
 */
public class Usersdao {
    public static Usersdao instance;
    private Usersdao(){
   
    }
    public static synchronized Usersdao getInstance(){
        if (instance == null){
            instance=new Usersdao();
           
        }
        return instance;
    }
    public void save(UsersModel user) throws SQLException{
        Connection connection = DBConnectionConfig.getConnection();
        PreparedStatement pr;
        pr = connection.prepareStatement("insert into users(email,password,name) values (?,?,?)");
        pr.setString(1,user.getEmail());
        pr.setString(2,user.getPassword());
        pr.setString(3,user.getPassword());
        pr.executeUpdate(); 

                
    }
}
