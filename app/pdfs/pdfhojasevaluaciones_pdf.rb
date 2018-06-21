#!/usr/bin/env ruby
# encoding: utf-8
class PdfhojasevaluacionesPdf < Prawn::Document
	require 'action_view'
	include ActionView::Helpers::NumberHelper
	include ActionView::Helpers::TranslationHelper
	include EclubHelper
	
	def initialize(evento, cabezera, detalles)
		super(:page_size => 'A4')
		camporee = Camporee.find(evento[0].camporee_id)
		@pdfdefaults = getPdfDefaults(2)
		if cabezera.size == 1 && detalles.size < 5
			header(camporee, evento[0])
			eventoDets(evento, cabezera, detalles)	
			header(camporee, evento[0])
			eventoDets(evento, cabezera, detalles)	
		else
			header(camporee, evento[0])
			eventoDets(evento, cabezera, detalles)	
		end
	end
	
	def header(camporee, evento)	
		text @pdfdefaults[0][0] + ": " + camporee.nombre, size: @pdfdefaults[1][0].to_i, align: :center
		text @pdfdefaults[0][1], align: :center
		text @pdfdefaults[0][2], align: :left
		text "\n"
		text @pdfdefaults[0][3], align: :left
	end
	
	def trailer()
		text "\n", size: @pdfdefaults[1][1].to_i
		text "Notas: _______________________________________________________________________"
		text "\n", size: @pdfdefaults[1][1].to_i
		text "_____________________________________________________________________________"
		text "\n", size: @pdfdefaults[1][1].to_i
		text "\n", size: @pdfdefaults[1][1].to_i
		text "_______________________________________________", align: :center
		text "Firma Director/Dirigente", align: :center
		text "\n", size: @pdfdefaults[1][1].to_i
		text "\n", size: @pdfdefaults[1][1].to_i
	end
	
	def eventoDets(evento, cabezera, detalles)
		categoria = ""
		i = 0
		evento.each do |e|
			table_data = [["Renglón: #{e.renglon_nombre}", "Evento: #{e.evento_nombre}"]]	
			table_data += [["Participantes: #{e.participantes}", "Tiempo: #{e.tiempo}"]]			
			table_colors = Array.new
			table_colors.push("F0F0F0")
			table_colors.push("F0F0F0")
			table(table_data, :column_widths => [@pdfdefaults[2][0].to_i, @pdfdefaults[2][1].to_i], :row_colors => table_colors)
			table_data = Array.new
			table_colors = Array.new
			cabezera.each do |c|
				if i != 0
					if cabezera.count > 1
						table_data = [["", ""]]
						table_colors.push("000000")
					end
				end
				table_data += [["#{c.criterio_nombre}", ""]]
				table_colors.push("FCFCFC")
				detalles.each do |d|
					if d.camporeeseventoscriterioscab_id == c.camporeeseventoscriterioscab_id
						table_data += [["#{d.detalle_nombre} (#{d.puntos_criterio_det})", ""]]
						table_colors.push("FFFFFF")
					end
				end
				table_data += [["Total: ", ""]]
				table_colors.push("F0F0F0")
				table(table_data, :column_widths => [@pdfdefaults[2][0].to_i,@pdfdefaults[2][1].to_i], :row_colors => table_colors)
				table_data = Array.new
				table_colors = Array.new
				i += 1
			end
		end
		trailer
	end  	
end
