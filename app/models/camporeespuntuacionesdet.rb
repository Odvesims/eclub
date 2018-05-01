class Camporeespuntuacionesdet < ApplicationRecord
	def nombre_criterio
		criterio = Camporeeseventoscriteriosdet.find(self.camporeeseventoscriteriosdet_id)
		nombre_criterio = criterio.nombre
	end
end
