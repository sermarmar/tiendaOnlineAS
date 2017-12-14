<%@page import="controller.consutaController"%>
<%@page import="model.Provincia"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<%
	ArrayList<Provincia> provincias=new ArrayList<Provincia>();
	provincias=consutaController.mostrarProvincias();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>NetShop - Registro</title>
	<%@ include file="/includes/head.jsp"%>
	
</head>
<body>
	<div class="container">
		<div class="panel panel-defautl"  id="panel-registro">
			<div class="panel-heading">
				Registro. <span id="msgError"></span>
			</div>
			<div class="panel-body">
				<s:property value="msg"/>
				<form action="registro" method="POST">
					<table class="table">
						<tr>
							<td>
								<label for="dni">DNI:</label>
							</td>
							<td>
								<input type="text" id="dni" name="u.dni" class="form-control" maxlength="9" required>
							</td>
							<td>
								<label for="usuario" >Usuario:</label>
							</td>
							<td>
								<input type="text" id="usuario" name="u.user" class="form-control" maxlength="15" required>
							</td>
							<td>
								<label for="pass">Contraseña:</label>
							</td>
							<td>
								<input type="password" id="pass" name="u.pass" class="form-control" required>
								<div class="balloon">
									Requisitos de contraseña:<br>
									<span id="min6c">Mínimo de 6 carácteres.</span><br>
									<span id="lower">Letras minúsculas.</span><br>
									<span id="upper">Letras mayúsculas.</span></br>
									<span id="digitos">Números enteros.</span>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<label for="nombre">Nombre:</label>
							</td>
							<td>
								<input type="text" id="nombre" name="u.nombre" class="form-control" maxlength="10" required>
							</td>
							<td>
								<label for="apellidos">Apellidos:</label>
							</td>
							<td>
								<input type="text" id="apellidos" name="u.apellidos" class="form-control" maxlength="25" required>
							</td>
							<td>
								<label for="pass2">Repetir contraseña:</label>
							</td>
							<td>
								<input type="password" id="pass2" name="pass2" class="form-control" required>
							</td>
						</tr>
						<tr>
							<td>
								<label for="email">Correo electrónico:</label>
							</td>
							<td>
								<input type="email" id="email" name="u.email" class="form-control" maxlength="30" required>
							</td>
							<td>
								<label for="provincia">Provincia:</label>
							</td>
							<td>
<!-- 								<input type="text" id="provincia" name="u.provincia" class="form-control"  maxlength="25" required> -->
								<select id="provincia" name="u.provincia" class="form-control">
									<% for(Provincia provincia:provincias){%>
										<option value="<%= provincia.getNombre()%>"><%= provincia.getNombre()%></option>
									<% }%>
								</select>
							</td>
							<td>
								<label for="dir">Dirección:</label>
							</td>
							<td>
								<input type="text" id="dir" name="u.dir" class="form-control"  maxlength="50" required>
							</td>
						</tr>
						<tr>
							<td>
								<label for="tel">Teléfono:</label>
							</td>
							<td>
								<input type="tel" id="tel" name="u.tel" class="form-control" maxlength="9" required>
							</td>
							<td>
								<label for="cp">CP:</label>
							</td>
							<td>
								<input type="text" id="cp" name="u.cp" class="form-control" maxlength="5" required>
							</td>
						</tr>
					</table>
					<input type="submit" value="Registrar" id="registrar" class="btn btn-primary">
				</form>
			</div>
		</div>
	</div>
</body>
</html>