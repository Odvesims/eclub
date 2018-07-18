module EclubHelper

	def fieldType(field_name)
		
		#Defines the tipe of field for the form. It returns an array containing:
			#[0] Field Type:				
				#1- Hiddenfield
				#1- Textfield
				#2- Datefield
				#3- Selectfield
			#[1] If it's enabled/disabled
			#[2] The text for the label
			#[3] The collection for the field
			#[4] The value in the collection
			#[5] The size class for the field
			
		case field_name
			when 'union_id'
				return [0, "true","Union", "@club", "union_id", "col-sm-3"]
			when 'campo_id'
				return [0, "true", "Campo", "@club", "campo_id", "col-sm-3"]
			when 'zona_id'
				return [0, "true", "Zona", "@club", "zona_id", "col-sm-3"]
			when 'distrito_id'
				return [1, "true", "Distrito", "@distrito", "nombre", "col-sm-3"]
			when 'iglesia_id'
				return [1, "true", "Iglesia", "@iglesia", "nombre", "col-sm-3"]
			when 'iglesiasclube_id'
				return [1, "true", "Club", "@club", "nombre", "col-sm-3"]
			when 'nombre_pastor'
				return [1, "false", "Nombre Pastor", "", "", "col-sm-5"]
			when 'fecha_desde'
				return [2, "true", "Fecha Desde", "#fecha", "", "col-sm-2"]
			when 'fecha_hasta'
				return [2, "true", "Fecha Hasta", "#fecha", "", "col-sm-2"]
			when 'fecha'
				return [2, "true", "Fecha", "#fecha", "", "col-sm-2"]
			when 'fecha_nacimiento'
				return [2, "true", "Fecha de Nacimiento", "#fecha_nacimiento", "", "col-sm-2"]
			when 'nombre_director'
				return [1, "false", "Nombre Director", "", "", "col-sm-5"]
			when 'sexo'
				return [3, "false", "Sexo", "", "", "col-sm-5"]
			when 'tipopersona_id'
				return [3, "false", "Tipo Persona", "", "", "col-sm-5"]
		end
	end
	
	def detLabel(detName)
		#Return array with the details for the label in a table
		#[0] : The text for the label
		#[1] : The size for the label's container
		case detName
			when 'tipopersona_id'
				return ["Tipo", "8%"]
			when 'nombre'
				return ["Nombre", "20%"]
			when 'sexo'
				return ["Sexo", "6%"]
			when 'edad'
				return ["Edad", "4%"]
			when 'fecha_nacimiento'
				return ["Fecha de Nacimiento", "13%"]
			when 'nombre_tutor'
				return ["Nombre Padre/Tutor", "20%"]
		end
	end
	
	def fieldValue(collection, name)		
		case name
			when 'id' 
				return collection.id 
			when 'nombre' 
				return collection.nombre 
		end 
	end
	
	def true?(obj)
		obj.to_s == "true"
	end
	
	def getPdfDefaults(pdfIndex)
		pdfdefaults = Pdfdefault.find(pdfIndex)
		arrFonts = pdfdefaults.fonts_sizes.split(",")
		arrHeader = pdfdefaults.headers_text.split(",")
		arrColumns = pdfdefaults.columns_widths.split(",")
		return [arrHeader, arrFonts, arrColumns]
	end
	
end
