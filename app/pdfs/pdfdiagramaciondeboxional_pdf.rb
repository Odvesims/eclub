#!/usr/bin/env ruby
# encoding: utf-8
class PdfdiagramaciondeboxionalPdf < Prawn::Document
	require 'action_view'
	include ActionView::Helpers::NumberHelper
	include ActionView::Helpers::TranslationHelper
	def initialize(coleccion)
		super(:page_size => [624,816], :top_margin => 45, :bottom_margin => 25, :page_layout => :portrait)
		#@deboxionales = Deboxionale.where("anio = '2018' AND idioma= 'es'").first
		#header(@deboxionales)
		info
		sponsors
		a = 1
		coleccion.each do |deboxional|
			#if a < 5 then
				deboxionales(deboxional, 2)	
			#end
			#a+= 1
		end
		sponsors
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
		#image "app/assets/images/3.jpeg", :at => [0,816], align: :left, :width => 555, :height => 845
		text "Deboxional 2018", size: 50, align: :center	
		font Rails.root.join("app/assets/fonts/CaviarDreams.ttf")
		text "by theboxion", size: 20, align: :center	
		start_new_page
	end
	
	def info()
		image "app/assets/images/theboxion.jpg", :at => [330,650], align: :left, :width => 160, :height => 120
		font Rails.root.join("app/assets/fonts/CaviarDreams_Bold.ttf")
		text_box('Capellán', {size: 13, overflow: 'truncate', width: 120, align: :center, at: [355,530]})
		font Rails.root.join("app/assets/fonts/CaviarDreams.ttf")
		text_box("Héctor Lizardo", {size: 13, overflow: 'truncate', width: 120, align: :center, at: [355,515]})
		font Rails.root.join("app/assets/fonts/CaviarDreams_Bold.ttf")
		text_box('Diseño de Portada', {size: 13, overflow: 'truncate', width: 120, align: :center, at: [355,475]})
		font Rails.root.join("app/assets/fonts/CaviarDreams.ttf")
		text_box("Paoly Almonte", {size: 13, overflow: 'truncate', width: 120, align: :center, at: [355,460]})
		font Rails.root.join("app/assets/fonts/CaviarDreams_Bold.ttf")
		text_box('Diagramación', {size: 13, overflow: 'truncate', width: 120, align: :center, at: [355,420]})
		font Rails.root.join("app/assets/fonts/CaviarDreams.ttf")
		text_box("Oscar Valdez", {size: 13, overflow: 'truncate', width: 120, align: :center, at: [355,405]})
		font Rails.root.join("app/assets/fonts/CaviarDreams_Bold.ttf")
		text_box('Desarrolladores App', {size: 13, overflow: 'truncate', width: 240, align: :center, at: [298,365]})
		font Rails.root.join("app/assets/fonts/CaviarDreams.ttf")
		text_box("Justo Sierra", {size: 13, overflow: 'truncate', width: 120, align: :center, at: [355,350]})
		text_box("Oscar Valdez", {size: 13, overflow: 'truncate', width: 120, align: :center, at: [355,335]})
		font Rails.root.join("app/assets/fonts/CaviarDreams_Bold.ttf")
		text_box('Editores', {size: 13, overflow: 'truncate', width: 120, align: :center, at: [355,295]})
		font Rails.root.join("app/assets/fonts/CaviarDreams.ttf")
		text_box("Dorca Ogando", {size: 13, overflow: 'truncate', width: 120, align: :center, at: [355,280]})
		text_box("Laisa Candelario", {size: 13, overflow: 'truncate', width: 120, align: :center, at: [355,265]})
		text_box("Leonisia Sosa", {size: 13, overflow: 'truncate', width: 120, align: :center, at: [355,250]})
		text_box("Neolfis De León", {size: 13, overflow: 'truncate', width: 120, align: :center, at: [355,235]})
		text_box("Odelsa Dishmey", {size: 13, overflow: 'truncate', width: 120, align: :center, at: [355,220]})
		text_box("Paul Rosario", {size: 13, overflow: 'truncate', width: 120, align: :center, at: [355,205]})
		text_box("Santa Méndez", {size: 13, overflow: 'truncate', width: 120, align: :center, at: [355,190]})
		text_box("Yoel Cueto", {size: 13, overflow: 'truncate', width: 120, align: :center, at: [355,175]})
		text_box("Santo Domingo", {size: 10, overflow: 'truncate', width: 120, align: :center, at: [355,100]})
		text_box("Republica Dominicana", {size: 10, overflow: 'truncate', width: 120, align: :center, at: [355,85]})
		text_box("© Copyright 2018", {size: 10, overflow: 'truncate', width: 120, align: :center, at: [355,70]})
		start_new_page
	end
	
	def sponsors()
		font Rails.root.join("app/assets/fonts/CaviarDreams_Bold.ttf")
		text "Patrocinadores", size: 25, align: :center	
		font Rails.root.join("app/assets/fonts/CaviarDreams.ttf")
		text "El Deboxional 2018 llega a ti gracias al patrocinio de...", size: 12, align: :center
		image "app/assets/images/dennysr.jpg", :at => [15,685], align: :left, :width => 175, :height => 82
		text_box("Tel: 809-704-0941", {size: 13, overflow: 'truncate', width: 120, align: :left, at: [45,590]})	
		text_box("FB: @dennysrichard", {size: 13, overflow: 'truncate', width: 120, align: :left, at: [46,575]})	
		text_box("IG: @dennysrichard", {size: 13, overflow: 'truncate', width: 120, align: :left, at: [47,560]})	
		text_box("TW: @dennysrichard", {size: 13, overflow: 'truncate', width: 120, align: :left, at: [45,545]})
		image "app/assets/images/sadef.jpg", :at => [355,685], align: :left, :width => 175, :height => 82
		font Rails.root.join("app/assets/fonts/CaviarDreams_Italic.ttf")
		text_box("Mi Pasión es Servirte", {size: 11, overflow: 'truncate', width: 120, align: :left, at: [390,600]})	
		font Rails.root.join("app/assets/fonts/CaviarDreams.ttf")
		text_box("Tel: 809-494-5000", {size: 13, overflow: 'truncate', width: 120, align: :left, at: [390,575]})	
		text_box("sadefmigratorios@gmail.com", {size: 13, overflow: 'truncate', width: 210, align: :left, at: [360,560]})
		image "app/assets/images/mabels.jpg", :at => [15,480], align: :left, :width => 175, :height => 82
		text_box("Tel: 829-887-7271", {size: 13, overflow: 'truncate', width: 120, align: :left, at: [45,390]})	
		text_box("IG: @marykay.imsb", {size: 13, overflow: 'truncate', width: 120, align: :left, at: [45,375]})	
		image "app/assets/images/damaxiny.jpg", :at => [355,495], align: :left, :width => 175, :height => 98
		text_box("Tel: 809-605-9975", {size: 13, overflow: 'truncate', width: 120, align: :left, at: [400,390]})		
		text_box("FB: Damaxini Photographer", {size: 13, overflow: 'truncate', width: 170, align: :left, at: [370,375]})
		text_box("IG: _xiny_photos", {size: 13, overflow: 'truncate', width: 120, align: :left, at: [400,360]})	
		start_new_page
		font Rails.root.join("app/assets/fonts/CaviarDreams_Bold.ttf")
		text "Patrocinadores", size: 25, align: :center	
		font Rails.root.join("app/assets/fonts/CaviarDreams.ttf")
		text "El Deboxional 2018 llega a ti gracias al patrocinio de...", size: 12, align: :center
		image "app/assets/images/ylcar.jpg", :at => [15,685], align: :left, :width => 175, :height => 178
		text_box("Tel: 809-598-7188", {size: 13, overflow: 'truncate', width: 120, align: :left, at: [50,495]})	
		text_box("FB: YlcaRestaurante", {size: 13, overflow: 'truncate', width: 120, align: :left, at: [50,480]})	
		text_box("IG: YlcaRestaurante", {size: 13, overflow: 'truncate', width: 120, align: :left, at: [50,465]})
		text_box("Av. Marginal de las Américas Km. 9 1/2,", {size: 10, overflow: 'truncate', width: 300, align: :left, at: [10,450]})		
		text_box("No. 80-G, Tercer Nivel, Tropical del Este,", {size: 10, overflow: 'truncate', width: 300, align: :left, at: [10,440]})		
		text_box("Santo Domingo Este, Rep. Dom.", {size: 10, overflow: 'truncate', width: 300, align: :left, at: [30,430]})		
		image "app/assets/images/bethel.jpg", :at => [355,685], align: :left, :width => 150, :height => 171
		text_box("Tel: 809-529-8433", {size: 13, overflow: 'truncate', width: 120, align: :left, at: [378,505]})	
		image "app/assets/images/centro.jpg", :at => [25,400], align: :left, :width => 150, :height => 150
		text_box("Tel: 809-414-3250", {size: 13, overflow: 'truncate', width: 120, align: :left, at: [45,240]})
		text_box("Cel: 829-885-1301", {size: 13, overflow: 'truncate', width: 120, align: :left, at: [45,225]})
		text_box("centroeducativomanantialdeluz@gmail.com", {size: 10, overflow: 'truncate', width: 300, align: :left, at: [10,210]})	
		start_new_page
	end
	
	def backPage()
	
	end
	def deboxionales(deboxional, index)
		case deboxional.dia
			when 121
				#image "app/assets/images/1.jpeg", :at => [0,816], align: :left, :width => 555, :height => 845
				#start_new_page
				#image "app/assets/images/2.jpeg", :at => [0,816], align: :left, :width => 555, :height => 845
				#start_new_page
			when 281
				#image "app/assets/images/3.jpeg", :at => [0,816], align: :left, :width => 555, :height => 845
				#start_new_page
				#image "app/assets/images/4.jpeg", :at => [0,816], align: :left, :width => 555, :height => 845
				#start_new_page
		end
		if deboxional.dia > 120
			#index+= 2
		elsif deboxional.dia > 280
			#index+= 4
		end
		text "\n", size: 11, align: :center
		font Rails.root.join("app/assets/fonts/Century-Gothic-Bold.ttf")
		text deboxional.titulo, size: 20, align: :left
		font Rails.root.join("app/assets/fonts/CaviarDreams_Bold.ttf")
		fechaDia = deboxional.fecha_dia.split(",")
		text_box(fechaDia[0], {size: 13, overflow: 'truncate', width: 130, align: :center, at: [430,735]})
		text_box(fechaDia[1], {size: 15, overflow: 'truncate', width: 170, align: :center, at: [410,720]})
		font Rails.root.join("app/assets/fonts/CaviarDreams_Italic.ttf")
		text_box(deboxional.versiculo + ' ' + deboxional.cita, {size: 11, overflow: 'truncate', width: 130, align: :left, at: [440,704]})
		font Rails.root.join("app/assets/fonts/Century-Gothic.ttf")
		if deboxional.cuerpo.length > 2400
			text_box(deboxional.cuerpo, {size: 12, overflow: 'truncate', width: 430, align: :justify, at: [1,704]})
		else
			text_box(deboxional.cuerpo, {size: 13, overflow: 'truncate', width: 430, align: :justify, at: [1,704]})
		end
		posXI = 1
		posYI = 80
		posXN = 54
		posYN = 40
		posXP = 455
		posYP = 80
		posXT = 455
		posYT = 40
		if deboxional.dia % 2 != 0
			posXI = 455
			posYI = 80
			posXN = 455
			posYN = 40
			posXP = 1
			posYP = 80
			posXT = 1
			posYT = 40
		end
		if deboxional.autor.include? 'Ana'	
			image "app/assets/images/ana.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Adonay'	
			image "app/assets/images/adonay.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50	
		elsif deboxional.autor.include? 'Andelson'	
			image "app/assets/images/andelson.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50	
		elsif deboxional.autor.include? 'Andy'	
			image "app/assets/images/andy.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50	
		elsif deboxional.autor.include? 'Carolyn'
			image "app/assets/images/carolyn.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50		
		elsif deboxional.autor.include? 'Christopher'
			image "app/assets/images/christopher.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Cindy D'
			image "app/assets/images/cindyd.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Cindy Rodr'
			image "app/assets/images/cindyr.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Clara'
			image "app/assets/images/clara.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Cristian'
			image "app/assets/images/cristian.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50	
		elsif deboxional.autor.include? 'Daysi'
			image "app/assets/images/daysi.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Deyanira'
			image "app/assets/images/deyanira.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'nyeris'
			image "app/assets/images/dinanyeris.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Elar'
			image "app/assets/images/elar.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Emmanuel'
			image "app/assets/images/emmanuel.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Esther'
			image "app/assets/images/esther.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Flordalisa'
			image "app/assets/images/flordalisa.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Jaalix'
			image "app/assets/images/jaalix.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Jahdiel'
			image "app/assets/images/jahdiel.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Jairo'
			image "app/assets/images/jairo.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Jarlin'
			image "app/assets/images/jarlin.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Jorge'
			image "app/assets/images/jorge.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Josu'
			image "app/assets/images/josue.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Karina'
			image "app/assets/images/karina.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Lizardo'
			image "app/assets/images/lizardo.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Michel'
			image "app/assets/images/michel.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Natasha'
			image "app/assets/images/natasha.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Neolfis'
			image "app/assets/images/neolfis.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Noem'
			image "app/assets/images/noemi.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Odelsa'
			image "app/assets/images/odelsa.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Rafael'
			image "app/assets/images/rafael.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Richard'
			image "app/assets/images/richard.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Mella J'
			image "app/assets/images/rocio.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Rosaura'
			image "app/assets/images/rosaura.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Rosmery'
			image "app/assets/images/rosmery.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Ruth'
			image "app/assets/images/ruth.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Sarah'
			image "app/assets/images/sarah.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Yadira'
			image "app/assets/images/yadira.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Yonatan '
			image "app/assets/images/yonatan.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		elsif deboxional.autor.include? 'Yosanna'
			image "app/assets/images/yosanna.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		else
			image "app/assets/images/perfil.png", :at => [posXI,posYI], align: :center, :width => 50, :height => 50
		end
		font Rails.root.join("app/assets/fonts/Century-Gothic.ttf")
		text_box(deboxional.autor, {size: 10, overflow: 'truncate', width: 300, align: :left, at: [posXN,posYN]})
		font Rails.root.join("app/assets/fonts/Century-Gothic.ttf")
		text "\n", size: 11, align: :center
		font Rails.root.join("app/assets/fonts/Century-Gothic-Bold.ttf")
		index += deboxional.dia
		text_box(index.to_s, {size: 40, overflow: 'truncate', width: 130, align: :center, at: [posXP,posYP]})
		font Rails.root.join("app/assets/fonts/CaviarDreams.ttf")
		text_box("Deboxional " + deboxional.anio.to_s, {size: 10, overflow: 'truncate', width: 130, align: :center, at: [posXT,posYT]})
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
