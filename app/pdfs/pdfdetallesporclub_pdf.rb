#!/usr/bin/env ruby
# encoding: utf-8
class PdfdetallesporclubPdf < Prawn::Document
	require 'action_view'
	include ActionView::Helpers::NumberHelper
	include ActionView::Helpers::TranslationHelper
	def initialize(coleccion, club, iglesia, zona)
		super(:page_size => 'LETTER')
		#@deboxionales = Deboxionale.where("anio = '2018' AND idioma= 'es'").first
		#header(@deboxionales)
		camporee = Camporee.find(coleccion[0].camporee_id)
		@pdfdefaults = getPdfDefaults(5)
		header(camporee, zona, iglesia, club)
		clubes(coleccion, club, iglesia, zona)	
	end
	
	def header(camporee, zona_nombre, iglesia_nombre, club_nombre)
		table_colors = Array.new
		table_colors.push("996666")
		text @pdfdefaults[0][0], size: @pdfdefaults[1][0].to_i, align: :center
		text @pdfdefaults[0][0], size: @pdfdefaults[1][1].to_i, align: :center
		text @pdfdefaults[0][0] + ": " + camporee.nombre, size: @pdfdefaults[1][2].to_i, align: :center
		text "\n", size: @pdfdefaults[1][3].to_i, align: :center
		text @pdfdefaults[0][0], align: :center
		text "\n", size: @pdfdefaults[1][4].to_i, align: :center
		table_data = [["Zona: #{zona_nombre.nombre}", "Iglesia: #{iglesia_nombre.nombre}", "Club: #{club_nombre.nombre}"]]
		table(table_data, :column_widths => [@pdfdefaults[2][0].to_i, @pdfdefaults[2][0].to_i, @pdfdefaults[2][0].to_i], :row_colors => table_colors)	
	end
	
	def clubes(clubes, club, iglesia, zona)
		i = 0
		total_puntos = 0
		table_data = ""	
		table_data = [[{:content => "", :colspan => 3, :border_color=> "FFFFFF"}]] 
		table(table_data, :column_widths => [@pdfdefaults[2][0].to_i, @pdfdefaults[2][0].to_i, @pdfdefaults[2][1].to_i])	
		table_colors = Array.new
		clubes.each do |club|
			i += 1			
			categoria = ""
			table_data = [["Renglón", {:content => "Evento", :colspan => 2}]]
			total_puntos += club.total_puntos
			table_data += [["<b>#{club.renglon_nombre}</b>", {:content => "<b>#{club.evento_nombre}</b>", :colspan => 2}]]
			renglon = Camporeesrenglone.find(club.camporeerenglone_id)
			table(table_data, :column_widths => [@pdfdefaults[2][0].to_i, @pdfdefaults[2][0].to_i, @pdfdefaults[2][0].to_i], :row_colors => ["##{renglon.color}", nil, nil], :cell_style => { :inline_format => true })
			@cabezeras = Camporeespuntuacionescab.where("camporee_id = #{club.camporee_id} AND iglesiasclube_id = #{club.iglesiasclube_id} AND camporeesevento_id = #{club.camporeesevento_id}").all
			table_data = []
			@cabezeras.each do |cab| 
				table_colors.push("7544CC")
				@detalles = Camporeespuntuacionesdet.where("camporeespuntuacionescab_id = #{cab.id}").all 
				table_data += [[{:content => "<b>#{cab.criteriocab_nombre}</b>", :colspan => 3, :align=> :center}]]
				puntos_evento = 0 
				@detalles.each do |det|
					table_colors.push("FFFFFF")
					table_data += [[{:content => det.nombre_criterio, :colspan => 2, :align=> :right}, det.puntos]]
					puntos_evento += det.puntos
				end
				table_data += [[{:content => "Total Criterio", :colspan => 2, :align=> :right}, puntos_evento]]  
				table_data += [[{:content => "", :colspan => 3, :border_color=> "FFFFFF"}]]  
			end 
			table(table_data, :column_widths => [@pdfdefaults[2][0].to_i, @pdfdefaults[2][0].to_i, @pdfdefaults[2][0].to_i], :row_colors => ["FFFFFF", nil, nil], :cell_style => { :inline_format => true })
		end	
		table_data = [["Cantidad Eventos: #{i.to_s}", "Categoría: #{getCamporeeCategoria(clubes[0].camporee_id, total_puntos)}" , "Total Puntos: #{total_puntos.to_s}"]]	
		table(table_data, :column_widths => [@pdfdefaults[2][0].to_i, @pdfdefaults[2][0].to_i, @pdfdefaults[2][0].to_i], :row_colors => ["996600", nil, nil])
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
