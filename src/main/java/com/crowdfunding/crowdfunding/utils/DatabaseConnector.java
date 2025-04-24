package com.crowdfunding.crowdfunding.utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnector {
    public static Connection connect() throws Exception
    {
        String username = "root";
        String password = "123456789";
        String databaseName = "crowdfunding";
        String url = "jdbc:mysql://localhost:3306/"+databaseName;

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(url, username, password);
        System.out.println("Connection Established successfully");

        return con;
    }
}
