<%@page import="model.Cliente"%>
<%@page import="model.Provincia"%>
<%@page import="controller.consutaController"%>
<%@page import="model.Producto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<%
	//Ejecutar la tabla de productos
	ArrayList<Provincia> provincias=new ArrayList<Provincia>();
	provincias=consutaController.mostrarProvincias();	
	Cliente c=null;
	String pr="";
%>
<s:if test="%{#session.Usuario!=null}">
	<%
		c=consutaController.perfil(); 
	%>
</s:if>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>NetShop - Perfil</title>
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
		<div class="panel panel-defautl"  id="panel-registro">
			<div class="panel-heading">
				Tu perfil
			</div>
			<div class="panel-body">
				<s:property value="msg"/>
				<form action="editar" method="POST">
					<table class="table">
						<tr>
							<td>
								<label for="dni">DNI:</label>
							</td>
							<td>
								<s:property value="%{#session.Usuario.dni}"/>
							</td>
							<td>
								<label for="usuario" >Usuario:</label>
							</td>
							<td>
								<s:property value="%{#session.Usuario.user}"/>
							</td>
						</tr>
						<tr>
							<td>
								<label for="nombre">Nombre:</label>
							</td>
							<td>
								<s:property value="%{#session.Usuario.nombre}"/>
							</td>
							<td>
								<label for="apellidos">Apellidos:</label>
							</td>
							<td>
								<s:property value="%{#session.Usuario.apellidos}"/>
							</td>
						</tr>
						<tr>
							<td>
								<label for="email">Correo electrónico:</label>
							</td>
							<td>
								<input type="email" id="email" name="c.email" class="form-control" maxlength="30" value="<%= c.getEmail()%>" required>
							</td>
							<td>
								<label for="provincia">Provincia:</label>
							</td>
							<td>
								<select id="provincia" name="c.provincia" class="form-control">
									<% for(Provincia provincia:provincias){
										if(provincia.getNombre().equals(c.getProvincia())){%>
											<option value="<%= provincia.getNombre()%>" selected><%= provincia.getNombre()%></option>
										<%}else{%>
											<option value="<%= provincia.getNombre()%>"><%= provincia.getNombre()%></option>
									<% }}%>
								</select>
							</td>
							<td>
								<label for="dir">Dirección:</label>
							</td>
							<td>
								<input type="text" id="dir" name="c.dir" class="form-control"  maxlength="50" value="<%= c.getDir()%>" required>
							</td>
						</tr>
						<tr>
							<td>
								<label for="tel">Teléfono:</label>
							</td>
							<td>
								<input type="tel" id="tel" name="c.tel" class="form-control" maxlength="9" value="<%= c.getTel()%>" required>
							</td>
							<td>
								<label for="cp">CP:</label>
							</td>
							<td>
								<input type="text" id="cp" name="c.cp" class="form-control" maxlength="5" value="<%= c.getCp()%>" required>
							</td>
						</tr>
					</table>
					<input type="hidden" value='<s:property value="%{#session.Usuario.id}"/>' name="c.id">
					<input type="submit" value="Cambiar" id="registrar" class="btn btn-primary">
				</form>
			</div>
		</div>
	</div>
	
</body>
</html>