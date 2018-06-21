DeboxionApp::Application.routes.draw do
	resources :sessions, only: [:new, :create, :destroy]
	
	#Sistema
	resources :users      
	resources :usersidiomas
	resources :usersperfil
	resources :userspasswd
	resources :roles
	resources :home
	
	#Mantenimientos
	resources :campos
	resources :zonas
	resources :distritos
	resources :iglesias
	resources :iglesiasclubes
	
	#Camporees
	resources :camporees
	resources :camporeesarchivos
	resources :camporeesrenglones
	resources :camporeeseventos
	resources :camporeeseventoscriterios
	resources :camporeespuntuacionescabs
	
	#Reportes
	resources :listadoclubes
	resources :reporteporclubes
	resources :reportegeneral
	resources :detallesporclubes
	resources :reporteporzonas
	resources :hojasevaluaciones
	
	#Clubes
	resources :clubesarchivos, only: [:index, :new, :create, :destroy]
	root :to=> "clubesarchivos#index"
	resources :clubesformularios
	resources :formsegurocabs
	resources :formmatriculacabs

	match '/',  to: 'sessions#new'
	match '/signin',  to: 'sessions#new'
	match '/signout', to: 'sessions#destroy', via: :delete
	match '/help',    to: 'static_pages#help'
	match '/about',   to: 'static_pages#about'
	match '/contact', to: 'static_pages#contact'
	match '/taskusers', to: 'static_pages#taskusers'
	match '/noautorizado', to: 'static_pages#noautorizado'
	root :to => "home#index"
end
