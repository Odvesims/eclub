#!/usr/bin/env ruby
# encoding: utf-8
class PdflistadoclubesPdf < Prawn::Document
	require 'action_view'
	include ActionView::Helpers::NumberHelper
	include ActionView::Helpers::TranslationHelper
	def initialize(coleccion, camporee_id)
		super(:page_size => 'LETTER')
		camporee = Camporee.find(camporee_id)
		header(camporee)
		clubes(coleccion)	
	end
	
	def header(camporee)	
		text "Asociación Dominicana del Sureste", size: 20, align: :center
		text "Comisión de Aventureros", size: 16, align: :center
		text "Camporee de Aventureros: " + camporee.nombre, size: 14, align: :center
		text "\n", size: 14, align: :center
		text "Listado Clubes Presente", align: :center
	end
	
	def clubes(clubes)
		categoria = ""
		table_data = [["Zona", "Club", "Distrito", "Iglesia"]]	
		table_colors = Array.new
		table_colors.push("FCFCFC")
		i = 0
		total_puntos = 0
		clubes.each do |club|
			i += 1
			table_data += [[club.zonaId, club.nombre, club.distrito_nombre, club.iglesia_nombre]]
			table_colors.push("FFFFFF")
		end
		table_data += [[""]]	
		table_data += [["","Cantidad Clubes: #{i.to_s}"]]	
		table(table_data, :column_widths => [50, 170, 140, 140], :row_colors => table_colors)
	end  	
end
