package controller;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.SessionMap;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import BBDD.Conexion;
import model.Cliente;

public class loginController extends ActionSupport{
	private static final long serialVersionUID=1L;
	
	//Variables
	private String user;
	private String pass;
	private String msg;
	private Cliente c=new Cliente();

	//Para conectar a la base de datos
	Conexion conexion=new Conexion();
	
	public String execute() throws SQLException{
		PreparedStatement ps=conexion.conn.prepareStatement("SELECT * FROM cliente "
				+ "WHERE strUser='"+user+"' AND strPass='"+pass+"'");
		
		ResultSet rs=ps.executeQuery();
		
		//Si existe el usuario y la contraseña sea correcta.
		if(rs.next()) {
			c.setId(rs.getInt("idCliente"));
			c.setDni(rs.getString("strDNI"));
			c.setUser(rs.getString("strUser"));
			c.setNombre(rs.getString("strNombre"));
			c.setApellidos(rs.getString("strApellidos"));
			c.setEmail(rs.getString("strEmail"));
			c.setProvincia(rs.getString("strProvincia"));
			c.setDir(rs.getString("strDir"));
			c.setTel(rs.getInt("intTelefono"));
			c.setCp(rs.getInt("intCP"));
			Map session = ActionContext.getContext().getSession();
			session.put("Usuario", c);
			return SUCCESS;
		}
		else {
			msg="El usuario o la contraseña son incorrectos.";
			return ERROR;
		}
	}
	
	public String logOut() {
		Map session = ActionContext.getContext().getSession();
		session.remove("Usuario");
		return "success";
	}
	
	//Getters y setters
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Cliente getC() {
		return c;
	}

	public void setC(Cliente c) {
		this.c = c;
	}

	
	
}
