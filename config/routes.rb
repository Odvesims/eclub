DeboxionApp::Application.routes.draw do
	root :to => 'deboxionalesformularios#index'
	resources :deboxionales
	resources :deboxionalesformularios
	resources :configuraciones
end
