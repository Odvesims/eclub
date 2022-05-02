module SessionsHelper

   def sign_in(user)
    # si fuera permanente cookies.permanent[:remember_token] = user.remember_token
	cookies[:remember_token] = user.remember_token
	px=Hash.new
	px=[["loterias"=>"CRUD"],["monitorsrch"=>"R"]]
	cookies[:browser_px]=px
  self.current_user = user
	vidioma = user.idioma_isocod2
  $idioma = 'es'
	unless vidioma.empty?
		I18n.locale = vidioma
		$idioma = vidioma
	end
	
	$menugral = 'ECLUBMENU'
	
	#jfb $nivel_control = user.nivel_control
	#jfb $nivelid = user.nivelid
	#jfb $default_consorcio = user.default_consorcio
	$controller_keyd = ''   #contiene un nombre de controller actual si este conlleva clave especial
	loggin_opc(user,controller_name,action_name, "User Login")	
  end
  
	def mobile_device
		if session[:mobile_param]
			return session[:mobile_param] == "1"
		else
			return request.user_agent =~ /Mobile|webOS/
		end
	end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  
  def current_user?(user)
    user == current_user
  end
  
#Valida si esta logueado y sino lo manda a loguearse 
  def signed_in_user
    
    unless signed_in?
		store_location
		redirect_to signin_url, notice: "Por favor iniciar sesion."
    else
		xuser = current_user
		vidioma = xuser.idioma_isocod2		
		$idioma = ''
		unless vidioma.empty?
			I18n.locale = vidioma
			$idioma = vidioma
		end
		if $controller_keyd != controller_name
		  $controller_keyd = ''
		  cookies.delete(:f01cd23aa)
		end  
	end

  end
 
	def signed_granted?(userid, controler, accion)
		campo = 'crear'
		case accion
			when 'N'
				campo = 'crear'
			when 'S'
				campo = 'consultar'
			when 'E'
				campo = 'actualizar'
			when 'I'
				campo = 'acceder'
			when 'D'
				campo = 'eliminar'
		end	
		auth = Vuserspermission.where("user_id = #{userid} AND controller= '#{controler}' AND #{campo} = '1'").first
		if auth == nil
			redirect_to noautorizado_url, notice: "No esta autorizado a entrar a esta opcion"
			false
		else
			true
		end
  end
 
	def sign_out
		loggin_opc(self.current_user,controller_name,action_name, "User Logout")
		self.current_user = nil
		cookies.delete(:remember_token)
		cookies.delete(:central_name)
	end
  
	#devuelve al usuario a su pagina donde intento entrar
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end
   
	#guarda la url en una cookie return_to
	def store_location
		session[:return_to] = request.url
	end
  
  #Esta funcion genera un HTML usado para desplegar la busqueda avanzada
  #en el search generico. 
  def display_search(pmodel, phash) 
	resulta = "<br><table width = '100%'>"  
	pmodel.hsearch_labels.each do |k,v|
		len = pmodel.hsearch_lengths[k]
		tipo = phash[k].type
		valor = phash[k].name
		if len < 10 
			resulta += "<tr><td><span style = 'margin-bottom:5px' class = 'col-xs-2'>"
		else
			resulta += "<tr><td><span style = 'margin-bottom:5px' class = 'col-xs-5'>"
		end
		if tipo == :date 
			resulta += "<div class='input-group date' data-provide='datepicker' data-date-format='dd/mm/yyyy'>"+text_field_tag("#{k}", "", :class => "form-control", :size => len, :maxLength => len, :onchange=> "validDate(this)")+"<div class='input-group-addon'><span class='glyphicon glyphicon-th'></span></div></div>"
			#resulta += text_field_tag("#{k}", "", :class => "datepicker", :size=> len, :maxLength => len, :onchange => "validDate(this)" )
		elsif tipo == :string || tipo == :text 
			resulta += text_field_tag("#{k}", "", :class=> "form-control", :placeholder=> v  )
		elsif  valor== 'pais_id'
			resulta += select_tag("#{k}",options_from_collection_for_select(@paises, "id", "descripcion"), include_blank: true, :class=> "form-control"   )	
		else
			resulta += text_field_tag("#{k}", "", :size=> len, :maxLength => len, :class=> "form-control", :onchange => "validNum(this, '')", :placeholder=> v )	
		end
		resulta += "</td></tr></span>"
	end
	resulta += "</table>"
	resulta.html_safe
 end
 def es_entero(o)
	true if Integer(o) rescue false
 end	
#Esta funcion retorna un sql para filtrar en el index de los controllers
#para ser usado en el search generico. 
def condicion_search(pparams, phash, pmodel)
  cp = 0
  pv = 0
  cad = ' '

  pparams.each do |k,v|
    if (k != 'utf8' and k != 'action' and k != 'controller' and k != 'srchmodel'  and k != 'page') 
	
	  if v.rstrip != ''
		
	   	if pv > 0
			cad += " AND "
		end
		
		if k.to_s == "searchfield"
		  
 		  if es_entero(v)
		  	if pmodel.hsearch_fields[0]=="codigo" or pmodel.hsearch_fields[0]=="cliente_cod"
			  cad += pmodel.hsearch_fields[0]+" = '#{v}' "
			else
			  cad += pmodel.hsearch_fields[0]+" = #{v} "
			end
		  else
		    sr = v.to_s
			if pmodel.hsearch_fields[0]=="codigo"
			   cad += pmodel.hsearch_fields[1]+" LIKE '%#{sr.capitalize}%'"	
			else 
			   cad += pmodel.hsearch_fields[1]+"||to_char("+pmodel.hsearch_fields[0]+",'99999') LIKE '%#{sr.capitalize}%'"	
			end	 
		  end
	
		else #si no es searchfield
	        	
 		  tipo = phash[k].type
		  case tipo
		    when :string, :text
		      sr = v.to_s
			  if k.to_s == "codigo" or k.to_s == "cliente_cod" 
				 cad += "upper("+k + ") = '#{sr.upcase}'"
			  else
				 cad += "upper("+k + ") like '%#{sr.upcase}%'" 
			  end		
		    when :date, :datetime, :timestamp
			  cad += k + " = '#{v}'"
		    else
			  cad += k + " = #{v} "
	      end
		end  #del searchfield
		pv += 1
	  end 
	  cp += 1
    end
  end  #del each
  
  if cp == 0
    " 1 = 0"
  else
    if pv == 0
	  " 1 = 1 "
    else
	  cad
    end 
  end 
end

#para buscar y desplegar los mensajes de error  
def merror(pset, pnum)
  vidioma = $idioma
  vidioma = 'es'
  mer = Errormessage.where("idioma_isocod2 = '#{vidioma}' AND msg_set = #{pset} AND msg_num = #{pnum} ").first
  if mer
    mer.contenido.html_safe
  else
    "Error Number: "+pset.to_s+","+pnum.to_s
  end
end  

#crea el menu landscape en el home
 def menu_landscape(menuname, usrid, padmin, pmenu_item)
   sql = " "
   strbegin = " "
   itemfirst = Gemenutbl.where("menu_cod = '#{menuname}' AND menu_item = '#{pmenu_item}' ").first
   vnivel_hijos = itemfirst.menu_level + 1 
   if padmin == false
		sql = " and (EXISTS (select 1 from v_users_permission d 
					WHERE d.controller = gemenu_tbl.menu_controller AND d.user_id = #{usrid})
					 OR gemenu_tbl.item_type <> 'C')"
	end
    cont = 1

    strbegin +='<table><thead>'
	strbegin += '<tr><td colspan="4">Ruta:'+camino_retorno(menuname, pmenu_item, 'I')+'</td></tr>'

    menustbl = Gemenutbl.where("menu_cod = '#{menuname}' AND menu_item LIKE '#{pmenu_item}%' AND menu_level = #{vnivel_hijos} "+sql).all()
    
	menustbl.each do |menuitem|
	   vdescr = menuitem.menu_descr
	   if vdescr['---'] == '---'
	     next
	   end
	   
	   if cont ==  1
	     strbegin +='<tr><td>'
	   else
	     strbegin +='<td>'
	   end
	   cont += 1
	   
	   mcontroller = menuitem.menu_controller
	   vdescr = I18n.t('menu.'+mcontroller)
	   if vdescr.empty?  
	      mdescr = menuitem.menu_descr
	   else   
	      if vdescr['missing'] == 'missing'  
		    mdescr = menuitem.menu_descr
		  else
			mdescr = vdescr
		  end
	   end
       case menuitem.item_type
		when 'R' 
         nivel_ant = menuitem.level
        when 'N' 
		 vurl = url_for({:controller => 'home', :action => 'index', :itemnode=>menuitem.menu_item})
		 strbegin+= '<meta name="viewport" content="width=device-width, user-scalable=yes">'
       	 strbegin +='<table style="width:75px;text-align: center;top:0px;"><thead>'
		 strbegin +='<tr><td style = "text-align: center;">'+link_to(image_tag(menuitem.icon, :height =>'60', :width => '60', :valign=>"middle", :class=>"pin_image", :title=>mdescr), vurl, :class => 'quick') +"</td></tr>"
         strbegin += '<tr><td style = "font-size: 14px"><b>'+link_to(mdescr, vurl, :class => 'quick', :style=> "text-decoration: none; color: black;")+'</b></td></tr>'
     	 strbegin +='</thead></table>'
        else
		 strbegin+= '<meta name="viewport" content="width=device-width, user-scalable=yes">'
		 strbegin +='<table style="width:75px;text-align: center;top:0px;"><thead>'
		 strbegin +='<tr><td style = "text-align: center;">'+link_to(image_tag(menuitem.icon, :height =>'60', :width => '60', :valign=>"middle", :class=>"pin_image", :title=>mdescr), '/'+menuitem.menu_controller, :class => 'quick') +"</td></tr>"
         strbegin += '<tr><td style = "font-size: 13px;text-decoration: none;"><b><a href="/'+menuitem.menu_controller+'">'+mdescr+'</a></b></td></tr>'
         strbegin +='</thead></table>'
	   end	
       if cont ==  5
	     strbegin +='</td></tr>'
		 cont = 1
	   else
	     strbegin +='</td>'
	   end	   
   end
   if cont !=  4
	 strbegin +='</td></tr>'
   end		 
   strbegin +='</thead></table>'
   strbegin.html_safe
 end
 
 #devuelve el camino de retorno de una opcion
 def camino_retorno(menuname, pmenu_item, ptipo)
   sql = " "
   resstr = " "
   mdescr = " "
   if ptipo == 'I'  #si recibe el menu_item
     sql = " AND opc_item = '#{pmenu_item}'"
   else  #si recibe menu_controller 
     sql = " AND opc_controller = '#{pmenu_item}'"
   end
   menutblcaminos = Vgemenuroute.where("menu_cod = '#{menuname}' "+sql)
   menutblcaminos.each do |camino|
     mcontroller = camino.menu_controller
	 vdescr = I18n.t('menu.'+mcontroller)
	 if vdescr.empty?  
	    mdescr = camino.menu_descr
	 else   
	    if vdescr['missing'] == 'missing'  
	        mdescr = camino.menu_descr
		else
			mdescr = vdescr
		end
	 end
     case camino.item_type 
	   when 'R'
	     resstr += link_to(mdescr, root_path)
	   when 'N'
		 vurl = url_for({:controller => 'home', :action => 'index', :itemnode=>camino.menu_item})
		 resstr += " >> "+link_to(mdescr, vurl, :class => 'quick')
	   else
         resstr += " >> "+link_to(mdescr, url_for( {:controller => camino.menu_controller }))	   
	 end
   end
   return resstr
 end
 
 #setea los valores de los campos para un order fields
 def set_order_fields(ar_values, ar_defaults, ar_ascdesc)
  @of_options = ar_values
  @of_defaults = ar_defaults
  @of_ascdes = ar_ascdesc
 end
 
 #devuelve el string para el sql de los campos order fields 
 def string_order_fields(arrfields)
	strres = " "
	l = 0
	arrfields.each do |af|
	  l += 1
	  if l > 1
	    strres += ", "
	  end
	  strres += af[1]["ordfield"]+" "+af[1]["ascdesc"]
	end
	return strres
 end
 
 #guarda el log de las acciones de los usuarios en las opciones
 def loggin_opc(puser, pcontroller, paction, pcomment)
   #para que no haga logging de clicks de navegacion
   if pcontroller == 'home'
		return
   else
	   logmodel = Logeclubapi.new
	   logmodel.login = puser.login
	   logmodel.username = puser.name
	   logmodel.log_option = pcontroller
	   logmodel.log_action = paction[0..9]
	   logmodel.log_comment = pcomment
	   logmodel.origin = 'W'  #origen web
	   #logmodel.save
   end
 end
 
 #retorna la carpeta oficial para hacer archivos temporales
 def lotemix_tempdir
   if File.exist?('/dev/null')  #si es linux
    tf = "/tmp/lotfiles/"
   else
    tf = 'c:\\temp\\'
   end
	if not File.exist?(tf)
      FileUtils.mkdir(tf)
  end

  return tf  
 end
  
 #zip a file or directory
 def compress_file(pfilename)
 	#path = pfilename.sub(%r[/$],'')
	path = File.dirname(pfilename)
	archwin = File.join(path,File.basename(pfilename))+'.zip'
	
	archive = File.basename(pfilename)+'.zip'
	ruta = File.basename(pfilename)
    if File.exist?('/dev/null')  #si es linux
	  system("cd #{path} && zip -r #{archive} #{ruta}")
	  return path + '/' + ruta + '.zip'
	else  
	  system("alzip -a #{pfilename} #{archwin}")
	  return path + '\\' + ruta + '.zip'
	end  
  end
 
  #Valida si esta autorizado a ejecutar este controler via remota 
	def exec_granted?(controler, xllave)
		auth = Execremotekey.where("controler= '#{controler}' AND llave = '#{xllave}' ").first
		if auth == nil
			redirect_to noautorizado_url, notice: "No esta autorizado a entrar a esta opcion"
			false
		else
			auth.delete  #para que no se reutilice la misma validacion
			true
		end
	end
  
	def displaymenu(menuname, usrid, padmin)
		strbegin = " "
		strend = " "
		nivel_ant = 0
		tipo_ant = "Z"
		sql = " "
		if padmin == false
			sql = " and (EXISTS (select 1 from v_users_permission d 
					WHERE d.controller = gemenu_tbl.menu_controller AND d.user_id = #{usrid})
					OR gemenu_tbl.item_type <> 'C')"
		end
		menustbl = Gemenutbl.where("menu_cod = '#{menuname}'"+sql).all()
		menustbl.each do |menuitem|
		  mcontroller = menuitem.menu_controller
		  vdescr = I18n.t('menu.'+mcontroller)
			Rails.logger.debug("vdescr #{vdescr}")
			if vdescr.empty?  
				mdescr = menuitem.menu_descr
			else   
				if vdescr['missing'] == 'missing'  
					mdescr = menuitem.menu_descr
				else
					mdescr = vdescr
				end
			end
			case menuitem.item_type 
				when 'R' 
					nivel_ant = menuitem.menu_level
				when 'N' 
					if menuitem.menu_level == nivel_ant 
						strbegin += '</li>'
					end
					if menuitem.menu_level < nivel_ant  
						strbegin +='</ul></li>'
					end
					if menuitem.menu_level > nivel_ant  
						if nivel_ant != 0
							strbegin +='<ul class="dropdown-menu">'
						end
					end 
					if menuitem.menu_level > 1 
						strbegin += '<li class="dropdown-submenu">'+'<a href="/#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">'+mdescr+'</a>'
					else
						strbegin += '<li>'+'<a href="/#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">'+mdescr+'<b class="caret"></b></a>'
					end
				when 'B'
					strbegin += '</ul></li>'
				else
					if menuitem.menu_level > nivel_ant
						strbegin += '<ul class="dropdown-menu">'
					end
					if menuitem.menu_level < nivel_ant
						strbegin += '</ul>'
					end       	      	
					strbegin += '<li><a href="/'+menuitem.menu_controller+'" >'+mdescr+'</a></li>'
			end		
			nivel_ant = menuitem.menu_level
			tipo_ant = menuitem.item_type
		end
		strbegin += '</li></ul>'
		strbegin.html_safe
	end
	
	def getCamporeeCategoria(camporee_id, total_puntos)
		categorias = Camporeescategoria.where("camporee_id = #{camporee_id}").all.sort_by(&:min_puntos)
		categoria = ""
		categorias.each do |c|
			if total_puntos <= c.max_puntos
				categoria = c.nombre
				break
			end
		end
		return categoria
	end
end
  