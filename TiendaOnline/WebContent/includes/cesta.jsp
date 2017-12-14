<%@page import="controller.consutaController"%>
<%@page import="model.Producto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<%
	NumberFormat nEuro = NumberFormat.getCurrencyInstance(Locale.getDefault());
	ArrayList<Producto> productos2=new ArrayList<Producto>();
	productos2=consutaController.mostrarProductos();
%>

<%
				int i=1;
				for(Producto producto:productos2){
					if(i==4){ i=0;%>
						<div class="row">
							<div class="col-sm-3 panelProductos">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" class="idProd" value="<%= producto.getId()%>">
										<input type="hidden" class="idUser" value='<s:property value="%{#session.Usuario.id}"/>'>
										<input type="hidden" class="idNombre" value='<%= producto.getNombre()%>'>
										<input type="hidden" class="idPrecio" value="<%= producto.getPrecio()%>">
										<input type="hidden" class="idDescrip" value="<%= producto.getDescripcion()%>">
										<input type="hidden" class="idImage" value="<%= producto.getImagen()%>">
										<img src="<%= producto.getImagen()%>" alt="<%= producto.getNombre()%>" class="imgProd" width="100%" height="200px" data-toggle="modal" data-target="#info"><br>
										<h4 style="float:right;">
											<%= nEuro.format(producto.getPrecio())%>
											<s:if test="%{#session.Usuario!=null}">
												<input type="hidden" class="idProd" value="<%= producto.getId()%>">
												<input type="hidden" class="idUser" value='<s:property value="%{#session.Usuario.id}"/>'>
												<input type="hidden" class="idNombre" value='<%= producto.getNombre()%>'>
												<input type="hidden" class="idPrecio" value="<%= producto.getPrecio()%>">
												<input type="hidden" class="idDescrip" value="<%= producto.getDescripcion()%>">
												<input type="hidden" class="idImage" value="<%= producto.getImagen()%>">
												<span class="glyphicon glyphicon-plus-sign anadirCarro"></span>
											</s:if>
										</h4>
										<h5><%= producto.getNombre()%></h5>
									</div>
								</div>
							</div>
						</div>
				<%	}
				else{%>
					<div class="col-sm-3 panelProductos">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" class="idProd" value="<%= producto.getId()%>">
										<input type="hidden" class="idUser" value='<s:property value="%{#session.Usuario.id}"/>'>
										<input type="hidden" class="idNombre" value='<%= producto.getNombre()%>'>
										<input type="hidden" class="idPrecio" value="<%= producto.getPrecio()%>">
										<input type="hidden" class="idDescrip" value="<%= producto.getDescripcion()%>">
										<input type="hidden" class="idImage" value="<%= producto.getImagen()%>">
										<img src="<%= producto.getImagen()%>" alt="<%= producto.getNombre()%>" class="imgProd" width="100%" height="200px" data-toggle="modal" data-target="#info"><br>
										<h4 style="float:right;">
											<%= nEuro.format(producto.getPrecio())%>
											<s:if test="%{#session.Usuario!=null}">
												<input type="hidden" class="idProd" value="<%= producto.getId()%>">
												<input type="hidden" class="idUser" value='<s:property value="%{#session.Usuario.id}"/>'>
												<input type="hidden" class="idNombre" value='<%= producto.getNombre()%>'>
												<input type="hidden" class="idPrecio" value="<%= producto.getPrecio()%>">
												<input type="hidden" class="idDescrip" value="<%= producto.getDescripcion()%>">
												<input type="hidden" class="idImage" value="<%= producto.getImagen()%>">
												<span class="glyphicon glyphicon-plus-sign anadirCarro"></span>
											</s:if>
										</h4>
										<h5><%= producto.getNombre()%></h5>
									</div>
								</div>
							</div>
				<%}i++;
				%>
					
				<% }%>