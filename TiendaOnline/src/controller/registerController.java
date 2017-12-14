package controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import BBDD.Conexion;
import model.Cliente;

public class registerController extends ActionSupport{
	private static final long serialVersionUID=1L;
	
	//Variables
	private Cliente u=new Cliente();
	private String msg;
	private String valor;
	
	//Para conectar a la base de datos
		Conexion conexion=new Conexion();
	
	public String execute() throws SQLException {
		PreparedStatement ps=conexion.conn.prepareStatement("INSERT INTO cliente(strDNI, strUser, strPass, strNombre, strApellidos, strEmail, strProvincia, strDir, intTelefono, intCP) \r\n" + 
				"VALUES (?,?,?,?,?,?,?,?,?,?)");
		
		ps.setString(1, u.getDni());
		ps.setString(2, u.getUser());
		ps.setString(3, u.getPass());
		ps.setString(4, u.getNombre());
		ps.setString(5, u.getApellidos());
		ps.setString(6, u.getEmail());
		ps.setString(7, u.getProvincia());
		ps.setString(8, u.getDir());
		ps.setInt(9, u.getTel());
		ps.setInt(10, u.getCp());
		
		if(ps.executeUpdate()==1) {
			return SUCCESS;
		}
		else {
			msg="No se ha registrado correctamente, vuelve a intentarlo.";
			return ERROR;
		}
	}
	
	//Existe usuario
	public void existUser() throws SQLException, IOException {
		HttpServletResponse response= ServletActionContext.getResponse();
		response.setContentType("text/plain;charset=utf-8");
		PrintWriter out=response.getWriter();
		
		PreparedStatement ps=conexion.conn.prepareStatement("SELECT * FROM cliente WHERE strUser=?");
		ps.setString(1, valor);
		
		ResultSet rs=ps.executeQuery();
		if(rs.next()) {
			out.println("Existe el nombre de usuario.");
			out.flush();
		}
	}
	
	//Existe DNI
	public void existDNI() throws SQLException, IOException {
		HttpServletResponse response= ServletActionContext.getResponse();
		response.setContentType("text/plain;charset=utf-8");
		PrintWriter out=response.getWriter();
		
		PreparedStatement ps=conexion.conn.prepareStatement("SELECT * FROM cliente WHERE strDNI=?");
		ps.setString(1, valor);
		
		ResultSet rs=ps.executeQuery();
		if(rs.next()) {
			out.println("Existe el DNI.");
			out.flush();
		}
	}
	
	//Existe email
		public void existEmail() throws SQLException, IOException {
			HttpServletResponse response= ServletActionContext.getResponse();
			response.setContentType("text/plain;charset=utf-8");
			PrintWriter out=response.getWriter();
			
			PreparedStatement ps=conexion.conn.prepareStatement("SELECT * FROM cliente WHERE strEmail=?");
			ps.setString(1, valor);
			
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				out.println("Existe el correo electrónico.");
				out.flush();
			}
		}

	//Getters y setters
	public Cliente getU() {
		return u;
	}

	public void setU(Cliente u) {
		this.u = u;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getValor() {
		return valor;
	}

	public void setValor(String valor) {
		this.valor = valor;
	}
	
	
}
