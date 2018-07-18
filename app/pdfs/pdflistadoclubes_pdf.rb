#!/usr/bin/env ruby
# encoding: utf-8
class PdflistadoclubesPdf < Prawn::Document
	require 'action_view'
	include ActionView::Helpers::NumberHelper
	include ActionView::Helpers::TranslationHelper
	def initialize(coleccion, camporee_id)
		super(:page_size => 'LETTER')
		camporee = Camporee.find(camporee_id)
		@pdfdefaults = getPdfDefaults(3)
		header(camporee)
		clubes(coleccion)	
	end
	
	def header(camporee)	
		text @pdfdefaults[0][0], size: @pdfdefaults[1][0].to_i, align: :center
		text @pdfdefaults[0][1], size: @pdfdefaults[1][1].to_i, align: :center
		text @pdfdefaults[0][2] + ": " + camporee.nombre, size: @pdfdefaults[1][2].to_i, align: :center
		text "\n", size: @pdfdefaults[1][3].to_i, align: :center
		text @pdfdefaults[0][3], align: :center
	end
	
	def clubes(clubes)
		categoria = ""
		table_data = [["Zona", "Club", "Participó en Evento"]]	
		table_colors = Array.new
		table_colors.push("FCFCFC")
		i = 0
		total_puntos = 0
		clubes.each do |club|
			i += 1
			table_data += [[club.zonaId, club.nombre, ""]]
			table_colors.push("FFFFFF")
		end
		table_data += [[""]]	
		table_data += [["","Cantidad Clubes: #{i.to_s}"]]	
		table(table_data, :column_widths => [@pdfdefaults[2][0].to_i, @pdfdefaults[2][1].to_i, @pdfdefaults[2][2].to_i], :row_colors => table_colors)
	end  	
end
