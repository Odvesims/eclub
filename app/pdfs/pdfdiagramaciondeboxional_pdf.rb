class PdfdiagramaciondeboxionalPdf < Prawn::Document
	require 'action_view'
	include ActionView::Helpers::NumberHelper
	include ActionView::Helpers::TranslationHelper
	def initialize(coleccion)
		super(:page_size => [528,816], :top_margin => 45, :bottom_margin => 25, :page_layout => :portrait)
		#@deboxionales = Deboxionale.where("anio = '2018' AND idioma= 'es'").first
		#header(@deboxionales)
		frontPage
		coleccion.each do |deboxional|
			deboxionales(deboxional, 2)	
		end
	end
	def frontPage()
		start_new_page
		text "\n", size: 20, align: :center	
		text "\n", size: 20, align: :center	
		text "\n", size: 20, align: :center		
		text "\n", size: 20, align: :center	
		text "\n", size: 20, align: :center	
		text "\n", size: 20, align: :center		
		text "\n", size: 20, align: :center	
		text "\n", size: 20, align: :center	
		font Rails.root.join("app/assets/fonts/CaviarDreams_Bold.ttf")
		text "Deboxional 2018", size: 50, align: :center	
		font Rails.root.join("app/assets/fonts/CaviarDreams.ttf")
		text "by theboxion", size: 20, align: :center	
		start_new_page
	end
	
	def thanksgiving()
	
	end
	
	def backPage()
	
	end
	def deboxionales(deboxional, index)
		#font "Myriad Pro"
		#font Rails.root.join("app/assets/fonts/CaviarDreams.ttf")
		#text deboxional.fecha_dia, size: 12, align: :left
		#move_cursor_to 600
		#text "Deboxional " + deboxional.anio, size: 12, align: :right
		#move_cursor_to 600
		#line [0,588], [480,588]
		#stroke
		#move_cursor_to 582
		text "\n", size: 11, align: :center
		font Rails.root.join("app/assets/fonts/Century-Gothic-Bold.ttf")
		text deboxional.titulo, size: 18, align: :left
		if deboxional.autor.include? 'Adonay'	
			image "app/assets/images/adonay.png", :at => [1,710], align: :center, :width => 25, :height => 25	
		elsif deboxional.autor.include? 'Andelson'	
			image "app/assets/images/andelson.png", :at => [1,710], align: :center, :width => 25, :height => 25	
		elsif deboxional.autor.include? 'Andy'	
			image "app/assets/images/andy.png", :at => [1,710], align: :center, :width => 25, :height => 25	
		elsif deboxional.autor.include? 'Carolyn'
			image "app/assets/images/carolyn.png", :at => [1,710], align: :center, :width => 25, :height => 25		
		elsif deboxional.autor.include? 'Christopher'
			image "app/assets/images/christopher.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Cindy Rodr'
			image "app/assets/images/cindyr.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Cristian'
			image "app/assets/images/cristian.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Daysi'
			image "app/assets/images/daysi.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'nyeris'
			image "app/assets/images/dinanyeris.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Elar'
			image "app/assets/images/elar.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Esther'
			image "app/assets/images/esther.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Flordalisa'
			image "app/assets/images/flordalisa.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Jaalix'
			image "app/assets/images/jaalix.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Jahdiel'
			image "app/assets/images/jahdiel.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Josu'
			image "app/assets/images/josue.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Karina'
			image "app/assets/images/karina.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Michel'
			image "app/assets/images/michel.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Natasha'
			image "app/assets/images/natasha.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Noem'
			image "app/assets/images/noemi.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Odelsa'
			image "app/assets/images/odelsa.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Rafael'
			image "app/assets/images/rafael.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Richard'
			image "app/assets/images/richard.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Mella J'
			image "app/assets/images/rocio.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Rosaura'
			image "app/assets/images/rosarua.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Rosmery'
			image "app/assets/images/rosmery.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Ruth'
			image "app/assets/images/ruth.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Sarah'
			image "app/assets/images/sarah.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Yadira'
			image "app/assets/images/yadira.png", :at => [1,710], align: :center, :width => 25, :height => 25
		elsif deboxional.autor.include? 'Yonatan '
			image "app/assets/images/yonatan.png", :at => [1,710], align: :center, :width => 25, :height => 25
		else
			image "app/assets/images/perfil.png", :at => [1,710], align: :center, :width => 25, :height => 25
		end
		font Rails.root.join("app/assets/fonts/Century-Gothic.ttf")
		text_box(deboxional.autor, {size: 10, overflow: 'truncate', width: 300, align: :left, at: [27,695]})
		font Rails.root.join("app/assets/fonts/CaviarDreams_Bold.ttf")
		fechaDia = deboxional.fecha_dia.split(",")
		text_box(fechaDia[0], {size: 14, overflow: 'truncate', width: 130, align: :center, at: [340,735]})
		text_box(fechaDia[1], {size: 16, overflow: 'truncate', width: 130, align: :center, at: [340,720]})
		font Rails.root.join("app/assets/fonts/CaviarDreams_Italic.ttf")
		text_box(deboxional.versiculo + ' ' + deboxional.cita, {size: 11, overflow: 'truncate', width: 130, align: :left, at: [340,675]})
		font Rails.root.join("app/assets/fonts/Century-Gothic.ttf")
		if deboxional.cuerpo.length > 2400
			text_box(deboxional.cuerpo, {size: 10, overflow: 'truncate', width: 330, align: :justify, at: [1,675]})
		else
			text_box(deboxional.cuerpo, {size: 12, overflow: 'truncate', width: 330, align: :justify, at: [1,675]})
		end
		font Rails.root.join("app/assets/fonts/Century-Gothic.ttf")
		text "\n", size: 11, align: :center
		font Rails.root.join("app/assets/fonts/Century-Gothic-Bold.ttf")
		index += deboxional.dia
		text_box(index.to_s, {size: 40, overflow: 'truncate', width: 130, align: :center, at: [355,80]})
		font Rails.root.join("app/assets/fonts/CaviarDreams.ttf")
		text_box("Deboxional " + deboxional.anio.to_s, {size: 10, overflow: 'truncate', width: 130, align: :center, at: [355,40]})
		#text_box("theboxion", {size: 10, overflow: 'truncate', width: 130, align: :center, at: [-40,45]})
		start_new_page
=begin		vemp = Empresa.where("id = 1").first
		vtelemp = Empresastelefono.where("empresa_id = #{vemp.id}").first
		text vemp.nombre_empresa, size: 16, Style: :bold, align: :center
		text @divem.descripcion, size: 14, style: :bold, align: :center
		text vemp.direccion+', '+vemp.ciudad, size: 12, Style: :bold, align: :center
		text 'RNC:'+vemp.rnc+', Telefono:'+vtelemp.telefono, size: 12, Style: :bold, align: :center
		text '                                  '
		i = 0
		cabezera = Array.new
		motivo = Motivo.where("id = #{@prestamoscab.motivo_id}").first 
		cabezera[0] = motivo.descripcion	
		cabezera[1] = @prestamoscab.ncf
		while i < cabezera.size
			text cabezera[i], size: 14, style: :bold, align: :center
			i+= 1
		end
	
		text '                                  '
		linea = 'Numero: ' + @prestamoscab.documento_num.to_s
		i = linea.length
		linea_blanco = '_'
		while i < 88
			linea_blanco+= '_'
			i+= 1
		end
		data_head = [['Numero: ', @prestamoscab.documento_num.to_s, '', '', '', 'Fecha: ', @prestamoscab.fecha.to_s]]
		data_head += [['Cliente: ', @prestamoscab.cliente.codigo + '- ' + @prestamoscab.cliente.nombre_cliente,'','','','','','']]
		data_head += [['Vendedor: ', @prestamoscab.vendedor.codigo + '- ' + @prestamoscab.vendedor.nombre, '','','','','','']]
		data_head += [['Monto: ', number_to_currency(@prestamoscab.monto_prestamo), ' ', 'Pagos: ', @prestamoscab.cantidad_pagos.to_s, 'Dias: ', @prestamoscab.cantidad_dias.to_s]]
		data_head += [['Interes: ', @prestamoscab.tasa_interes.to_s, ' ', 'Tasa: ', @prestamoscab.tipo_tasa.to_s, 'Tipo: ', @prestamoscab.tipo_interes.to_s]]
		table data_head do
			column(0).style :align => :left
			column(0).font_style = :bold
			column(0).style :width => 70
			column(1).style :align => :left
			column(1).style :width => 200
			column(2).style :align => :left
			column(3).style :align => :right
			column(3).style :width => 50
			column(3).font_style = :bold
			column(4).style :align => :left
			column(4).style :width => 30
			column(5).style :align => :right
			column(5).font_style = :bold
			column(5).style :width => 50
			column(6).style :width => 90
			self.cell_style = { size: 10.5, border_width: 0}
			self.width = 540
		end
		data = [['Pagare','Fecha','Cuota','Capital','Interes','Distribuir']]
		lineas = 0
		@total_cuota = 0
		@total_capital = 0
		@total_interes = 0
		mto_total = 0 
		@vccprestamosdet = Vccprestamosdet.where("prestamoscab_id=#{@prestamoscab.id}").all
		@vccprestamosdet.each do |t| 
			mto_total += t.monto_cuota 
		end 
		@vccprestamosdet.each do |d|
			lineas += 1 
			@total_cuota += d.monto_cuota
			@total_capital += d.monto_capital
			@total_interes += d.monto_interes
			data += [[d.pagare_num, d.fecha_letra, number_to_currency(d.monto_cuota, unit: ''),number_to_currency(d.monto_capital, unit: ''),number_to_currency(d.monto_interes, unit: ''),number_to_currency(mto_total - @total_cuota, unit: '') ]]
		end
		data += [['', 'Totales', number_to_currency(@total_cuota), number_to_currency(@total_capital), number_to_currency(@total_interes), '']]
		table data do
			row(0).font_style = :bold
			row(0).style :background_color=> 'DDDDDD'
			column(0).style :align => :left
			column(0).style :width => 90
			column(1).style :align => :left
			column(1).style :width => 90
			column(2).style :align => :right
			column(2).style :width => 90
			column(3).style :align => :right
			column(3).style :width => 90
			column(4).style :align => :right
			column(4).style :width => 90
			column(5).style :align => :right
			column(5).style :width => 90
			row(lineas + 1).style :background_color=> 'D9EFF3'
			row(lineas + 1).font_style = :bold				
			self.header = true
			self.row_colors = ['FFFFFF', 'FFFFFF']
			self.cell_style = { size: 10, border_width: 0}
			self.width = 540
		end
		text '                                  '		
		print_trailer
=end
	end  
	
	def print_trailer
		last_linea = 'Generado' + ': ' + Date.today.strftime("%d/%m/%Y")+ ', ' + Time.now.to_s + ', ' + 'Por' + ': ' + @usuario
		text ' ', size: 8, style: :bold 
		text last_linea, size: 8, style: :bold, align: :center
	end	
end
