
	function buPenClie(velmismo,vlineno, vpendf, vabonocamb) {
		document.getElementById('tabs').style.display="block"
		var valorlin = '0'; // velmismo.val();
		if (velmismo.type=="text"){
			valorlin=velmismo.value;
			}
	        var dataString = 'divem_id='+ $("#facturascab_divem_id").val() +
			'&formu=facturascab&cliente_id='+ $("#cliente_id").val() +
			'&monto_documento='+  $("#facturascab_monto_documento").val() + 
			'&abono_linea='+  valorlin+'&numerolinea='+vlineno+'&pendlinea='+vpendf +
			'&totalaplicado='+ $("#monto_aplicado").val();
									 
			$('#lineaflag').val(vlineno);	
			if (vlineno == '-1')	
				$('#lineasrep').replaceWith('<ul id="lineasrep"></ul>');
				$.ajax({  
					type: "GET",  
					url: "/vccdetpendcltes/show",  
					data: dataString  
				});  
		//return false;
	};
	
	function buBalClie() {
		var dataString ='divem_id=' + $("#facturascab_divem_id").val()+
						'&cliente_id='+ $("#facturascab_cliente_id").val();
					 
			$('#lineasbal').replaceWith('<ul id="lineasbal"></ul>');
			$.ajax({  
				type: "GET",  
				url: "/vccdetpendcltes/show",  
				data: dataString  
			});  
			//return false;
    };

	$( "buttonback" ).button(); 
	$(function() {
		$( "#tabsd" ).tabs();
	});
	
	function changesec() {
            dataString = 'execfunction=ccsecudoc&formu=facturascab&tipo_documento='+document.getElementById('tipodocumento_id').value+
					     '&divem_id='+document.getElementById('facturascab_divem_id').value;

						 $.ajax({  
							type: "GET",  
							url: "/ccgenerics/show",  
							data: dataString  
                        }); 
	};
 
	function validacodi(eledit) {
				var myparent = eledit.parentNode;
				var grandpa = myparent.parentNode;
				var x=grandpa.childNodes;	
				var vmtofila = 0
				var vmtotal = 0
				
				for (i=0;i<x.length;i++)
				{	
					if (x[i].className == "tdcod")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{	
							vidcod = z[j].id;
						}
					}
					if (x[i].className == "tdcodi")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{	
							vidcodi = z[j].id;
						}
					}
					if (x[i].className == "tdcodh")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{	
							vidcodh = z[j].id;
						}
					}
					if (x[i].className == "tdcant")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{	
							vidcant = z[j].id;
						}
					}
					if (x[i].className == "tdnomb")
					{				
						
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidnomb = z[j].id;
						}
					}
					if (x[i].className == "tdprec")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidprec = z[j].id;
						}
					}
					if (x[i].className == "tddesc")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							videsc = z[j].id;
						}
					}
					if (x[i].className == "tdtax")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidtax = z[j].id;
						}
					}
					if (x[i].className == "tdmto")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidmto = z[j].id;
							vmtofila = document.getElementById(vidmto).value;
							vmtotal  += vmtofila;
						}
					}
					if (x[i].className == "tdmtob")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidmtob = z[j].id;
						}
					}
					if (x[i].className == "tddesh")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							videsh = z[j].id;
						}
					}
					if (x[i].className == "tdtaxh")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidtaxh = z[j].id;
						}
					}
					if (x[i].className == "tdmtoh")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidmtoh = z[j].id;
						}
					}
				};
				var vidpro = ''; 
				if (eledit.type="text")
				{
					vidpro=eledit.value;
				}
				dataString = 'execfunction=validacodx&vmodelo='+ $("#el_modelodet").val()+'&formu=facturascab_facturasdet&codigo='+vidpro+
							 '&monto_documento='+ $("#monto_documento").val()+'&monto_bruto='+ $("#monto_bruto").val()+
							 '&monto_descuento='+ $("#monto_descuento").val()+'&monto_tax='+ $("#monto_tax").val()+
							 '&id_cod='+vidcod+'&id_cant='+vidcant+'&id_nomb='+vidnomb+'&id_prec='+vidprec+
							 '&id_desc='+videsc+'&id_tax='+vidtax+'&id_mto='+vidmto+'&id_codi='+vidcodi+
							 '&cant_pro='+document.getElementById(vidcant).value+'&id_mtob='+vidmtob+
							 '&mto_ant='+document.getElementById(vidmto).value+'&id_mtoh='+vidmtoh+'&id_desh='+videsh+
							 '&mto_bruant='+document.getElementById(vidmtob).value+'&id_codh='+vidcodh+
							 '&mto_descant='+document.getElementById(videsc).value+
							 '&mto_taxant='+document.getElementById(vidtax).value+
							 '&id_taxh='+vidtaxh+'&mto_total='+vmtotal+'&eleme_x='+eledit;


						 $.ajax({  
							type: "GET",  
							url: "/ccgenerics/show",  
							data: dataString  
                        }); 
	};	

	function selectModex(eledit, pmodelx, pfuncionx, pcontrollex) {
				var myparent = eledit.parentNode;
				var grandpa = myparent.parentNode;
				var x=grandpa.childNodes;	
				var vmtofila = 0
				var vmtotal = 0
				
				for (i=0;i<x.length;i++)
				{	
					if (x[i].className == "tdcod")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{	
							vidcod = z[j].id;
						}
					}
					if (x[i].className == "tdcodh")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{	
							vidcodh = z[j].id;
						}
					}
					if (x[i].className == "tdcodi")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{	
							vidcodi = z[j].id;
						}
					}
				};
				var vidpro = ''; 
				if (eledit.type="text")
				{
					vidpro=eledit.value;
				}
				
				var el_formu ="facturascab_facturasdet"; 
			    var dataString = 'model='+pmodelx+'&execfunction='+pfuncionx+'&formu='+el_formu+'&controlador='+pcontrollex+  
								 '&id_cod='+vidcod+'&id_codh='+vidcodh+'&id_codi='+vidcodi+'&divem_id='+ $("#facturascab_divem_id").val();
				
						$.ajax({  
							type: "GET",  
							url: "/searchlookup/show",  
							data: dataString  
						}); 
	};	

	function validacanti(eledit) {
				var myparent = eledit.parentNode;
				var grandpa = myparent.parentNode;
				var x=grandpa.childNodes;	
										
				for (i=0;i<x.length;i++)
				{	
					if (x[i].className == "tdcod")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{	
							vidcod = z[j].id;
						}
					}
					if (x[i].className == "tdcodh")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{	
							vidcodh = z[j].id;
						}
					}
					if (x[i].className == "tdcant")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{	
							vidcant = z[j].id;
						}
					}
					if (x[i].className == "tdnomb")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidnomb = z[j].id;
						}
					}
					if (x[i].className == "tdprec")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidprec = z[j].id;
						}
					}
					if (x[i].className == "tddesc")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							videsc = z[j].id;
						}
					}
					if (x[i].className == "tdtax")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidtax = z[j].id;
						}
					}
					if (x[i].className == "tdmto")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidmto = z[j].id;
						}
					}
					if (x[i].className == "tdmtob")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidmtob = z[j].id;
						}
					}
					if (x[i].className == "tddesh")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							videsh = z[j].id;
						}
					}
					if (x[i].className == "tdtaxh")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidtaxh = z[j].id;
						}
					}
					if (x[i].className == "tdmtoh")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidmtoh = z[j].id;
						}
					}	
				};
				
            dataString = 'execfunction=validacantx&vmodelo='+ $("#el_modelodet").val()+'&formu=facturascab_facturasdet'+
			             '&monto_documento='+ $("#monto_documento").val()+'&monto_bruto='+ $("#monto_bruto").val()+
						 '&monto_descuento='+ $("#monto_descuento").val()+'&monto_tax='+ $("#monto_tax").val()+
						 '&id_cod='+vidcod+'&id_cant='+vidcant+'&id_nomb='+vidnomb+'&id_prec='+vidprec+
						 '&id_desc='+videsc+'&id_tax='+vidtax+'&id_mto='+vidmto+'&id_mtob='+vidmtob+
						 '&id_codi='+vidcodh+'&codigo='+document.getElementById(vidcodh).value+
						 '&cant_pro='+document.getElementById(vidcant).value+
						 '&nombre_pro='+document.getElementById(vidnomb).value+
						 '&prec_pro='+document.getElementById(vidprec).value+
						 '&mto_ant='+document.getElementById(vidmto).value+
						 '&mto_bruant='+document.getElementById(vidmtob).value+
						 '&mto_descant='+document.getElementById(videsc).value+
						 '&mto_taxant='+document.getElementById(vidtax).value+
						 '&id_mtoh='+vidmtoh+'&id_desh='+videsh+'&id_taxh='+vidtaxh;
						 
						 $.ajax({  
							type: "GET",  
							url: "/ccgenerics/show",  
							data: dataString  
                        }); 
	};


	function validaprecx(eledit) {
				var myparent = eledit.parentNode;
				var grandpa = myparent.parentNode;
				var x=grandpa.childNodes;	
							
				for (i=0;i<x.length;i++)
				{	
					if (x[i].className == "tdcod")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{	
							vidcod = z[j].id;
						}
					}
					if (x[i].className == "tdcodh")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{	
							vidcodh = z[j].id;
						}
					}
					if (x[i].className == "tdcant")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{	
							vidcant = z[j].id;
						}
					}
					if (x[i].className == "tdnomb")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidnomb = z[j].id;
						}
					}
					if (x[i].className == "tdprec")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidprec = z[j].id;
						}
					}
					if (x[i].className == "tddesc")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							videsc = z[j].id;
						}
					}
					if (x[i].className == "tdtax")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidtax = z[j].id;
						}
					}
					if (x[i].className == "tdmto")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidmto = z[j].id;
						}
					}
					if (x[i].className == "tdmtob")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidmtob = z[j].id;
						}
					}
					if (x[i].className == "tddesh")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							videsh = z[j].id;
						}
					}
					if (x[i].className == "tdtaxh")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidtaxh = z[j].id;
						}
					}
					if (x[i].className == "tdmtoh")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidmtoh = z[j].id;
						}
					}
				};
				
            dataString = 'execfunction=validapreciox&vmodelo='+ $("#el_modelodet").val()+'&formu=facturascab_facturasdet'+
			             '&monto_documento='+ $("#monto_documento").val()+'&monto_bruto='+ $("#monto_bruto").val()+
						 '&monto_descuento='+ $("#monto_descuento").val()+'&monto_tax='+ $("#monto_tax").val()+
						 '&id_cod='+vidcod+'&id_cant='+vidcant+'&id_nomb='+vidnomb+'&id_prec='+vidprec+
						 '&id_desc='+videsc+'&id_tax='+vidtax+'&id_mto='+vidmto+'&id_mtob='+vidmtob+
						 '&id_codi='+vidcodh+'&codigo='+document.getElementById(vidcodh).value+
						 '&cant_pro='+document.getElementById(vidcant).value+
						 '&nombre_pro='+document.getElementById(vidnomb).value+
						 '&prec_pro='+document.getElementById(vidprec).value+
						 '&mto_ant='+document.getElementById(vidmto).value+
						 '&mto_bruant='+document.getElementById(vidmtob).value+
						 '&mto_descant='+document.getElementById(videsc).value+
						 '&mto_taxant='+document.getElementById(vidtax).value+
						 '&id_mtoh='+vidmtoh+'&id_desh='+videsh+'&id_taxh='+vidtaxh;
						 
						$.ajax({  
							type: "GET",  
							url: "/ccgenerics/show",  
							data: dataString  
                        }); 
	};
 
 
	function restalinea(eledit) {
				var myparent = eledit.parentNode;
				var grandpa = myparent.parentNode;
				var x=grandpa.childNodes;	
				var vmtofila = 0
				var vmtotal = 0
											
				for (i=0;i<x.length;i++)
				{	
					if (x[i].className == "tdcod")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{	
							vidcod = z[j].id;
						}
					}
					if (x[i].className == "tdcodh")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{	
							vidcodh = z[j].id;
						}
					}
					if (x[i].className == "tdcant")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{	
							vidcant = z[j].id;
						}
					}
					if (x[i].className == "tdnomb")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidnomb = z[j].id;
						}
					}
					if (x[i].className == "tdprec")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidprec = z[j].id;
						}
					}
					if (x[i].className == "tddesc")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							videsc = z[j].id;
						}
					}
					if (x[i].className == "tdtax")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
				 		{
							vidtax = z[j].id;
						}
					}
					if (x[i].className == "tdmto")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidmto = z[j].id;    
						}
					}
					if (x[i].className == "tdmtob")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							vidmtob = z[j].id;
						}
					}
					if (x[i].className == "tdeli")
					{				
						z = x[i].childNodes;
						for (j=0;j<z.length;j++)
						{
							videli = z[j].id;
						}
					}
				};

			var vidcpto = ''; 
			if (eledit.type="text"){
				vidcpto=eledit.value;
			}
            dataString = 'execfunction=restavalorli&formu=facturascab_facturasdet&codigo='+vidcpto+
			             '&monto_documento='+ $("#monto_documento").val()+'&monto_bruto='+ $("#monto_bruto").val()+
						 '&monto_descuento='+ $("#monto_descuento").val()+'&monto_tax='+ $("#monto_tax").val()+
						 '&id_cod='+vidcod+'&id_cant='+vidcant+'&id_nomb='+vidnomb+'&id_prec='+vidprec+
						 '&id_desc='+videsc+'&id_tax='+vidtax+'&id_mto='+vidmto+'&id_mtob='+vidmtob+
						 '&cant_pro='+document.getElementById(vidcant).value+'&id_codh='+vidcodh+
						 '&mto_ant='+document.getElementById(vidmto).value+
						 '&mto_bruant='+document.getElementById(vidmtob).value+
						 '&mto_descant='+document.getElementById(videsc).value+
						 '&mto_taxant='+document.getElementById(vidtax).value+
						 '&mto_total='+vmtotal+'&datax='+eledit;
						 
						 $.ajax({  
							type: "GET",  
							url: "/ccgenerics/show",  
							data: dataString  
                        }); 
	};	   
	
	function validaMtoDoc(vcamporec){
		           dataString = 'execfunction=ccvalimtodoc&monto_documento='+document.getElementById('facturascab_monto_documento').value +
	                            '&ccbalanceclte='+document.getElementById('ccbalanceclte').value;
  					  $.ajax({  
                         type: "GET",  
                         url: "/ccgenerics/show",  
                         data: dataString  
                         }); 
              
	    var vmtodoc = vcamporec.value;
		var	vbalcli = $("#ccbalanceclte").val();
	};
	
	function fbusentrada()
	{
		document.getElementById('btnentrada').disabled=true;
		
		dataString = 'execfunction=fbuentrada&documento=';
		document.getElementById('diventradialog').innerHTML=" ";
		$.ajax({
			type: "GET",
				url: "/facturascabs/show",
				data: dataString
		});
	
    };	
	
	function guardar()
	{
		document.getElementById("form_factu").submit();
	};