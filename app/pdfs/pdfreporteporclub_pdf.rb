#!/usr/bin/env ruby
# encoding: utf-8
class PdfreporteporclubPdf < Prawn::Document
	require 'action_view'
	include ActionView::Helpers::NumberHelper
	include ActionView::Helpers::TranslationHelper
	def initialize(coleccion, club, iglesia, zona)
		super(:page_size => 'LETTER')
		#@deboxionales = Deboxionale.where("anio = '2018' AND idioma= 'es'").first
		#header(@deboxionales)
		camporee = Camporee.find(coleccion[0].camporee_id)
		header(camporee)
		clubes(coleccion, club, iglesia, zona)	
	end
	
	def header(camporee)	
		text "Asociación Dominicana del Sureste", size: 20, align: :center
		text "Comisión de Aventureros", size: 16, align: :center
		text "Camporee de Aventureros: " + camporee.nombre, size: 14, align: :center
		text "\n", size: 14, align: :center
		text "Resumen de Resultados por Club", align: :center
	end
	
	def clubes(clubes, club, iglesia, zona)
		categoria = ""
		table_data = [["Zona: #{zona.nombre}", "Iglesia: #{iglesia.nombre}", "Club: #{club.nombre}"]]	
		table_data += [["Renglón", "Evento", "Puntuación"]]	
		table_colors = Array.new
		table_colors.push("FCFCFC")
		table_colors.push("F0F0F0")
		i = 0
		total_puntos = 0
		clubes.each do |club|
			i += 1
			total_puntos += club.total_puntos
			table_data += [[club.renglon_nombre, club.evento_nombre, club.total_puntos]]
			table_colors.push("FFFFFF")
		end
		table_data += [["", "Cantidad Eventos: #{i.to_s}", "Total Puntos: #{total_puntos.to_s}"]]	
		table(table_data, :column_widths => [170, 170, 170], :row_colors => table_colors)
	end  	
end
