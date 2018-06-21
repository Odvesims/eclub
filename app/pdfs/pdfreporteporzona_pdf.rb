#!/usr/bin/env ruby
# encoding: utf-8
class PdfreporteporzonaPdf < Prawn::Document
	require 'action_view'
	include ActionView::Helpers::NumberHelper
	include ActionView::Helpers::TranslationHelper
	def initialize(coleccion, zona)
		super(:page_size => 'LETTER')
		camporee = Camporee.find(coleccion[0].camporee_id)
		@pdfdefaults = getPdfDefaults(4)
		header(camporee)
		clubes(coleccion, zona)	
	end
	
	def header(camporee)	
		text @pdfdefaults[0][0], size: @pdfdefaults[1][0].to_i, align: :center
		text @pdfdefaults[0][1], size: @pdfdefaults[1][1].to_i, align: :center
		text @pdfdefaults[0][2] + ": " + camporee.nombre, size: @pdfdefaults[1][2].to_i, align: :center
		text "\n", size: @pdfdefaults[1][3].to_i, align: :center
		text @pdfdefaults[0][3], align: :center
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
		table(table_data, :column_widths => [@pdfdefaults[2][0].to_i, @pdfdefaults[2][1].to_i, @pdfdefaults[2][2].to_i], :row_colors => table_colors)
	end  	
end
