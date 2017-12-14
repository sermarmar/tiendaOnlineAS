<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="controller.consutaController"%>
<%@page import="model.Producto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<%
	NumberFormat nf = NumberFormat.getCurrencyInstance(Locale.getDefault());
	//Ejecutar la tabla de productos
	ArrayList<Producto> productos=new ArrayList<Producto>();
	ArrayList<Producto> lista=new ArrayList<Producto>();
	double precioTotal=0;
	productos=consutaController.mostrarProductos();
%>
<s:if test="%{#session.Usuario!=null}">
	<%
		lista=consutaController.mostrarListaCompras();
	%>
</s:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>NetShop</title>
	<%@ include file="/includes/head.jsp"%>
	
</head>
<body>
	
	<div class="container">
		<div class="jumbotron">
			<img src="./img/web/logo.png" style="float: left;" width="150px">
			<h1><span style="color:#db0400">N</span><span style="color:#f60">E</span><span style="color:#43a800">T</span> SHOP</h1>
			<p>Al mejor precio</p>
		</div>
	</div>
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
		    <ul class="nav navbar-nav navbar-right">
		    	<s:if test="%{#session.Usuario!=null}">
					<li>
						<a href="perfil.jsp" class="hoverRed">Perfil</a>
					</li>
					<li>
						<a href="facturas.jsp" class="hoverYellow">Facturas</a>
					</li>
					<li>
						<a href="#" id="openBalloon" class="hoverGreen">Cesta <span class="badge">0</span></a>
						<div class="speech-bubble">
							<table class="table" id="cesta">
								<tr>
									<th></th>
									<th>Nombre:</th>
									<th>Uds:</th>
									<th>Precio:</th>
								</tr>
							<% for(Producto producto:lista){%>	
									<tr class="fila">
										<td><img src="<%= producto.getImagen()%>" width="100px"></td>
										<td><%= producto.getNombre()%></td>
										<td>
											<input type="hidden" class="idLinea" value="<%= producto.getId()%>">
											<input type="number" class="form-control cant" min="1" value="<%= producto.getCantidad()%>">
										</td>
										<td><%= nf.format(producto.getPrecio())%></td>
										<td>	
											<input type="hidden" class="idLinea" value="<%= producto.getId()%>">
											<span class="btn btn-danger borrarLine">Borrar</button>
										</td>
									</tr>
							<% }%>
							</table>
							<button type="button" id="crearPedido" class="btn btn-success" data-toggle="modal" data-target="#myModal">Hacer el pedido</button>
						</div>
					</li>
					<li>	
						<a href="logout">Cerrar sesión</a>
					</li>
				</s:if>
				<s:else>
					<li>
						<form class="form-inline" action="login" method="post" enctype="multipart/form-data">
							<s:property value="msg"/>
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
					    <a href="registro.jsp"><span class="glyphicon glyphicon-user"></span> Registrar</a>
					</li>
				</s:else>
		    </ul>
		    
		</div>
	</nav>
	<div class="container-fluid">
		<%@ include file="/includes/cesta.jsp"%>	
	</div>

		<!-- Modal -->
		<div id="myModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
			
			    <!-- Modal content-->
			    <form action="enviarFactura" method="POST">
			    <div class="modal-content">
			      	<div class="modal-header">
			        	<button type="button" class="close" data-dismiss="modal">&times;</button>
			        	<h4 class="modal-title">Realizar pago</h4>
			      	</div>
			      	<div class="modal-body">
			      		
			      			<p id="paso1">
			        		Comprueba si esta todo correcto.
			        		<table class="table table-bordered" id="tableFactura">
								<tr>
									<th></th>
									<th>Nombre</th>
									<th>Cantidad</th>
									<th>Precio</th>
								</tr>
							<% for(Producto producto:lista){
								precioTotal+=producto.getPrecio();
								%>	
									<tr class="fila">
										<td width="100px"><img src="<%= producto.getImagen()%>" width="100px"></td>
										<td><%= producto.getNombre()%></td>
										<td class="cant"><%= producto.getCantidad()%></td>
										<td><%= producto.getPrecio()%> €</td>
									</tr>
							<% }%>
								<tr>
									<th colspan="3" style="text-align: right;">SubTotal: </th>
									<th>
										<%= precioTotal%>
										<input type="hidden" name="precioTotal" value="<%= precioTotal%>">
									</th>
								</tr>
							</table>
							
				        	</p>
				        	<p id="paso2">
					        	Método de pago:	<br>
					        	<input type="radio" name="pago" value="Efectivo" checked>
					        	Pago en efectivo.
					        	<span class="glyphicon glyphicon-shopping-cart"></span><br>
					      		<input type="radio" name="pago" value="Tarjeta">
					        	Tarjeta de crédito.
					        	<span class="glyphicon glyphicon-credit-card"></span>
				        	</p>
				    </div>
			  
			      	<div class="modal-footer">
			      		<input type="hidden" name="idFactura" value="<s:property value="%{#session.Usuario.id}"/>">
			      		<input type="submit" class="btn btn-primary" value="Comprar Ya!">
			        	<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
			      	</div>
			    </div>
				</form>
			</div>
		</div>
		<!-- Modal-Info -->
		<div id="info" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header" id="ifNombre">
						
					</div>
					<div class="modal-body" id="descrip">
						
					</div>
					<div class="modal-footer">
						<s:if test="%{#session.Usuario==null}">
							Para añadir, tienes que registrar la cuenta o entrar en tu cuenta.
							<a href="login.jsp">Login</a> <a href="registro.jsp">Registrar</a>
						</s:if>
				        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
				    </div>
			    </div>
			</div>
		</div>
	<footer>
		<p>Hecho por Sergio Martín Martín</p>
<!-- 		<a href="login.jsp">Trabaja con nosotros</a> -->
	</footer>
</body>
</html>