class Preloteaplicacion < ActiveRecord::Base
  default_scope order: 'version_actual'
  attr_accessible :version_actual, :url_actual, :version_anterior,
:url_anterior, :comentarios
  self.table_name = "prelote_app"
end
