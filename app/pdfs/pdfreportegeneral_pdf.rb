#!/usr/bin/env ruby
# encoding: utf-8
class PdfreportegeneralPdf < Prawn::Document
	require 'action_view'
	include ActionView::Helpers::NumberHelper
	include ActionView::Helpers::TranslationHelper
	def initialize(coleccion)
		super(:page_size => 'LETTER')
		#@deboxionales = Deboxionale.where("anio = '2018' AND idioma= 'es'").first
		#header(@deboxionales)
		camporee = Camporee.find(coleccion[0].camporee_id)
		header(camporee)
		clubes(coleccion)	
	end
	
	def header(camporee)	
		text "Asociación Dominicana del Sureste", size: 20, align: :center
		text "Comisión de Aventureros", size: 16, align: :center
		text "Camporee de Aventureros: " + camporee.nombre, size: 14, align: :center
		text "\n", size: 14, align: :center
		text "Reporte General", align: :center
	end
	
	def clubes(clubes)
		categoria = ""
		table_data = [["Zona","Club", "Iglesia", "Puntuación", "Categoría"]]	
		table_colors = Array.new
		table_colors.push("F0F0F0")
		i = 0
		clubes.each do |club|
			i += 1
			cab = Camporeespuntuacionescab.where("iglesiasclube_id = #{club.iglesiasclube_id}").first
			if club.total_puntos >= 1000 
				categoria = "Excelencia"
			end 
			if club.total_puntos >= 900 && club.total_puntos < 1000 
				categoria = "Honorable"
			end 
			if club.total_puntos >= 800 && club.total_puntos < 900 
				categoria = "Destacado"
			end 
			if club.total_puntos < 800 
				categoria = "Participación"
			end 
			table_data += [[cab.zona_id, club.club_nombre, club.iglesia_nombre, club.total_puntos, categoria]]
			table_colors.push("FFFFFF")
		end
		table_data += [["", "Total: #{i.to_s}"]]	
		table(table_data, :column_widths => [50, 150, 150, 70, 90], :row_colors => table_colors)
	end  	
end
