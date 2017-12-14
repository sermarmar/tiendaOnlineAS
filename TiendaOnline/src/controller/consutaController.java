package controller;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import BBDD.Conexion;
import model.Producto;
import model.Provincia;
import model.Cliente;
import model.Factura;

public class consutaController extends ActionSupport{
	private static final long serialVersionUID=1L;
	
	//Variables
	private static ArrayList<Producto> productos= null;
	private static ArrayList<Provincia> provincias=null;
	private static ArrayList<Factura> facturas=null;
	private Map<String, Object> jsonData=new HashMap<String,Object>();
	
	//Para mostrar los productos en la página principal
	public static ArrayList<Producto> mostrarProductos() throws SQLException{
		//Para conectar a la base de datos
		Conexion con=new Conexion();
		productos=new ArrayList<Producto>();
		PreparedStatement ps=con.conn.prepareStatement("SELECT * FROM producto");
		
		ResultSet rs=ps.executeQuery();
		while(rs.next()) {
			Producto producto=new Producto();
			producto.setId(rs.getInt("idProducto"));
			producto.setNombre(rs.getString("strNombre"));
			producto.setPrecio(rs.getDouble("dbPrecio"));
			producto.setDescripcion(rs.getString("strDescripcion"));
			producto.setCategoria(rs.getString("categoria"));
			producto.setCantidad(rs.getInt("intCantidad"));
			producto.setImagen(rs.getString("imagen"));
			productos.add(producto);
		}
		
		ps.close();
		
				
		return productos;
	}
	
	//Para mostrar las líneas de productos en la factura
	public static ArrayList<Producto> mostrarListaCompras() throws SQLException{
		Conexion con=new Conexion();
		productos=new ArrayList<Producto>();
		
		Map session = ActionContext.getContext().getSession();
		Cliente sesion=(Cliente)session.get("Usuario");
		int id=sesion.getId();
		
		PreparedStatement ps=con.conn.prepareStatement("SELECT * FROM linea_compra cp\r\n" + 
				"INNER JOIN producto p ON p.idProducto=cp.idProducto\r\n" + 
				"INNER JOIN factura f ON f.idFactura=cp.idFactura\r\n" + 
				"WHERE f.idUsuario="+id+" AND f.strEstado='Reservado'");
		
		ResultSet rs=ps.executeQuery();
		while(rs.next()) {
			Producto producto=new Producto();
			producto.setId(rs.getInt("idLinea"));
			producto.setNombre(rs.getString("strNombre"));
			producto.setPrecio(rs.getDouble(5));
			producto.setCantidad(rs.getInt(4));
			producto.setImagen(rs.getString("imagen"));
			productos.add(producto);
		}
		ps.close();
		
		return productos;
	}
	
	//Mostrar la cesta antes de hacer la factura de verdad.
	public String crearFactura() throws SQLException {
		Conexion con=new Conexion();
		productos=new ArrayList<Producto>();
		
		Map session = ActionContext.getContext().getSession();
		Cliente sesion=(Cliente)session.get("Usuario");
		int id=sesion.getId();
		
		PreparedStatement ps=con.conn.prepareStatement("SELECT * FROM linea_compra cp\r\n" + 
				"INNER JOIN producto p ON p.idProducto=cp.idProducto\r\n" + 
				"INNER JOIN factura f ON f.idFactura=cp.idFactura\r\n" + 
				"WHERE f.idUsuario="+id+" AND f.strEstado='Reservado'");
		
		ResultSet rs=ps.executeQuery();
		while(rs.next()) {
			Producto producto=new Producto();
			producto.setId(rs.getInt("idLinea"));
			producto.setNombre(rs.getString("strNombre"));
			producto.setPrecio(rs.getDouble(5));
			producto.setCantidad(rs.getInt(4));
			producto.setImagen(rs.getString("imagen"));
			productos.add(producto);
		}
		jsonData.put("productos", productos);
		ps.close();
		return SUCCESS;
	}
	
	//Select de provincias
	public static ArrayList<Provincia> mostrarProvincias() throws SQLException{
		Conexion con=new Conexion();
		provincias=new ArrayList<Provincia>();
			
		PreparedStatement ps=con.conn.prepareStatement("SELECT * FROM provincias");
			
		ResultSet rs=ps.executeQuery();
		while(rs.next()) {
			Provincia provincia=new Provincia();
			provincia.setId(rs.getInt("id"));
			provincia.setNombre(rs.getString("provincia"));
			provincias.add(provincia);
		}
		ps.close();
			
		return provincias;
	}


	//Mostras las facturas
	public static ArrayList<Factura> mostrarFacturas() throws SQLException{
		Conexion con=new Conexion();
		
		Map session = ActionContext.getContext().getSession();
		Cliente cliente=(Cliente) session.get("Usuario");
		int id=cliente.getId();
		
		facturas=new ArrayList<Factura>();
		
		PreparedStatement ps=con.conn.prepareStatement("SELECT * FROM factura WHERE idUsuario="+id+" AND strEstado='Comprado'");
		ResultSet rs=ps.executeQuery();
		
		while(rs.next()) {
			Factura f=new Factura();
			f.setId(rs.getInt("idFactura"));
			f.setFecha(rs.getString("fecha"));
			f.setPago(rs.getString("strPago"));
			f.setPrecioTotal(rs.getDouble("dbPrecioTotal"));
			
			PreparedStatement ln=con.conn.prepareStatement("SELECT * FROM linea_compra lc\r\n" + 
					"INNER JOIN producto p ON p.idProducto=lc.idProducto\r\n" + 
					"WHERE idFactura="+rs.getInt("idFactura"));
			ResultSet rLc=ln.executeQuery();
			productos=new ArrayList<Producto>();
			
			while(rLc.next()) {
				Producto p=new Producto();
				p.setId(rLc.getInt(1));
				p.setNombre(rLc.getString(7));
				p.setPrecio(rLc.getDouble(5));
				p.setCantidad(rLc.getInt(4));
				p.setImagen(rLc.getString("imagen"));
				productos.add(p);
			}
			f.setProductos(productos);
			facturas.add(f);
		}
		
		return facturas;
	}
	
	//Mostrar su propio perfil
	public static Cliente perfil() throws SQLException {
		Conexion con=new Conexion();
		Cliente c=new Cliente();
		Map session = ActionContext.getContext().getSession();
		Cliente cliente=(Cliente) session.get("Usuario");
		int id=cliente.getId();
		
		PreparedStatement ps=con.conn.prepareStatement("SELECT * FROM cliente WHERE idCliente="+id);
		ResultSet rs=ps.executeQuery();
		if(rs.next()) {
			c.setDir(rs.getString("strDir"));
			c.setTel(rs.getInt("intTelefono"));
			c.setCp(rs.getInt("intCP"));
			c.setEmail(rs.getString("strEmail"));
			c.setProvincia(rs.getString("strProvincia"));
		}
		
		return c;
	}
	
	//Getters y setters
	public Map<String, Object> getJsonData() {
		return jsonData;
	}

	public void setJsonData(Map<String, Object> jsonData) {
		this.jsonData = jsonData;
	}
}
