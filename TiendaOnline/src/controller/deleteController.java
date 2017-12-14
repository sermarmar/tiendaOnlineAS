package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import BBDD.Conexion;

public class deleteController extends ActionSupport{
	private static final long serialVersionUID=1L;
	
	//Variables
	private int id;
	
	Conexion conexion=new Conexion();

	public void removeLine() throws SQLException, IOException {
		HttpServletResponse response= ServletActionContext.getResponse();
		response.setContentType("text/plain;charset=utf-8");
		PrintWriter out=response.getWriter();
		
		PreparedStatement ps=conexion.conn.prepareStatement("DELETE FROM linea_compra\r\n" + 
				"WHERE idLinea="+id);
		
		if(ps.executeUpdate()==1) {
			out.println("Ha sido borrado con éxito.");
			out.flush();
		}
		else {
			out.println("No ha borrado con éxito.");
			out.flush();
		}
	}
	//Getters y setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
}
