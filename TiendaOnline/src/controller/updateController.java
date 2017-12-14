package controller;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.opensymphony.xwork2.ActionSupport;

import BBDD.Conexion;
import model.Cliente;

public class updateController extends ActionSupport{
	private static final long serialVersionUID=1L;
	
	//Variables
	private int idFactura;
	private int idLinea;
	private String pago;
	private double precioTotal;
	private int cantidad;
	private Cliente c=new Cliente();
	
	//Conectar a BBDD
	Conexion conexion=new Conexion();
	
	//Hacer la factura completa
	public String pagar() throws SQLException {
		PreparedStatement ps=conexion.conn.prepareStatement("UPDATE factura SET dbPrecioTotal=?, strPago=?, strEstado='Comprado' WHERE idUsuario=? AND strEstado='Reservado'");
		
		ps.setDouble(1, precioTotal);
		ps.setString(2, pago);
		ps.setInt(3, idFactura);
		
		ps.executeUpdate();
		
		return "success";
	}
	
	//Editar su dirección
	public String editarDir() throws SQLException {
		PreparedStatement ps=conexion.conn.prepareStatement("UPDATE cliente \r\n" + 
				"SET strEmail=?, strProvincia=?, strDir=?, intTelefono=?, intCP=? WHERE idCliente=?");
		
		ps.setString(1, c.getEmail());
		ps.setString(2, c.getProvincia());
		ps.setString(3, c.getDir());
		ps.setInt(4, c.getTel());
		ps.setInt(5, c.getCp());
		ps.setInt(6, c.getId());
		
		ps.executeUpdate();
		
		return "success";
	}

	//Cambiar cantidad
	public void changeCant() throws SQLException {
		PreparedStatement ps=conexion.conn.prepareStatement("UPDATE linea_compra SET intCantidad=? WHERE idLinea=?");
		
		ps.setInt(1, cantidad);
		ps.setInt(2, idLinea);
		
		ps.executeUpdate();
	}
	
	//Getters y setters
	public int getIdFactura() {
		return idFactura;
	}

	public void setIdFactura(int idFactura) {
		this.idFactura = idFactura;
	}

	public String getPago() {
		return pago;
	}

	public void setPago(String pago) {
		this.pago = pago;
	}

	public double getPrecioTotal() {
		return precioTotal;
	}

	public void setPrecioTotal(double precioTotal) {
		this.precioTotal = precioTotal;
	}
	public int getIdLinea() {
		return idLinea;
	}

	public void setIdLinea(int idLinea) {
		this.idLinea = idLinea;
	}

	public int getCantidad() {
		return cantidad;
	}

	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}

	public Cliente getC() {
		return c;
	}

	public void setC(Cliente c) {
		this.c = c;
	}
	
}
