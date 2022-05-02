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
	resources :reporteparticipacionporeventos
	
	#Clubes
	resources :clubesarchivos, only: [:index, :new, :create, :destroy]
	resources :clubesformularios
	resources :formsegurocabs
	resources :formmatriculacabs

	get '/',  to: 'sessions#new'
	get '/signin',  to: 'sessions#new'
	get '/signout', to: 'sessions#destroy'
	get '/help',    to: 'static_pages#help'
	get '/about',   to: 'static_pages#about'
	get '/contact', to: 'static_pages#contact'
	get '/taskusers', to: 'static_pages#taskusers'
	get '/noautorizado', to: 'static_pages#noautorizado'
	root :to => "home#index"
end
