$(function(){
	
	//Validar DNI
	$('#dni').blur(function(){
		var numero
		var letr
		var letra
		var expresion_regular_dni
		
		var dni=$(this).val();
		 
		expresion_regular_dni = /^\d{8}[a-zA-Z]$/;
		 
		if(expresion_regular_dni.test (dni) == true){
			numero = dni.substr(0,dni.length-1);
		    letr = dni.substr(dni.length-1,1);
		    numero = numero % 23;
		    letra='TRWAGMYFPDXBNJZSQVHLCKET';
		    letra=letra.substring(numero,numero+1);
			if (letra!=letr.toUpperCase()) {
				$(this).css({"backgroundColor":"#ffc2c2"});
				$('#registrar').attr("disabled", true);
				$('#msgError').text("El DNI es incorrecto");
			}else{
				$(this).css({"backgroundColor":"#a3ffac"});
				$('#registrar').attr("disabled", false);
				$('#msgError').text("");
			}
		}else{
		    $(this).css({"backgroundColor":"#ffc2c2"});
		    $('#registrar').attr("disabled", true);
		    $('#msgError').text("El DNI es incorrecto");
		}
		var valor=$(this).val();
		$.ajax({
			type:"GET",
			data:{valor:valor},
			url:"existDNI",
			success:function(response){
				if(response.length>0){
					$('#registrar').attr("disabled", true);
					$('#msgError').text(response);
				}
				else{
					$('#registrar').attr("disabled", false);
					if(valor>0){
						$('#msgError').text("");
					}
				}
			},
		});
	});
	
	//Validar usuario
	$('#usuario').blur(function(){
		if($(this).val().length>=6){
			$(this).css({"backgroundColor":"#a3ffac"});
		    $('#registrar').attr("disabled", false);
		    $('#msgError').text("");
		}
		else{
			$(this).css({"backgroundColor":"#ffc2c2"});
			$('#registrar').attr("disabled", true);
			$('#msgError').text("Tiene que tener mas de 6 caracteres.");
		}
		var valor=$(this).val();
		$.ajax({
			type:"GET",
			data:{valor:valor},
			url:"existUser",
			success:function(response){
				if(response.length>0){
					$('#registrar').attr("disabled", true);
					$('#msgError').text(response);
				}
				else{
					$('#registrar').attr("disabled", false);
					if(valor>0){
						$('#msgError').text("");
					}
				}
			},
		});
	});
	
	//Validar contraseña
	 $("#pass").focus(function(){
		 $(".balloon").show();
	 });
	 $("#pass").blur(function(){
	     $(".balloon").hide();
	 });
	 $("#pass").keyup(function(){
	     var valor=$(this).val();
	     if(valor.length>=6){
	            $("#min6c").css({
	                "color":"green"
	            });
	        }
	        else{
	            $("#min6c").css({
	                "color":"red"
	            });
	        }
	        if(valor.match(/[A-z]/)){
	            $("#lower").css({
	                "color":"green"
	            });
	        }
	        else{
	           $("#lower").css({
	                "color":"red"
	            }); 
	        }
	        if(valor.match(/[A-Z]/)){
	            $("#upper").css({
	                "color":"green"
	            });
	        }
	        else{
	           $("#upper").css({
	                "color":"red"
	            }); 
	        }
	        if(valor.match(/\d/)){
	            $("#digitos").css({
	                "color":"green"
	            });
	        }
	        else{
	           $("#digitos").css({
	                "color":"red"
	            }); 
	        }
	    });
	$('#pass2').blur(function(){
		if($(this).val()==$('#pass').val()){
			$(this).css({"backgroundColor":"#a3ffac"});
		    $('#registrar').attr("disabled", false);
		    $('#msgError').text("");
		}
		else{
			$(this).css({"backgroundColor":"#ffc2c2"});
			$('#registrar').attr("disabled", true);
			$('#msgError').text("La contraseña no es igual al anterior.");
		}
	});
	
	//Validar email
	$('#email').blur(function(){
		var valor=$(this).val();
		$.ajax({
			type:"GET",
			data:{valor:valor},
			url:"existEmail",
			success:function(response){
				if(response.length>0){
					$('#registrar').attr("disabled", true);
					$('#msgError').text(response);
				}
				else{
					$('#registrar').attr("disabled", false);
					if(valor>0){
						$('#msgError').text("");
					}
				}
			},
		});
	});
	
	//Validar nombre
	$('#nombre').blur(function(){
		if($(this).val().length>=3){
			$(this).css({"backgroundColor":"#a3ffac"});
		    $('#registrar').attr("disabled", false);
		    $('#msgError').text("");
		}
		else{
			$(this).css({"backgroundColor":"#ffc2c2"});
			$('#registrar').attr("disabled", true);
			$('#msgError').text("Tiene que tener mas de 3 caracteres.");
		}
	});
	
	//Validar apellidos
	$('#apellidos').blur(function(){
		if($(this).val().length>=6){
			$(this).css({"backgroundColor":"#a3ffac"});
		    $('#registrar').attr("disabled", false);
		    $('#msgError').text("");
		}
		else{
			$(this).css({"backgroundColor":"#ffc2c2"});
			$('#registrar').attr("disabled", true);
			$('#msgError').text("Tiene que tener mas de 6 caracteres.");
		}
	});
	
	//Validar dir
	$('#dir').blur(function(){
		if($(this).val().length>=10){
			$(this).css({"backgroundColor":"#a3ffac"});
		    $('#registrar').attr("disabled", false);
		    $('#msgError').text("");
		}
		else{
			$(this).css({"backgroundColor":"#ffc2c2"});
			$('#registrar').attr("disabled", true);
			$('#msgError').text("Tiene que tener mas de 10 caracteres.");
		}
	});
	
	//Validar telefono
	$('#tel').blur(function(){
		if(($(this).val()>=900000000 && $(this).val()<=999999999) || ($(this).val()>=600000000 && $(this).val()<=699999999) || ($(this).val()>=700000000 && $(this).val()<=799999999)){
			$(this).css({"backgroundColor":"#a3ffac"});
		    $('#registrar').attr("disabled", false);
		    $('#msgError').text("");
		}
		else{
			$(this).css({"backgroundColor":"#ffc2c2"});
			$('#registrar').attr("disabled", true);
			$('#msgError').text("El número de telefono no es correcto");
		}
	});
	
	//Validar CP
	$('#cp').blur(function(){
		if(!isNaN($(this).val()) && $(this).val().length==5){
			$(this).css({"backgroundColor":"#a3ffac"});
		    $('#registrar').attr("disabled", false);
		    $('#msgError').text("");
		}
		else{
			$(this).css({"backgroundColor":"#ffc2c2"});
			$('#registrar').attr("disabled", true);
			$('#msgError').text("El código postal tiene 5 dígitos.");
		}
	});
});
