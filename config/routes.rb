Rails.application.routes.draw do
  
  resources :categories
  devise_for :users

  resources :articles do
      resources :comments, only: [:create, :update, :destroy, :show]
      #recurso anidado, comments es un subrecurso de articles 
  end
  #al poner resources: controlador, se acceden a todas las url o métodos del controlador sin tener que añadir cada url
  	# get "/articles"
  	# post "/articles"
  	# delete "/articles"
  	# get "/articles/:id" show
  	# get "/articles/new"
  	# get "/articles/:id/edit"
  	# patch "/articles/:id"
  	# put "/articles/:id"   

  root 'articles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/admin_articles', to: "welcome#admin_articles"

  #administrar usuarios
  get '/admin_usuarios', to: "users#admin_usuarios"
  get '/users/:id/edit', to: "users#edit"  
  get '/load_github', to: "users#load_github"
  post '/login_github', to: "users#login_github"
  resources :users

  #si se modifica un recurso ya existente entonces se pone otra ruta con la accion
  put '/articles/:id/publish', to: "articles#publish"
end
