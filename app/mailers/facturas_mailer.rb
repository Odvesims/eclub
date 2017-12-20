class FacturasMailer < ActionMailer::Base
	include SessionsHelper
	default from: 'felixconstanzo@gmail.com'
  
	def facturas_email(pfecha, pcliente)
    	if File.exist?('/dev/null')  #si es linux
			@es_linux = true
		else
			@es_linux = false
		end
		puts "ENTRO A REPORTE EMAIL"
		
		nombre_archivo = ""
		fecha = ""
		nombre = ""
		mifecha = '2016/01/01' #Time.strptime(@pfecha, "%d/%m/%Y")
		fechahoy = '2016/01/01' #mifecha.strftime("%Y_%m_%d")
		@subject = 'PRESCO, S.A. Factura mensualidad - '+ fechahoy
		@dirname = Rails.root+'public/pdfs/factura_x.zip'
			
		if File.exist?(@dirname)
			#FileUtils.rm_rf(@dirname)
			puts "Encontrado :",@dirname
		end				
		#@dirname+='/'
		#FileUtils.mkdir(@dirname)
		   
		#si el usuario lleva archivo anexo...  
		vanexo = false
		if vanexo
		@nombre_archivo = @dirname #compress_file(@dirname)
		archi = @dirname #File.basename(@nombre_archivo)
        if @es_linux == true
			attachments[archi] = File.read(@nombre_archivo)
		else	
			attachments['factura_x.pdf'] = File.read(@nombre_archivo)
		end	
		end

		#------------- Envio del Correo ----------------------------
		@pcliente = pcliente
		@email = 'felix_constanzo@hotmail.com'
		@email_with_name = "#{@pcliente.nombre_cliente} <#{@email}>"
	
		puts 'aqui e'
		delivery_options = { user_name: 'felixconstanzo@gmail.com',
                         password: 'xxxxx',
                         address: "smtp.gmail.com",
						 port: 587,
						 domain: "gmail.com",
						 authentication: 'plain',
                         enable_starttls_auto: true 
					   }
    				   
		mail(to: @email_with_name, subject: @subject,
			delivery_method_options: delivery_options) do |format|
			format.html { render '/facturasmailer/facturas_email' }
			#format.text
		end	 
	
		if @es_linux == true
			system("rm -R #{@nombre_archivo} #{@dirname}")
		else
			#system("del #{@nombre_archivo} ")
			#system("rmdir #{@dirname}")
		end	
		
		$haenviado = true
		puts 'SALIENDO DE EMAIL',@email_with_name,$haenviado
	else
	
		$haenviado = false
		puts 'SALIENDO DE EMAIL',@email_with_name,$haenviado
	end 	
	
end

