 ActiveSupport::Inflector.inflections do |inflect|
   inflect.irregular 'pregunta', 'preguntas'
   inflect.irregular 'iglesia', 'iglesias'
   inflect.uncountable %w( fish sheep )
 end