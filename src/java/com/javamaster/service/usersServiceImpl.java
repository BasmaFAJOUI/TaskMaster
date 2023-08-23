
package com.javamaster.service;

import com.javamaster.dao.Usersdao;
import com.javamaster.model.UsersModel;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class usersServiceImpl implements usersService{
    private static usersServiceImpl instance;
    private usersServiceImpl(){

}
    public static synchronized usersServiceImpl getInstance(){
        if (instance==null){
            instance = new usersServiceImpl();
        }
    
return instance;}

    @Override
    public void register(String email, String password, String name) {
        UsersModel user = new UsersModel();
        user.setEmail(email);
        user.setName(name);
        user.setPassword(password);
        try {
            Usersdao.getInstance().save(user);
        } catch (SQLException ex) {
            Logger.getLogger(usersServiceImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
