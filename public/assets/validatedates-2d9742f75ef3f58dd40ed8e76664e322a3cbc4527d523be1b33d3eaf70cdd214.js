
function validDate(elObj) 
{
    var str = elObj.value;
	var str2 = ' ';
	var hoy = new Date();
	var anio = hoy.getFullYear();
	var mes = hoy.getMonth()+1;
	var dia = hoy.getDate();
	var part1 = dia.toString();
	var part2 = mes.toString(); 
	if (dia < 10){ part1 = '0'+dia.toString()  };
	if (mes < 10){ part2 = '0'+mes.toString()  };
	strhoy = part1+'/'+part2+'/'+anio.toString();
	
    if (str.length > 10) 
	{
		alert("Valor de Fecha Invalido");
		elObj.value = strhoy;
		elObj.focus();
        return false;
    };
		
    var n=str.indexOf("/");
	if (n == -1)
	{  
		str2 = str.substring(0,2)+'/'+str.substring(2,4)+'/'+str.substring(4,8);
	}
	else
	{
		str2 = str;		
	}
    var date = Date.parse(str2);
    var comp = str2.split('/');
    if (comp.length !== 3) 
	{		
		alert("Valor de Fecha Invalido.");
		elObj.value = strhoy;
		elObj.focus();
        return false;
    }
    var d = parseInt(comp[0], 10);
    var m = parseInt(comp[1], 10);
    var y = parseInt(comp[2], 10);
    var date = new Date(y, m - 1, d);
	var retorna = (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d);
	if (retorna == false)
	{	      	
		alert("Valor de Fecha Invalido");
		elObj.value = strhoy;
		elObj.focus();
        return false;
	}
	elObj.value = str2;
    return (retorna);
};

function validNum(elObj, dfvalue) 
{ 
	if (isNaN(elObj.value) )
	{	
		alert("Debe ser un campo numerico");
		elObj.value = dfvalue;
		elObj.focus();
		elObj.select();
	};
	if (elObj.value == "0" && elObj.value != dfvalue)
	{
		alert("valor del campo no puede ser cero");
		elObj.value = dfvalue;
		elObj.focus();
		elObj.select();
		return false;
	};  
};
	
function compareDates(fechadesde, fechahasta)
{	
	var parts1 = fechadesde.split("/");
	var parts2 = fechahasta.split("/");
	var fechaini = new Date(parseInt(parts1[2], 10),parseInt(parts1[1], 10)-1, parseInt(parts1[0], 10));
	var fechafin = new Date(parseInt(parts2[2], 10),parseInt(parts2[1], 10)-1, parseInt(parts2[0], 10));

	if (fechaini > fechafin){
		alert("La fecha inicial "+fechadesde+" no puede ser mayor que la final "+fechahasta);
		return false;
		};
	return true;
	};
	
function ponCero(elObj, dfvalue) 
{ 
	if (isNaN(elObj.value) || elObj.value == "" )
	{ 
		elObj.value = "0";
		elObj.focus();
		elObj.select();
	};
	return false;
};	 
	 
function errorDialog(tipo, mensaje)
{
	document.getElementById("headerModal").className= "";
	if(tipo=='Error'){
		document.getElementById("headerModal").className= "modal-header bg-danger";
	} else{
		document.getElementById("headerModal").className= "modal-header bg-info";
	}
	document.getElementById('headerMessageModal').innerHTML= "<span>"+tipo+"</span>";
	document.getElementById('bodyMessageModal').innerHTML= "<span>"+mensaje+"</span>";
	$('#myModal2').modal('show');
	return false;
};
		
function confirmaDialog(tipo, controller, titulo, mensaje, extra)
{
	if(tipo == 'deposito')
	{	
		var deposito_id = extra
		var confirmaDiv = document.createElement('div');
		confirmaDiv.id = "confirmaDiv";
		confirmaDiv.innerHTML= "";
		confirmaDiv.innerHTML= mensaje;
		document.body.appendChild(confirmaDiv);
		$( "#confirmaDiv" ).dialog(
			{
				dialogClass: 'no-close', 
				modal: true,
				height: 230,
				width: 430,
				stack: true,
				title: titulo,
				buttons: [{
					text: "Si",
					id: "btnSi",
					click: function() 
					{
							if(controller== 'recibos')
							{
								var numero = document.getElementById('numero_transaccion').value;
								var monto = document.getElementById('monto_transaccion').value;
								var dataString = 'execfunction=aplica_deposito'+'&deposito_num='+numero+'&monto='+monto+'&deposito_id='+extra;
							}
							$.ajax(
							{  
								type: "GET",  
								url: "/recibos/show",  
								data: dataString  
							});
							$( this ).dialog( "destroy" ).remove();
						},
				},
				{
					text: "No",
					id: "btnNo",
					click: function() 
					{
						$( this ).dialog( "destroy" ).remove();
					}
				}]
			});
		var si = document.getElementById('aceptar').value;
		var no = document.getElementById('cancelar').value;
		$("#btnSi").html('<span class="ui-button-text">'+ si +'</span>');
		$("#btnNo").html('<span class="ui-button-text">'+ no +'</span>');
	}
	else
	{
		if(document.getElementById('fecha').value>document.getElementById('fechahoy').value)
		{
			var tipo = document.getElementById('tipo').value;
			var mensaje = document.getElementById('mensajfecha').value;
			errorDialog(tipo, mensaje)
		}
		else
		{
			if(document.getElementById('loteria_desde').value == "0" || document.getElementById('loteria_desde').value == "" )
			{
				var tipo = document.getElementById('tipo').value;
				var mensaje = document.getElementById('mensajlot').value;
				errorDialog(tipo, mensaje)
			}
			else
			{
				if(document.getElementById('confirmaDiv'))
				{
					confirmaDiv.innerHTML = ""
				}
				var confirmaDiv = document.createElement('div');
				var controller = document.getElementById('elcontroller').value;
				confirmaDiv.id = "confirmaDiv";
				confirmaDiv.innerHTML= "";
				if(controller == 'ventascierre')
				{
					var mensaje = document.getElementById('mensaje').value;
				}
				confirmaDiv.innerHTML= mensaje;
				document.body.appendChild(confirmaDiv);
				var titulo = document.getElementById('titulo').value;
				$( "#confirmaDiv" ).dialog(
					{
						dialogClass: 'no-close', 
						modal: true,
						height: 230,
						width: 430,
						stack: true,
						title: titulo,
						buttons: [{
							text: "Si",
							id: "btnSi",
							click: function() {
									if(controller== 'ventascierre')
									{
										document.getElementById('confirmado').value = "1";
										var r = document.getElementById('confirmado').value;
										var fecha = document.getElementById('fecha').value;
										var loteria = document.getElementById('loteria_desde').value;
										var dataString = 'confirma='+r+'&fecha='+fecha+'&loteria='+loteria;
									}
									$.ajax(
									{  
										type: "GET",  
										url: "/ventascierre/show",  
										data: dataString  
									});
									$( this ).dialog( "destroy" ).remove();
								},
							},
							{
								text: "No",
								id: "btnNo",
								click: function() {
									document.getElementById('confirmado').value = "2";
									var r = document.getElementById('confirmado').value;
									var dataString = 'confirma='+r;
									$.ajax(
									{  
										type: "GET",  
										url: "/ventascierre/show",  
										data: dataString  
									});
									$( this ).dialog( "destroy" ).remove();
								}
							}]
					});
				var si = document.getElementById('aceptar').value;
				var no = document.getElementById('cancelar').value;
				$("#btnSi").html('<span class="ui-button-text">'+ si +'</span>');
				$("#btnNo").html('<span class="ui-button-text">'+ no +'</span>');
			}
		}
	}
};
		
function cAlert(pset, pnum)
{
	er = Errormessage
	er.innerHTML= ErrorMensaje.dialog;					
}
		
function confirmaDialog2()
{
	if(document.getElementById('fecha').value>document.getElementById('fechahoy').value)
	{
		var tipo = document.getElementById('tipo').value;
		var mensaje = document.getElementById('mensajfecha').value;
		errorDialog(tipo, mensaje)
	}
	else
	{
		if(document.getElementById('loteria_desde').value == "0" || document.getElementById('loteria_desde').value == "" )
		{
			var tipo = document.getElementById('tipo').value;
			var mensaje = document.getElementById('mensajlot').value;
			errorDialog(tipo, mensaje)
		}
		else
		{
			if(document.getElementById('confirmaDiv'))
				{
					confirmaDiv.innerHTML = ""
				}
			var confirmaDiv = document.createElement('div');
			var controller = document.getElementById('elcontroller').value;
			confirmaDiv.id = "confirmaDiv";
			confirmaDiv.innerHTML= "";
			if(controller == 'ventasreabrir')
			{
				var mensaje = document.getElementById('mensaje').value;
			}
			confirmaDiv.innerHTML= mensaje;
			document.body.appendChild(confirmaDiv);
			var titulo = document.getElementById('titulo').value;
			$( "#confirmaDiv" ).dialog(
				{
					dialogClass: 'no-close', 
					modal: true,
					height: 230,
					width: 430,
					stack: true,
					title: titulo,
					buttons: [{
						text: "Si",
						id: "btnSi",
						click: function() {
								if(controller== 'ventasreabrir')
								{
									document.getElementById('confirmado').value = "1";
									var r = document.getElementById('confirmado').value;
									var fecha = document.getElementById('fecha').value;
									var loteria = document.getElementById('loteria_desde').value;
									var dataString = 'confirma='+r+'&fecha='+fecha+'&loteria='+loteria;
								}
								$.ajax(
								{  
									type: "GET",  
									url: "/ventasreabrir/show",  
									data: dataString  
								});
								$( this ).dialog( "destroy" ).remove();
							},
						},
						{
							text: "No",
							id: "btnNo",
							click: function() {
								document.getElementById('confirmado').value = "2";
								var r = document.getElementById('confirmado').value;
								var dataString = 'confirma='+r;
								$.ajax(
								{  
									type: "GET",  
									url: "/ventasreabrir/show",  
									data: dataString  
								});
								$( this ).dialog( "destroy" ).remove();
							}
						}]
				});
			var si = document.getElementById('aceptar').value;
			var no = document.getElementById('cancelar').value;
			$("#btnSi").html('<span class="ui-button-text">'+ si +'</span>');
			$("#btnNo").html('<span class="ui-button-text">'+ no +'</span>');
		}
	}
};
		
function selectModel(pmodel, pfuncion, pcontroller) 
{
// alert('SelecModel->'+pmodel+'-'+pfuncion+'-'+pcontroller);
	if (pfuncion == 'ccclienteinforme') 
	{
		if (pcontroller == 'repcclistdocs') 
		{
			var grupo = document.getElementById('grupo_id').value;
			var familia = '';
			var dataString = 'model='+pmodel+'&execfunction='+pfuncion+'&formu=recibo&controlador='+pcontroller+'&familia_id='+familia+'&grupo_id='+grupo;  
		}
		else
		{
			var grupo = document.getElementById('grupo_id').value;
			var familia = document.getElementById('familia_id').value;
			var dataString = 'model='+pmodel+'&execfunction='+pfuncion+'&formu=recibo&controlador='+pcontroller+'&familia_id='+familia+'&grupo_id='+grupo;  
		}
	}			
	else
	{
		if (pcontroller=="scservicios")
		{
			var pdivem_id = document.getElementById('scservicio_divem_id').value;
			var el_formu = "scservicio"; 
			var pcliente_id = document.getElementById('cliente_id').value;
			var pconcepto_id = document.getElementById('concepto_id').value;
			var dataString = 'model='+pmodel+'&execfunction='+pfuncion+'&formu='+el_formu+'&controlador='+pcontroller+
							 '&divem_id='+pdivem_id+'&cliente_id='+pcliente_id+'&concepto_id='+pconcepto_id;  
		}
		else if (pcontroller=="repsersimcards")
		{
			var pdivem_id = 3
			var el_formu = "scservicio"; 
			var pcliente_id = document.getElementById('cliente_id').value;
			var pconcepto_id = document.getElementById('concepto_id').value;
			var dataString = 'model='+pmodel+'&execfunction='+pfuncion+'&formu='+el_formu+'&controlador='+pcontroller+
							 '&divem_id='+pdivem_id+'&cliente_id='+pcliente_id+'&concepto_id='+pconcepto_id;  
		}

		else
		{
			if (pmodel=="grupo")
			{
				var dataString = 'model='+pmodel+'&execfunction='+pfuncion+'&formu=cliente&controlador='+pcontroller;  
			}
			else
			{
				var el_formu ="recibo"; 
				var dataString = 'model='+pmodel+'&execfunction='+pfuncion+'&formu=recibo&controlador='+pcontroller;  
			}	
			
		}
	}		
	$.ajax({  
		type: "GET",  
		url: "/searchlookup/show",  
		data: dataString  
	});  
};
		
function validacodven(vcampocod)
{
	dataString = 'execfunction=ccvalicodven&formu=recibo&vendedor_cod='+document.getElementById('vendedor_cod').value;
	$.ajax({  
		type: "GET",  
		url: "/ccgenerics/show",  
		data: dataString  
    });  
 };

function validacodban(vcampocod)
{
	dataString = 'execfunction=busbanca&formu=scservicio&banca_cod='+document.getElementById('banca_cod').value+
				'&cliente_id='+document.getElementById('cliente_id').value;
	$.ajax({  
		type: "GET",  
		url: "/ccgenerics/show",  
		data: dataString  
    });  
 };

function valida2codban(vcampocod)
{
	dataString = 'execfunction=busbanca&formu=serial&banca_cod='+document.getElementById('banca_cod').value+
				'&cliente_id='+document.getElementById('cliente_id').value;
	$.ajax({  
		type: "GET",  
		url: "/ccgenerics/show",  
		data: dataString  
    });  
 };
 
function validacodeq(vcampocod)
{
	dataString = 'execfunction=busequipo&formu=taentranscab&equipo_cod='+document.getElementById('equipo_cod').value;
				
	$.ajax({  
		type: "GET",  
		url: "/ccgenerics/show",  
		data: dataString  
    });  
 };
 
function validacodgru(vcampocod)
{
	dataString = 'execfunction=busgrupo&formu=cliente&grupo_cod='+document.getElementById('grupo_cod').value;
			
	$.ajax({  
		type: "GET",  
		url: "/ccgenerics/show",  
		data: dataString  
    });  
 };

 function validacodcp(vcampocod)
{
	dataString = 'execfunction=busconcepto&formu=scservicio&concepto_cod='+document.getElementById('concepto_cod').value;
				 // '&divem_id='+document.getElementById('scservicio_divem_id').value+'&cliente_id='+document.getElementById('cliente_id').value;
	$.ajax({  
		type: "GET",  
		url: "/ccgenerics/show",  
		data: dataString  
    });  
 };

 
function validacodcte(vcampocod, accion, controlador)
{
	var form_controller = $("#formu_controller").val();
	var la_accion = $("#my_action").val();
	dataString = 'execfunction=ccvalicodcte&formu='+form_controller+'&cliente_cod='+document.getElementById('cliente_cod').value+'&divem_id=0'+                        
				 '&fecha='+document.getElementById('datepicker').value+ '&accion='+ la_accion + '&controlador='+ form_controller;
	$.ajax(
	{  
		type: "GET",  
		url: "/ccgenerics/show",  
		data: dataString  
    }); 
};
		 
function validacodpro(vcampocod)
{
	var pcod = vcampocod.value 
    dataString = 'execfunction=movalicodpro&formu=form_prop&propietario_cod='+pcod;	                
 	$.ajax({  
		  type: "GET",  
		  url: "/ccgenerics/show",  
		  data: dataString  
          }); 
 
};
		 
function validacodsim(vcampocod)
{
	dataString = 'execfunction=valicodsim&formu=scservicio&simcard_cod='+document.getElementById('simcard_cod').value+
				 '&concepto_id='+document.getElementById('concepto_id').value;			                
  	$.ajax({  
		  type: "GET",  
		  url: "/ccgenerics/show",  
		  data: dataString  
          }); 
	
};		 

function buPenClie(velmismo,vlineno,vpendf,vabonocamb) 
{
	document.getElementById('tabsd').style.display="block"
	var valorlin = '0'; // velmismo.val();
	if (velmismo.type=="text")
	{
		valorlin=velmismo.value;
	}
	var dataString = 'divem_id='+ $("#recibo_divem_id").val() + '&formu=recibo&cliente_id='+ $("#cliente_id").val() +
					 '&monto_recibo='+  $("#recibo_monto_recibo").val() + '&abono_linea='+  valorlin+'&numerolinea='+vlineno+'&pendlinea='+vpendf +
					 '&totalaplicado='+ $("#monto_aplicado").val();
								 
	$('#lineaflag').val(vlineno);	
	if (vlineno == '-1')
	{				
		$('#lineasrep').replaceWith('<ul id="lineasrep"></ul>');
		$.ajax({  
				type: "GET",  
				url: "/vccdetpendcltes/show",  
				data: dataString  
			});
	}
	formaspago();
};
		
function searchbyname(consulta, nombre, valorv, controllerdocs)
{	
	var buscarsegun='';
	var familia = '';
	var grupo = '';
	if (controllerdocs == '10') 
	{						
		familia = '';
	 	grupo = document.getElementById("grupo_id").value;
	}
	else if (controllerdocs == '5') 
	{
		 familia = document.getElementById("familia_id").value;
		 grupo = document.getElementById("grupo_id").value;
	}
	else if (controllerdocs == '1') 
	{
		 familia = '';
		 grupo = '';
	}
	btc = document.getElementById("b_codigo").checked;
	btn = document.getElementById("b_nombre").checked;
	if(btc == true)
	{
		buscarsegun = 'codigo';
	}
	else if(btn == true)
	{
		buscarsegun = 'nombre';
	}
	$("#tablita").html("");
	nombre = $("#consultapornombre").val();
	var dataString = 'nombre=' + nombre+ '&execfunction='+consulta+ '&valorv=' + valorv + '&buscarsegun=' + buscarsegun+
				'&familia_id=' + familia + '&grupo_id=' + grupo;		
	$.ajax(
	{
		type: 'GET',
		url: "/searchlookup/show",  
		data: dataString  
	});	
}
		
function takeGeneric(paramid, paramcod, paramnom, tipo, pidcod, pformu)
{
//alert('TakeGeneric->'+paramid+'-'+paramcod+'-'+paramnom+'-'+tipo+'-'+pidcod+'-'+pformu);
if (tipo == 'vendedor')  
	{
		$( "#vendedor_id" ).val(paramid);
		$( "#vendedor_cod" ).val(paramcod);
		$("#divvenenom").replaceWith('<span id="divvenenom"><b>'+paramnom+'</b></span>');
		$("#myModal .close").click()
	}
	else if (tipo == 'propietario')  
	{
		$( "#propietario_id" ).val(paramid);
		$( "#propietario_cod" ).val(paramcod);
		$("#divcltenom").replaceWith('<span id="divcltenom"><b>'+paramnom+'</b></span>');
		$("#myModal .close").click()
	}
	else if (tipo == 'banca')  
	{
		$( "#banca_id" ).val(paramid);
		$( "#banca_cod" ).val(paramcod);
		$( "#divbancanom" ).replaceWith('<span id="divbancanom"><b>'+paramnom+'</b></span>');
		$("#myModal .close").click()
	}
	else if (tipo == 'equipo')  
	{
		$( "#equipo_id" ).val(paramid);
		$( "#equipo_cod" ).val(paramcod);
		$( "#divequiponom" ).replaceWith('<span id="divequiponom"><b>'+paramnom+'</b></span>');
		$("#myModal .close").click()
	}
	else if (tipo == 'simcard')  
	{
		$( "#simcar_id" ).val(paramid);
		$( "#simcard_cod" ).val(paramcod);
		$("#divsimnun").replaceWith('<span id="divsimnun"><b>'+paramnom+'</b></span>');
		$("#myModal .close").click()
	}
	else if (tipo == 'concepto')
	{
		if (pformu == 'scservicio')
		{
			vpformu = 'scservicio'
			$( "#concepto_id" ).val(paramid);
			$( "#concepto_cod" ).val(paramcod);
			$( "#divcpdesc" ).replaceWith('<span id="divcpdesc"><b>'+paramnom+'</b></span>');
			$("#myModal .close").click()
		
		}
		else if (pformu != 'scservicio')
		{
			var vcol = 49
			vpformu = 'facturascab_facturasdet'
			if (pformu == 'motranscab_motransdet')
			{
				vcol = 47
				vpformu = 'motranscab_motransdet'
			}
			if (pformu == 'sctranscab_sctransdet')
			{
				vcol = 47
				vpformu = 'sctranscab_sctransdet'
			}
			if (pformu == 'tatatranscab_tatatransdet')
			{
				vcol = 51
				vpformu = 'tatatranscab_tatatransdet'
				
				var vcadenaid = pidcod.substring(0,vcol);
				var vpidcod = pidcod;
				var vpidcodi = vcadenaid + 'codigo';
				var vpidcodh = vcadenaid + 'codigo';
				var vpidcant = vcadenaid + 'cantidad';
				var vpidnomb = vcadenaid + 'descripcion';
				var vpidprec = vcadenaid + 'precio';
				var vpidmto  = vcadenaid + 'monto';
				var vpidmtoh = vcadenaid + 'monto';
				var vpidpro = paramcod;
				
				document.getElementById(vpidcodi).value = paramcod;
				document.getElementById(vpidcod).value  = paramid;
				$("#myModal .close").click()
				
			}
			else
			{
				var vcadenaid = pidcod.substring(0,vcol);
				var vpidcod = pidcod;
				var vpidcodi = vcadenaid + 'codigo';
				var vpidcodh = vcadenaid + 'codigo';
				var vpidcant = vcadenaid + 'cantidad';
				var vpidnomb = vcadenaid + 'nombre_concepto';
				var vpidprec = vcadenaid + 'precio';
				var vpiddesc = vcadenaid + 'monto_descuento';
				var vpiddesh = vcadenaid + 'monto_descuento';
				var vpidtax  = vcadenaid + 'monto_tax';
				var vpidtaxh = vcadenaid + 'monto_tax';
				var vpidmtob = vcadenaid + 'monto_bruto';
				var vpidmto  = vcadenaid + 'monto_neto';
				var vpidmtoh = vcadenaid + 'monto_neto';
				var vpidmto2 = vcadenaid + 'monto';
				var vpidpro = paramcod;
				
				document.getElementById(vpidcodi).value = paramcod;
				document.getElementById(vpidcod).value  = paramid;
				$("#myModal .close").click()
			}
		}	
	}
	else if (tipo == 'tallerconcepto')
	{
		$( "#concepto_id" ).val(paramid);
		$( "#concepto_cod" ).val(paramcod);
		$( "#divcpdesc" ).replaceWith('<span id="divcpdesc"><b>'+paramnom+'</b></span>');			
		$("#myModal .close").click()
		
		vcol = 51
		vpformu = 'taentranscab_taentransdet'
		
		var vcadenaid = pidcod.substring(0,vcol);
		var vpidcod = pidcod;
		var vpidcod = vcadenaid + 'codigo';
		var vpidcodih = vcadenaid + 'equipo_id';
		var vpiddes = vcadenaid + 'descripcion';
		var vpidpro = paramcod;
		
		document.getElementById(vpidcod).value = paramcod;
		document.getElementById(vpidcodih).value = paramid;
		document.getElementById(vpiddes).value  = paramnom;
		$("#myModal .close").click()
	}
	else
	{
		$( "#cliente_id" ).val(paramid);
		$( "#cliente_cod" ).val(paramcod);
		$("#divcltenom").replaceWith('<span id="divcltenom"><b>'+paramnom+'</b></span>');
		$("#myModal .close").click()
	}
	var form_controller = $("#formu_controller").val();
	var la_accion = $("#my_action").val();
	
	if (form_controller=="scservicio")
	{
		if (tipo == 'simcard')
		{
			var la_funcion = "valicodsim"; 
		}
		else if (tipo == 'banca')
		{
			var la_funcion = "busbanca"; 
		}
		else if (tipo == 'equipo')
		{
			var la_funcion = "busequipo"; 
		}
		else if (tipo == 'concepto')
		{
			var la_funcion = "busconcepto"; 
		}
		else
		{
			var la_funcion = "bavalicodcte"; 
		}
	}	
	else if (form_controller=="facturascab")
	{
	    if (tipo == 'concepto')
		{
			var la_funcion = "busconcepto"
		}
		else
		{
		   var la_funcion ="ccvalicodcte"; 		
		}
	}
	else if (form_controller=="clientes")
	{
	    if (tipo == 'grupo')
		{
		  var la_funcion = "busgrupo"
		}
	}
	else if (form_controller=="propiedades")
	{
		var la_funcion = "movalicodpro" 
	}
	else if (form_controller=="serialins")
	{
		var la_funcion = "busbanca" 
	}
	else if (pformu=="scservicio")
	{
		var la_funcion = "busconcepto" 
	}
	else
	{ 
	  var la_funcion ="ccvalicodcte"; 
	}			
	
	if (tipo == 'simcard')
	{
		var dataString = 'execfunction='+la_funcion+'&formu=scservicio+&simcard_cod='+document.getElementById('simcard_cod').value+
	                '&divem_id=0'+                        
			        '&fecha='+document.getElementById('datepicker').value+ '&accion='+ 'new' + '&controlador='+ 'scservicio';
	}
	else if (tipo == 'banca')
	{
		var la_funcion = "busbanca" 
		var dataString = 'execfunction='+la_funcion+'&formu='+pformu+'&banca_cod='+document.getElementById('banca_cod').value+
	                '&divem_id=0&cliente_id='+document.getElementById('cliente_id').value;                     
			        //'&fecha='+document.getElementById('datepicker').value+ '&accion='+ 'new' + '&controlador='+ 'scservicio';
	}
	else if (tipo == 'grupo')
	{
  	   var dataString = 'execfunction='+la_funcion+'&formu=cliente+&grupo_cod='+paramcod;
	}
	else if (tipo == 'propietario')
	{
		var dataString = 'execfunction='+la_funcion+'&formu=form_prop+&propietario_cod='+paramcod+
	                '&divem_id=0'+                        
			        '&accion='+ 'new' + '&controlador='+ 'propietario';
	}	
	
	else if (tipo == 'concepto')
	{
		if (vpformu == 'scservicio')
		{
			var dataString = 'execfunction='+la_funcion+'&formu=scservicio+&concepto_cod='+document.getElementById('concepto_cod').value+
							 '&divem_id=0&cliente_id='+document.getElementById('cliente_id').value+                        
							 '&fecha='+document.getElementById('datepicker').value+ '&accion='+ 'new' + '&controlador='+ 'scservicio';		
		}
		else if (vpformu != 'scservicio')
		{
			if (vpformu == 'tatatranscab_tatatransdet')
			{
				dataString = 'execfunction=validacodx&vmodelo='+ $("#el_modelodet").val()+'&formu='+vpformu+'&codigo='+vpidpro+
							 '&id_cod='+vpidcod+'&id_cant='+vpidcant+'&id_nomb='+vpidnomb+'&id_prec='+vpidprec+
							 '&id_mto='+vpidmto+'&id_codi='+vpidcodi+
							 '&cant_pro='+document.getElementById(vpidcant).value+'&id_codh='+vpidcodh+
							 '&mto_ant='+document.getElementById(vpidmto).value+'&id_mtoh='+vpidmtoh;

			}	
			else
			{
				dataString = 'execfunction=validacodx&vmodelo='+ $("#el_modelodet").val()+'&formu='+vpformu+'&codigo='+vpidpro+
							 '&monto_documento='+ $("#monto_documento").val()+'&monto_bruto='+ $("#monto_bruto").val()+
							 '&monto_descuento='+ $("#monto_descuento").val()+'&monto_tax='+ $("#monto_tax").val()+
							 '&id_cod='+vpidcod+'&id_cant='+vpidcant+'&id_nomb='+vpidnomb+'&id_prec='+vpidprec+
							 '&id_desc='+vpiddesc+'&id_tax='+vpidtax+'&id_mto='+vpidmto+'&id_codi='+vpidcodi+
							 '&cant_pro='+document.getElementById(vpidcant).value+'&id_mtob='+vpidmtob+'&id_codh='+vpidcodh+
							 '&mto_ant='+document.getElementById(vpidmto).value+'&id_mtoh='+vpidmtoh+'&id_desh='+vpiddesh+
							 '&mto_bruant='+document.getElementById(vpidmtob).value+
							 '&mto_descant='+document.getElementById(vpiddesc).value+
							 '&mto_taxant='+document.getElementById(vpidtax).value+
							 '&id_taxh='+vpidtaxh;
			}			 
		}
			
	}
	else if (tipo == 'tallerconcepto')
	{
			dataString = 'execfunction=validacodt&vmodelo='+ $("#el_modelodet").val()+'&formu='+vpformu+'&codigo='+vpidpro+
						 '&id_cod='+vpidcod+'&id_des='+vpiddes+'&id_codih='+vpidcodih;
		
	}	
	else
	{
		var dataString = 'execfunction='+la_funcion+'&formu=recibo+&cliente_cod='+document.getElementById('cliente_cod').value+
	                '&divem_id=0'+                        
			        '&fecha='+document.getElementById('datepicker').value+ '&accion='+ 'new' + '&controlador='+ 'recibo';
	}
		
	$.ajax({  
		type: "GET",  
		url: "/ccgenerics/show",  
		data: dataString  
    }); 
	$("#myModal .close").click()
};
			
function changesec() 
{
	var form_controller = $("#formu_controller").val();
	var la_accion = $("#my_action").val();
	dataString = 'execfunction=ccsecudoc&formu='+form_controller+'&tipo_documento='+document.getElementById('tipo_documento').value+
				 '&divem_id='+document.getElementById('divem_id').value+'&form_controller='+form_controller;                      
	$.ajax({  
		type: "GET",  
		url: "/ccgenerics/show",  
		data: dataString  
    }); 
};
			
function cambiaDivem(id)
{
	dataString = 'divemid='+id;
	$.ajax({
		type: "GET",
		url: "/motranscabs/show",
		data: dataString
	});
};
			
function getSecuenciaDocumento(divem_id, documento_id)
{
	var form_controller = $("#formu_controller").val();
	var la_accion = $("#my_action").val();
	dataString = 'execfunction=ccgetdocsequence'+'&divemid='+divem_id+'&tipodocumento_id='+documento_id+'&form_controller='+form_controller;
	$.ajax({
		type: "GET",
		url: "/ccgenerics/show",
		data: dataString
	});
};

function validacodcteinformes(vcampocod, accion, controlador)
{
	var incluye_en_where = ''
	var familia = ''
	var grupo = ''
	if(controlador == 'repccestcuentas' || controlador == 'proccalcinteres' || controlador == 'repmotranscltes'  || controlador == 'repcctranscltes' || controlador == 'repccansalresvens' || controlador == 'repccansaldetdoc' || controlador == 'repdocsnopagos' || controlador == 'repccbalpenclientes' || controlador == 'repccaplicmoras' || controlador == 'repcccuotasmtovens' || controlador == 'repccxcobrarctas' || controlador == 'repccpreycreditos' || controlador == 'proccalcmoras' || controlador == 'fasimcardservicios')
	{
		
		familia = document.getElementById('familia_id').value;
		grupo = document.getElementById('grupo_id').value
		if (familia != '') {
			incluye_en_where = 'familia'
		}
		else if (grupo != '') {
			if (incluye_en_where == familia ) {
				incluye_en_where += '_grupo'
			}
			else{
				incluye_en_where = 'grupo'
			}
		}
		else{
			incluye_en_where = ''
		}

	}
	else if(controlador == 'repcclistdocs')
	{
		
		grupo = document.getElementById('grupo_id').value
		if (grupo != '') {
			incluye_en_where = 'grupo';
		}
		else{
			incluye_en_where = '';
		}

	}
	else if(controlador == '')
	{
		incluye_en_where = 'familia';
		familia = document.getElementById('familia_id').value;
	}
	else
	{
		incluye_en_where = '';
	}
	var form_controller = $("#formu_controller").val();
	var la_accion = $("#my_action").val();
    dataString = 'execfunction=ccvalicodcteinformes&formu='+form_controller+'&cliente_cod='+document.getElementById('cliente_cod').value+
		          '&divem_id=0'+ '&fecha='+document.getElementById('datepicker').value+ '&accion='+ la_accion + '&controlador='+ form_controller+ 
				  '&grupo_id='+grupo+ '&familia_id='+ familia +
				  '&incluye_en_where='+ incluye_en_where;
	$.ajax({  
		type: "GET",  
		url: "/ccgenerics/show",  
		data: dataString  
    }); 
};

jQuery(function($){
   $("#date").mask("99/99/9999",{placeholder:"mm/dd/yyyy"});
   $("#phone").mask("(999) 999-9999");
   $("#tin").mask("99-9999999");
   $("#ssn").mask("999-99-9999");
});
