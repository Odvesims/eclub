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
			deboxionales(deboxional)	
		end
	end
	def frontPage()
		font Rails.root.join("app/assets/fonts/CaviarDreams_Bold.ttf")
		text "Deboxional 2018", size: 50, align: :left	
		font Rails.root.join("app/assets/fonts/CaviarDreams.ttf")
		text "by theboxion", size: 20, align: :left	
		start_new_page
	end
	
	def thanksgiving()
	
	end
	
	def backPage()
	
	end
	def deboxionales(deboxional)
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
		font Rails.root.join("app/assets/fonts/Century-Gothic.ttf")
		text deboxional.autor, size: 10, align: :left
		font Rails.root.join("app/assets/fonts/CaviarDreams_Bold.ttf")
		fechaDia = deboxional.fecha_dia.split(",")
		text_box(fechaDia[0], {size: 15, overflow: 'truncate', width: 130, align: :center, at: [340,735]})
		text_box(fechaDia[1], {size: 20, overflow: 'truncate', width: 130, align: :center, at: [340,720]})
		font Rails.root.join("app/assets/fonts/CaviarDreams_Italic.ttf")
		text_box(deboxional.versiculo + ' ' + deboxional.cita, {size: 11, overflow: 'truncate', width: 130, align: :left, at: [340,680]})
		font Rails.root.join("app/assets/fonts/Century-Gothic.ttf")
		text_box(deboxional.cuerpo, {size: 12, overflow: 'truncate', width: 330, align: :justify, at: [1,680]})
		font Rails.root.join("app/assets/fonts/Century-Gothic.ttf")
		text "\n", size: 11, align: :center
		font Rails.root.join("app/assets/fonts/Century-Gothic-Bold.ttf")
		text_box(deboxional.dia.to_s, {size: 40, overflow: 'truncate', width: 130, align: :center, at: [355,80]})
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