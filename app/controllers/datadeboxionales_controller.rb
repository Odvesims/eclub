class DatadeboxionalesController < ApplicationController
	before_filter :signed_in_user
	def index
		xuser = current_user
		if signed_granted?(xuser.id, 'datadeboxionales', 'I')
			@datadeboxionales = Datadeboxionale.where("idioma= 'es' and anio = '2018'").paginate(page: params[:page], :per_page => 30).order("fecha DESC, dia DESC")
			respond_to do |format|
				format.html # index.html.erb
				format.json { render json: @deboxionals }
			end
		end	
	end

  # GET /userdefaults/1
  # GET /userdefaults/1.json
	def show
		xuser = current_user
		if signed_granted?(xuser.id, 'datadeboxionales', 'I')
			@user= User.find(params[:id])	
			@usersroles = Usersrol.all
			respond_to do |format|
				format.html # show.html.erb
				format.json { render json: @user}
			end
		end
	end
  
	def new
		xuser = current_user
		if signed_granted?(xuser.id, 'datadeboxionales', 'N')
			@deboxional= Datadeboxionale.new
			respond_to do |format|
				format.html # new.html.erb
				format.json { render json: @deboxional}
			end
		end	
	end

	def edit
		xuser = current_user
		if signed_granted?(xuser.id, 'datadeboxionales', 'E')
			@deboxional= Datadeboxionale.find(params[:id])
			if params[:donde] == 'next'
				@deboxional= Datadeboxionale.find(params[:id])
				@deboxional= @deboxional.next(@deboxional.id)
			else if params[:donde] == 'prev'
				@deboxional= Datadeboxionale.find(params[:id])
				@deboxional= @deboxional.prev(@deboxional.id)
				end
			end
			#pdf = PdfdiagramaciondeboxionalPdf.new(@deboxional)
			#name = 'deboxional2018.pdf'
			#pdf.render_file File.join(Rails.root, "public/pdfs", name)
			#send_data pdf.render , :filename => name , :type => "application/pdf", :disposition=> 'inline', :target => '_blank' 
		end	
	end
  
	def create
		xuser = current_user
		if signed_granted?(xuser.id, 'datadeboxionales', 'N')			
            fecha = ""
            if params[:datadeboxionale][:fecha].include?("/")
                fecha = params[:datadeboxionale][:fecha].split("/")
                fecha = Time.new(fecha[2], fecha[1], fecha[0])
            else
                fecha = params[:datadeboxionale][:fecha].split("-")
                fecha = Time.new(fecha[0], fecha[1], fecha[2])
            end
			dia = ""
			mes = ""
			fecha_final = ""
			if params[:datadeboxionale][:idioma] == "es"
				case fecha.wday
					when 0
						dia = "Domingo"
					when 1
						dia = "Lunes"
					when 2
						dia = "Martes"
					when 3
						dia = "Miercoles"
					when 4
						dia = "Jueves"
					when 5
						dia = "Viernes"
					when 6
						dia = "Sabado"
				end
				case fecha.month
					when 1
						mes = "Enero"
					when 2
						mes = "Febrero"
					when 3
						mes = "Marzo"
					when 4
						mes = "Abril"
					when 5
						mes = "Mayo"
					when 6
						mes = "Junio"
					when 7
						mes = "Julio"
					when 8
						mes = "Agosto"
					when 9
						mes = "Septiembre"
					when 10
						mes = "Octubre"
					when 11
						mes = "Noviembre"
					when 12
						mes = "Diciembre"
				end
				fecha_final = dia.to_s + ", " + fecha.mday.to_s + " de " + mes
			else 
				case fecha.wday
					when 0
						dia = "Sunday"
					when 1
						dia = "Monday"
					when 2
						dia = "Tuesday"
					when 3
						dia = "Wednesday"
					when 4
						dia = "Thursday"
					when 5
						dia = "Friday"
					when 6
						dia = "Saturday"
				end
				case fecha.month
					when 1
						mes = "January"
					when 2
						mes = "February"
					when 3
						mes = "March"
					when 4
						mes = "April"
					when 5
						mes = "May"
					when 6
						mes = "June"
					when 7
						mes = "July"
					when 8
						mes = "August"
					when 9
						mes = "September"
					when 10
						mes = "October"
					when 11
						mes = "November"
					when 12
						mes = "December"
				end
				fecha_final = dia.to_s + ", " + mes + fecha.mday.to_s 
			end
			params[:datadeboxionale][:fecha_dia] = fecha_final
			params[:datadeboxionale][:dia] = fecha.yday
			@deboxional= Datadeboxionale.new(params[:datadeboxionale])
			puts @deboxional
			respond_to do |format|
				if @deboxional.save
					format.html { redirect_to :action => :edit, :id=>@deboxional.id }
					format.json { render json: @deboxional, status: :created, location: @deboxional }
				else
					format.html { render action: "new" }
					format.json { render json: @deboxional.errors, status: :unprocessable_entity }
				end
			end
		end
	end

	def update
		xuser = current_user
		if signed_granted?(xuser.id, 'datadeboxionales', 'N')
			@deboxional= Datadeboxionale.find(params[:id])
            fecha = ""
            if params[:datadeboxionale][:fecha].include?("/")
                fecha = params[:datadeboxionale][:fecha].split("/")
                fecha = Time.new(fecha[2], fecha[1], fecha[0])
            else
                fecha = params[:datadeboxionale][:fecha].split("-")
                fecha = Time.new(fecha[0], fecha[1], fecha[2])
            end
            dia = ""
            mes = ""
            fecha_final = ""
            if params[:datadeboxionale][:idioma] == "es"
                case fecha.wday
                    when 0
                    dia = "Domingo"
                    when 1
                    dia = "Lunes"
                    when 2
                    dia = "Martes"
                    when 3
                    dia = "Miercoles"
                    when 4
                    dia = "Jueves"
                    when 5
                    dia = "Viernes"
                    when 6
                    dia = "Sabado"
                end
                case fecha.month
                    when 1
                    mes = "Enero"
                    when 2
                    mes = "Febrero"
                    when 3
                    mes = "Marzo"
                    when 4
                    mes = "Abril"
                    when 5
                    mes = "Mayo"
                    when 6
                    mes = "Junio"
                    when 7
                    mes = "Julio"
                    when 8
                    mes = "Agosto"
                    when 9
                    mes = "Septiembre"
                    when 10
                    mes = "Octubre"
                    when 11
                    mes = "Noviembre"
                    when 12
                    mes = "Diciembre"
                end
                fecha_final = dia.to_s + ", " + fecha.mday.to_s + " de " + mes
                else
                case fecha.wday
                    when 0
                    dia = "Sunday"
                    when 1
                    dia = "Monday"
                    when 2
                    dia = "Tuesday"
                    when 3
                    dia = "Wednesday"
                    when 4
                    dia = "Thursday"
                    when 5
                    dia = "Friday"
                    when 6
                    dia = "Saturday"
                end
                case fecha.month
                    when 1
                    mes = "January"
                    when 2
                    mes = "February"
                    when 3
                    mes = "March"
                    when 4
                    mes = "April"
                    when 5
                    mes = "May"
                    when 6
                    mes = "June"
                    when 7
                    mes = "July"
                    when 8
                    mes = "August"
                    when 9
                    mes = "September"
                    when 10
                    mes = "October"
                    when 11
                    mes = "November"
                    when 12
                    mes = "December"
                end
                fecha_final = dia.to_s + ", " + mes + fecha.mday.to_s 
            end
            params[:datadeboxionale][:fecha_dia] = fecha_final
            params[:datadeboxionale][:dia] = fecha.yday
			respond_to do |format|
				if @deboxional.update_attributes(params[:datadeboxionale])
					format.html { redirect_to :action => :edit, :id=>@deboxional.id }
					format.json { head :no_content }
				else
					format.html { render action: "edit" }
					format.json { render json: @deboxional.errors, status: :unprocessable_entity }
				end
			end
		end
	end
 
=begin 
	def destroy  
		@user = User.find(params[:id])
		@user.destroy

		respond_to do |format|
			format.html { redirect_to users_url }
			format.json { head :no_content }
		end
	end
=end

end
