<%@page import="model.Producto"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="controller.consutaController"%>
<%@page import="model.Factura"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<%
	//Variables
	ArrayList<Factura> facturas=new ArrayList<Factura>();	
	
	NumberFormat nf = NumberFormat.getCurrencyInstance(Locale.getDefault());
%>

<s:if test="%{#session.Usuario!=null}">
	<%
		facturas=consutaController.mostrarFacturas();
	%>
</s:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>NetShop - Facturas</title>
</head>
<body>
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Tienda Online</title>
	<%@ include file="/includes/head.jsp"%>
	
</head>
<body>
	<nav class="navbar navbar-default" data-spy="affix" data-offset-top="250">
		<div class="container-fluid">
			<div class="navbar-header">
				<s:if test="%{#session.Usuario!=null}">
		    		<a class="navbar-brand" href="index.jsp"><s:property value="%{#session.Usuario.nombre}"/> <s:property value="%{#session.Usuario.apellidos}"/></a>
		    	</s:if>
		    	<s:else>
		    		<a class="navbar-brand" href="index.jsp">Tienda Online</a>
		    	</s:else>
		    </div>
			<!-- <ul class="nav navbar-nav">
		    	<li class="active"><a href="#"></a></li>
		      	<li><a href="#">Page 1</a></li>
		      	<li><a href="#">Page 2</a></li>
		      	<li><a href="#">Page 3</a></li>
		    </ul>  -->
		    <ul class="nav navbar-nav navbar-right">
		    	<s:if test="%{#session.Usuario!=null}">
		    		<li>
		    			<a href="index.jsp">Home</a>
		    		</li>
					<li>
						<a href="perfil.jsp">Perfil</a>
					</li>
					<li>
						<a href="facturas.jsp">Facturas</a>
					</li>
					<li>	
						<a href="logout">Cerrar sesión</a>
					</li>
				</s:if>
				<s:else>
					<li>
						<form class="form-inline" action="login" method="post" enctype="multipart/form-data">
					    	<div class="input-group">
								<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
								<input id="user" type="text" class="form-control" name="user" placeholder="Escribe usuario" required>
							</div>
							<div class="input-group">
								<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
								<input id="pass" type="password" class="form-control" name="pass" placeholder="Escbrila la contraseña" required>
							</div>
								<input class="btn btn-primary" type="submit" id="enviar" value="Entrar">
					    </form>
				    </li>
				    <li>
					    <a href="registro.jsp"><span class="glyphicon glyphicon-user"></span></a>
					</li>
				</s:else>
		    </ul>
		    
		</div>
	</nav>

	<div class="container">
		<% for (Factura factura:facturas){%>
			<div class="panel panel-default">
				<div class="panel-heading">
					<table class="facturas">
						<tr>
							<td>NºPedido: <%= factura.getId()%></td>
							<td>Fecha de pago: <%= factura.getFecha()%></td>
							<td>Método de pago: <%= factura.getPago()%></td>
							<td>Precio: <%= nf.format(factura.getPrecioTotal())%></td>
						</tr>
					</table>
				</div>
				<div class="panel-body">
					<table class="table table-bordered">
						<th>Imagen</th>
						<th>Nombre</th>
						<th>Cantidad</th>
						<th>Precio</th>
					<% 
					ArrayList<Producto> productos=new ArrayList<Producto>();
					productos=factura.getProductos();
					for(Producto producto:productos){%>
						<tr>
							<td><img src="<%= producto.getImagen()%>"  width="100px"></td>
							<td><%= producto.getNombre()%></td>
							<td><%= producto.getCantidad()%></td>
							<td><%= nf.format(producto.getPrecio())%></td>
						</tr>
					<% }
					%>
					</table>
				</div>
			</div>
		<% }%>
	</div>
	
</body>
</html>
</body>
</html>