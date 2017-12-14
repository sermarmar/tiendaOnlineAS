$(function(){
	
	var array=new Array();
	
	//Poner informaciones en el modal
	$('.imgProd').click(function(){
		var nombre=$(this).siblings('.idNombre').val();
		var descripcion=$(this).siblings('.idDescrip').val();
		var imagen=$(this).siblings('.idImage').val();
		var precio=$(this).siblings('.idPrecio').val();
		
		$('#ifNombre').text(nombre);
		var string='<img src="'+imagen+'" width="200px" height="100px" style="float:left">'+
		'<p>'+descripcion+'</p>';
		$('#descrip').html(string);
	});
	
	//Para añadir al carro.
	$('.anadirCarro').click(function(){
		
		var idProd=$(this).siblings('.idProd').val();
		var idUser=$(this).siblings('.idUser').val();
		var precio=$(this).siblings('.idPrecio').val();
		$.ajax({
			type:'POST',
			data:{idUser:idUser,idProd:idProd,precio:precio},
			/*headers:{
				Accept:"application/json; charset=uft-8,",
				"Content-Type":"application/json; charset=uft-8"
			},*/
			url:'anadirCesta',
			success:function(response){
				var precioTotal=0;
				var p=response.productos.length;
				var result='<tr>'+
						'<th></th>'+
						'<th>Nombre:</th>'	+				
						'<th>Uds:</th>'+
					'<th>Precio:</th>'+
				'</tr>';
				for(var i=0;i<p;i++){
					result+='<tr class="fila">'+
								'<td><img src="'+response.productos[i].imagen+'" width="100px"></td>'+
								'<td>'+response.productos[i].nombre+'</td>'+
								'<td><input type="hidden" class="idLinea" value="'+response.productos[i].id+'"><input type="number" class=\"form-control cant\" min="1" value="'+response.productos[i].cantidad+'"></td>'+
								'<td>'+response.productos[i].precio+' €</td>'+
								'<td>'+
									'<input type="hidden" class="idLinea" value="'+response.productos[i].id+'">'+
									'<span class=\"btn btn-danger borrarLine\">Borrar</button>'+
								'</td>'+
							'</tr>';
					precioTotal+=response.productos[i].precio;
				}
				$('.badge').text(p);
				$('#cesta').html(result);
				
				$('.speech-bubble').slideDown();
				
			}
		});
	});
	
	//Hacer el pedido
	$('#crearPedido').click(function(){
		$.ajax({
			type:'GET',
			url:'crearFactura',
			success:function(response){
				var precioTotal=0;
				var p=response.productos.length;
				var result2='<tr><th></th><th>Nombre</th><th>Cantidad</th><th>Precio</th></tr>';
				for(var i=0;i<p;i++){
					result2+='<tr class="fila">'+
						'<td><img src="'+response.productos[i].imagen+'"  width="100px"></td>'+
						'<td>'+response.productos[i].nombre+'</td>'+
						'<td>'+response.productos[i].cantidad+'</td>'+
						'<td>'+response.productos[i].precio+' €</td>'+
					'</tr>';
					precioTotal+=response.productos[i].precio;
				}
				result2+='<tr>'+
					'<th colspan="3" style="text-align: right;">SubTotal: </th>'+
						'<th>'+precioTotal.toFixed(2)+
							'<input type="hidden" name="precioTotal" value="'+precioTotal+'">'+
						'</th>'+
					'</tr>'
				$('#tableFactura').html(result2);
			}
		});
	});
	
	//Las cantidades
	$('#cesta').on('change','.cant',function(){
		var cantidad=$(this).val();
		var id=parseInt($(this).siblings('.idLinea').val());
		$.ajax({
			type:'POST',
			data:{idLinea:id, cantidad:cantidad},
			url:'changeCant',
			success:function(response){
				
			}
		});
	});
	
	//Borrar
	$('#cesta').on('click','.borrarLine',function(){
		var obj=$(this);
		var id=$(this).siblings('.idLinea').val();
		var num=parseInt($('.badge').text());

		$.ajax({
			type:'POST',
			data:{id:id},
			url:'borrarLine',
			success:function(response){
				obj.parents('.fila').html("<td>"+response+"</td>");
			}
		});
		num--;
		$('.badge').text(num);
		if($('.badge').text()==0){
			$('.speech-bubble').slideUp(); 
		}
	});
	
	//Cierra la cesta dentro de cinco segundos
	var windowCesta=setInterval(function(){
		$('.speech-bubble').slideUp(); 
		}, 5000
	);
	
	//Abrir la cesta
	$('#openBalloon').mouseenter(function(){
		if($('.badge').text()>0){
			$('.speech-bubble').slideDown();
			window.clearInterval(windowCesta);
		}
	});
	
	//Cerrar la cesta
	$('#openBalloon').mouseleave(function(){
		windowCesta=setInterval(function(){
			$('.speech-bubble').slideUp(); 
			}, 5000
		);
	});
	
	//Estar quieto cuando el ratón esta dentro de la cesta
	$('.speech-bubble').mouseenter(function(){
		window.clearInterval(windowCesta);
	});
	
	//Se cierra la cesta al salir por el ratón.
	$('.speech-bubble').mouseleave(function(){
		windowCesta=setInterval(function(){
			$('.speech-bubble').slideUp(); 
			}, 5000
		);
	});
	
	//Coge el número de productos guardados en la cesta.
	$.ajax({
		type:'POST',
		data:{},
		url:'contarProducto',
		success:function(response){
			$('.badge').text(response);
		}
	});
	
});