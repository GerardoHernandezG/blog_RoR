class ArticlesController < ApplicationController

	#Podemos crear un callback para evitar que los usuarios no loggeados entren a los métodos
	#Por ejemplo: si se crea un articulo sin estar loggeado va a dar error porque no hay ningun usuario asociado al articulo
	#entonces creamos éste método
	before_action :validate_user, except: [:show, :index, :edit]
	#con la funcion before_action, after_action ejecutamos callbacks
	before_action :set_article, except: [:index, :new,:create]
	before_action :authenticate_editor!, only: [:new, :create, :update]
	before_action :authenticate_admin!, only: [:destroy]

	#get /articles
	def index
		#declarar una variable de clase que se puede acceder tanto del controlador como de la vista
		@articles = Article.all
	end
	#get /articles/:id
	def show		
		#@article = Article.find(params[:id])
		@article.update_visits_count #metodo del modelo para incrementar el contador
		@comment = Comment.new #Cuando se agrega un subrecurso en el form, hay que agregarlo de esta manera en el recurso padre

		#si creamos un filtro de busqueda, podemos utilizar Active Record para hacer un where la bd
		#ejemplo: Article.where(" id =  ? OR title = ?", params[:id], params[:title])
		#ejemplo2: Article.where(" body LIKE ?", "%hola%")
		#no recomendable interpolar cadenas porque son suceptibles a sqlinjection
		#ejemplo: Article.where(" id =  #{params[:id]})
	end
	#get /articles/new
	def new		
		@article = Article.new
		@categories = Category.all
	end
	#post /articles
	def create		
		#con este método no se guarda en la base de datos, sólo se genera una instancia de article o un objeto @article
		#@article = Article.new(title: params[:article][:title], body: params[:article][:body])

		#si pasamos los paramtros del formulario de esta manera, se puede ser suceptible a ataques maliciosos
		#@article = Article.new(params[:article]) 

		#Si se utilizan strong params es mejor para evitar ataques
		#@article = Article.new(article_params) #crear articulos

		@article = current_user.articles.new(article_params) #crear articulos relacionados con un usuario 
		@article.categories = params[:categories]
		#raise params.to_yaml
		#guardar instancia
		#@article.valid? or @article.invalid? retorna verdadero o falso depende de las validaciones del model
		if @article.save
		 	redirect_to @article
		else
			render :new
		end
	end

	def destroy		
		#para no repetir tanto codigo se hace un callback llamado set_article y ese toma los metodos del codigo repetio en uno solo
		#@article = Article.find(params[:id])
		@article.destroy	
		redirect_to articles_path
	end

	def edit		
		#@article = Article.find(params[:id])
	end

	def update		
		#@article.update_attributes{}
		#@article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to @article
		else
			render :edit
		end
	end

 	#al definir private, todos los metodos creados despues de private van a ser accesibles solo desde la clase
	private

	#creamos el metodo validate_user que está en el before_action para validar que no entren usuarios no loggeados a algunos metodos
	def validate_user
		if !user_signed_in?
			redirect_to new_user_session_path, notice: "Necesitas Iniciar Sesión"
		end
	end

	def set_article
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title,:body,:cover,:categories)
	end
end