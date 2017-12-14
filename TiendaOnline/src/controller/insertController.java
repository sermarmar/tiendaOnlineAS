package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;

import BBDD.Conexion;
import model.Producto;
import model.Cliente;

public class insertController extends ActionSupport{
	private static final long serialVersionUID=1L;
	
	//Variables
	private int idUser;
	private int idProd;
	private double precio;
	private Map<String, Object> jsonData=new HashMap<String,Object>();
	/*private Producto p=new Producto();
	private ArrayList<Producto> productos=new ArrayList<Producto>();
	private Map<ArrayList<Producto>, Object> cesta;
	private String json;*/
	
	//Conectar
	Conexion conexion=new Conexion();
	
	//Insertar a la cesta
	public String insertCesta() throws SQLException, IOException {
		
		//Encuentra si existe la factura del cliente
		PreparedStatement ps=conexion.conn.prepareStatement("SELECT * FROM factura WHERE idUsuario="+idUser+" AND strEstado='Reservado'");
		ResultSet rs=ps.executeQuery();
		
		if(rs.next()) {
			PreparedStatement co=conexion.conn.prepareStatement("SELECT * FROM linea_compra lc\r\n" + 
					"INNER JOIN factura f ON f.idFactura=lc.idFactura\r\n" + 
					"WHERE idProducto=? AND f.idFactura=?");
			co.setInt(1, idProd);
			co.setInt(2, rs.getInt("idFactura"));
			
			ResultSet com=co.executeQuery();
			if(com.next()) {
				co=conexion.conn.prepareStatement("UPDATE linea_compra SET intCantidad=intCantidad+1, dbPrecioUds=intCantidad*? WHERE idLinea=?");
				co.setDouble(1, precio);
				co.setInt(2, com.getInt("idLinea"));
				co.executeUpdate();
			}
			else {
				PreparedStatement ins=conexion.conn.prepareStatement("INSERT INTO linea_compra (idFactura,idProducto,dbPrecioUds) VALUES (?,?,?)");
				ins.setInt(1, rs.getInt("idFactura"));
				ins.setInt(2, idProd);
				ins.setDouble(3, precio);
				
				ins.executeUpdate();
			
			}
		}
		else {
			
			//Crea una nueva factura reservada
			PreparedStatement in=conexion.conn.prepareStatement("INSERT INTO factura (idUsuario) VALUES (?)");
			in.setInt(1, idUser);
			
			in.executeUpdate();
			
			//Se añade el producto a la línea con existencia de factura
			PreparedStatement fc=conexion.conn.prepareStatement("SELECT idFactura FROM factura WHERE idUsuario="+idUser+" AND strEstado='Reservado'");
			ResultSet fila=fc.executeQuery();
			
			if(fila.next()) {
				
				PreparedStatement cp=conexion.conn.prepareStatement("INSERT INTO linea_compra (idFactura,idProducto,dbPrecioUds) VALUES (?,?,?)");
				
				cp.setInt(1, fila.getInt("idFactura"));
				cp.setInt(2, idProd);
				cp.setDouble(3, precio);
				
				
				cp.executeUpdate();
			}
		}
		//Mostrar los productos dentro de la cesta
		ArrayList<Producto> productos=new ArrayList<Producto>();
		PreparedStatement cont=conexion.conn.prepareStatement("SELECT * FROM linea_compra lc\r\n" + 
				"INNER JOIN factura f ON f.idFactura= lc.idFactura\r\n" + 
				"INNER JOIN producto p ON p.idProducto=lc.idProducto\r\n" + 
				"WHERE f.strEstado='Reservado' AND f.idUsuario="+idUser);
		
		ResultSet cp=cont.executeQuery();
		while(cp.next()) {
			Producto producto=new Producto();
			producto.setId(cp.getInt("idLinea"));
			producto.setNombre(cp.getString("strNombre"));
			producto.setPrecio(cp.getDouble(5));
			producto.setCantidad(cp.getInt(4));
			producto.setImagen(cp.getString("imagen"));
			productos.add(producto);
		}
		cp.close();
		
		ResultSet num=cont.executeQuery();
		jsonData.put("productos", productos);
		return SUCCESS;
	}
	
	public void contarProductos() throws IOException, SQLException {
		HttpServletResponse response= ServletActionContext.getResponse();
		response.setContentType("text/plain;charset=utf-8");
		PrintWriter out=response.getWriter();
		
		Map session = ActionContext.getContext().getSession();
		Cliente sesion=(Cliente)session.get("Usuario");
		int id=sesion.getId();
		
		//Cuenta las líneas de compras
		PreparedStatement cont=conexion.conn.prepareStatement("SELECT count(*) FROM linea_compra lc\r\n" + 
				"INNER JOIN factura f ON f.idFactura= lc.idFactura\r\n" + 
				"WHERE f.strEstado='Reservado' AND f.idUsuario="+id);
		ResultSet num=cont.executeQuery();
		
		if(num.next()) {
			out.println(num.getInt(1));
			out.flush();
		}
	}
	
	//Getters y setters
	public int getIdUser() {
		return idUser;
	}

	public void setIdUser(int idUser) {
		this.idUser = idUser;
	}

	public int getIdProd() {
		return idProd;
	}

	public void setIdProd(int idProd) {
		this.idProd = idProd;
	}

	public double getPrecio() {
		return precio;
	}

	public void setPrecio(double precio) {
		this.precio = precio;
	}
	public Map<String, Object> getJsonData() {
		return jsonData;
	}
	public void setJsonData(Map<String, Object> jsonData) {
		this.jsonData = jsonData;
	}

	
	
	
	
}
