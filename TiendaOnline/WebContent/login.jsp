<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>NetShop - Login</title>
	<%@ include file="/includes/head.jsp"%>
	
</head>
<body>
	<div class="container">
		<div class="panel panel-defautl"  id="panel-registro">
			<div class="panel-heading">
				Login <span id="msgError"></span>
			</div>
			<div class="panel-body">
				<s:property value="msg"/>
				<form action="login" method="POST">
					<table class="table">
						<tr>
							<td>
								<label for="usuario" >Usuario:</label>
							</td>
							<td>
								<input type="text" id="usuario" name="user" class="form-control" maxlength="15" required>
							</td>
							<td>
								<label for="dni">Contraseña:</label>
							</td>
							<td>
								<input type="password" id="pass" name="pass" class="form-control" required>
							</td>
						</tr>
					</table>
					<input type="submit" value="Entrar" id="Entrar" class="btn btn-primary">
				</form>
			</div>
		</div>
	</div>
</body>
</html>