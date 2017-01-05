DeboxionApp::Application.routes.draw do
	root :to => 'deboxionalesformularios#index'
	resources :deboxionales
	resources :cambiodatas
	resources :dataversion
	resources :deboxionalesformularios
	resources :configuraciones
	resources :preguntas
	match '/Prelote.update', to: 'upgradeprelote#index'
end
