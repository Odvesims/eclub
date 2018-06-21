class Camporeespuntuacionescab < ActiveRecord::Base
	attr_accessible :campo_id, :zona_id, :distrito_id, :iglesia_id, :iglesiasclube_id, :camporee_id, :camporeerenglone_id, 
				    :camporeesevento_id, :puntos_evento, :total_puntos, :camporeeseventoscriterioscab_id
	self.table_name = "camporeespuntuacionescabs"  

	def campo_nombre
		campo = Campo.find(self.campo_id)
		campo_nombre = campo.nombre
	end
	
	def zona_nombre
		zona = Zona.where("id = #{self.zona_id}").first
		zona_nombre = zona.nombre
	end
	
	def camporee_nombre
		camporee = Camporee.find(self.camporee_id)
		camporee_nombre = camporee.nombre
	end
	
	def renglon_nombre
		renglon = Camporeesrenglone.find(self.camporeerenglone_id)
		renglon_nombre = renglon.nombre
	end
	
	def evento_nombre
		evento = Camporeesevento.find(self.camporeesevento_id)
		evento_nombre = evento.nombre
	end
	
	def club_nombre
		club = Iglesiasclube.find(self.iglesiasclube_id)
		club_nombre = club.nombre
	end
	
	def iglesia_nombre
		club = Iglesiasclube.find(self.iglesiasclube_id)
		iglesia = Iglesia.find(club.iglesia_id)
		iglesia_nombre = iglesia.nombre
	end
	
	def criteriocab_nombre
		criteriocab = Camporeeseventoscriterioscab.find(self.camporeeseventoscriterioscab_id)
		criteriocab_nombre = criteriocab.nombre
	end
	
	def zonaId
		zona = Zona.find(self.zona_id)
		return zona.zona_id
	end
end
