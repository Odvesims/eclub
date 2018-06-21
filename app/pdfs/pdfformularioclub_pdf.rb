#!/usr/bin/env ruby
# encoding: utf-8
class PdfformularioclubPdf < Prawn::Document
	require 'action_view'
	include ActionView::Helpers::NumberHelper
	include ActionView::Helpers::TranslationHelper
	def initialize(cabezera, detalles, font1, font2, font3, columnwidth[])
		super(:page_size => 'LETTER')
		camporee = Camporee.find(coleccion[0].camporee_id)
		header(camporee)
		clubes(coleccion, zona)	
	end
	
	def header(camporee)	
		text "Asociación Dominicana del Sureste", size: font1, align: :center
		text "Comisión de Aventureros", size: font2, align: :center
		text "Camporee de Aventureros: " + camporee.nombre, size: font3, align: :center
		text "\n", size: font3, align: :center
		text "Reporte de Resultados por Zona", align: :center
	end
	
	def clubes(clubes, zona)
		categoria = ""
		table_data = [["Zona: #{zona.nombre}"]]	
		table_data += [["Club", "Evento", "Puntuación"]]	
		table_colors = Array.new
		i = 0
		a = 0
		total_puntos = 0
		clubes.each do |club|
			if i > 0
				if club.camporeesevento_id != clubes[i - 1].camporeesevento_id
					table_data += [["Clubes Participantes:", a.to_s]]
					table_data += [["Club", "Evento", "Puntuación"]]
					a = 0
				end
			end
			total_puntos += club.total_puntos
			clubCurrent = Iglesiasclube.find(club.iglesiasclube_id)
			table_data += [[clubCurrent._nombre, club.evento_nombre, club.total_puntos]]
			table_colors.push("FFFFFF")
			i += 1
			a += 1
		end
		table_data += [["Clubes Participantes:", a]]
		table(table_data, :column_widths => [columnwidth[0], columnwidth[0], columnwidth[0]], :row_colors => table_colors)
	end  	
end
