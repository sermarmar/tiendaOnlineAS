package BBDD;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
	public static final String USERNAME="tienda", 
			 PASSWORD="", 
			 HOST="localhost", 
			 PORT="3306", 
			 DATABASE="tiendaonline",
			 CLASSNAME="com.mysql.jdbc.Driver",
			 URL="jdbc:mysql://"+HOST+":"+PORT+"/"+DATABASE+"?useSSL=false";
	 
	 public Connection conn;	
	 
	 public Conexion(){
		 try {
		     Class.forName(CLASSNAME);		     
		     conn=(Connection) DriverManager.getConnection(URL, USERNAME, PASSWORD);          
		 } catch (ClassNotFoundException | SQLException ex) {			
			ex.printStackTrace();
		 }                
	 }
}
