#!/usr/bin/env ruby
# encoding: utf-8
class PdfformularioclubPdf < Prawn::Document
	require 'action_view'
	include ActionView::Helpers::NumberHelper
	include ActionView::Helpers::TranslationHelper
	include ActionView::Helpers::TranslationHelper
	include EclubHelper
	def initialize(cabezera, detalles)
		super(:page_size => 'LETTER')
		camporee = Camporee.find(cabezera.camporee_id)
		@pdfdefaults = getPdfDefaults(1)
		header(camporee)
		detalles(cabezera, detalles)	
	end
	
	def header(camporee)	
		text @pdfdefaults[0][0], size: @pdfdefaults[1][0].to_i, align: :center
		text @pdfdefaults[0][1], size: @pdfdefaults[1][1].to_i, align: :center
		text @pdfdefaults[0][2] + ": " + camporee.nombre, size: @pdfdefaults[1][2].to_i, align: :center
	end
	
	def detalles(cabezera, detalles)
		categoria = ""
		case cabezera.campo_union
			when 'formmatriculacab_id'
				text "Formulario de Matriculación", size: @pdfdefaults[1][3].to_i, align: :center
				cab = Formmatriculacab.find(detalles[0].formmatriculacab_id)
				text "Club: " + cab.clubNombre + " | " + "Iglesia: " + cab.iglesiaNombre, size: @pdfdefaults[1][3].to_i, align: :center
				table_data = [["Tipo", "Nombre", "Sexo", "Edad", "Fecha Nacimiento"]]	
			when 'formsegurocab_id'
		end
		text "\n", size: @pdfdefaults[1][3].to_i, align: :center
		table_colors = Array.new
		table_colors.push("FCFCFF")
		i = 0
		total_puntos = 0
		detalles.each do |detalle|
			i += 1
			table_data += [[detalle.tipo_persona, detalle.nombre, detalle.sexo, detalle.edad, detalle.fecha_nacimiento]]
			table_colors.push("FFFFFF")
		end	
		case cabezera.campo_union
			when 'formmatriculacab_id'
				table(table_data, :column_widths => [@pdfdefaults[2][0].to_i, @pdfdefaults[2][1].to_i, @pdfdefaults[2][2].to_i, @pdfdefaults[2][3].to_i, @pdfdefaults[2][4].to_i], :row_colors => table_colors)	
			when 'formsegurocab_id'
				table(table_data, :column_widths => [@pdfdefaults[2][0].to_i, @pdfdefaults[2][1].to_i, @pdfdefaults[2][2].to_i], :row_colors => table_colors)
		end
	end
end
