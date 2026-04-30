package com.student;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Reads DB credentials from Azure App Service environment variables,
 * falling back to local defaults for development.
 */
public class DBConnection {

    private static final String URL  = getEnv("DB_URL",
            "jdbc:mysql://localhost:3306/studentdb?useSSL=false&serverTimezone=UTC");
    private static final String USER = getEnv("DB_USER", "root");
    private static final String PASS = getEnv("DB_PASSWORD", "root");

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    private static String getEnv(String key, String fallback) {
        String value = System.getenv(key);
        return (value != null && !value.isEmpty()) ? value : fallback;
    }
}
