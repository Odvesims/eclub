class Facturamailer < ActionMailer::Base
  	def factura_email(pfecha,pcliente,pfile)
    	if File.exist?('/dev/null')  #si es linux 
			@es_linux = true
		else
			@es_linux = false
		end
		
		nombre_archivo = ""
		fecha = ""
		nombre = ""
		fechahoy = Time.now.strftime("%d/%m/%Y")
		@subject = 'PRESCO, S.A., Factura mensualidad - '+ fechahoy
		@dirname = Rails.root+'public/pdfs/'+pfile.to_s
		
		if File.exist?(@dirname)
			#FileUtils.rm_rf(@dirname)  
		end				
		#@dirname+='/'
		#FileUtils.mkdir(@dirname) 
			
		@pcliente = pcliente
		#@email_with_name = "#{@pcliente.nombre_cliente} <#{@pcliente.email}>"
		@email_with_name = "#{@pcliente.nombre_cliente} " #<#{@pcliente.email}>"
		vctemails = Clientesemail.where("cliente_id=#{@pcliente.id}").all
		@vlistaemails=''
		vcont = 0
		vctemails.each do |le|
		   if le.direccion_email != nil and le.direccion_email !=" " 	
		      vcont += 1
			  @vlistaemails += le.direccion_email
			  if vcont==1
			    @email_with_name += "<#{le.direccion_email}>"
			  else
				@email_with_name += ",<#{le.direccion_email}>"
			  end	
		   end
	    end
		
		#si el usuario lleva archivo anexo...  
		vanexo = false
		if @vlistaemails != nil and @vlistaemails != ""
			vanexo = true
			if vanexo
				@nombre_archivo = @dirname 
				archi =  File.basename(@dirname) 
				if @es_linux == true
					attachments[archi] = File.read(@nombre_archivo)
				else	
					#attachments["#{@nombre_archivo}"] = File.read(@nombre_archivo)
				end	
			end
		
			#-------------- Envio del Correo ---------------------------- 
			mail(to: @email_with_name, subject: @subject).deliver do |format|
				format.html { render '/facturasmailer/facturas_email' }
				#format.text
			end	 
	
			if @es_linux == true
				#system("rm -R #{@nombre_archivo} #{@dirname}")
			else
				#system("del #{@nombre_archivo} ")
				#system("rmdir #{@dirname}")
			end	
			$haenviado = true
		end
	else
		$haenviado = false
	end 
end