class Article < ApplicationRecord
	#metodo para validar campos de formulario a la base de datos
	#uniqueness es para que no se repita el dato, presence es requerido y lenght para la lingitud de la cadena
	#se pueden agregar varios atributos en el metodo validates
	belongs_to :user #con esto hacemos join entre la tabla users y articles
	has_many :comments
	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: { minimum: 20 }

	#CATEGORIAS
	has_many :has_categories
	has_many :categories, through: :has_categories 

	#establecer contador de visitas igual a 0 antes de crear articulos
	#before_create :set_visits_count

	#has_attached_file :cover, styles: { medium: "1280x720", thumb:"800x600" }
	has_attached_file :cover
	#para configurar las imagenes adjuntas

	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/
	#para subir archivos que solo los usuarios esperan que se suban

	before_save :set_visits_count #para validar cuando el contador de visitas sea nulo, si no hay nulos, usar el before_create sin validacion
	after_create :save_category

	#before_save, before_validation

	#attr_reader :categories

	#Custom setter, método que me permite asignar un valor al atributo de un objeto
	def categories=(value)
		@categories = value
	end

	def update_visits_count
		self.save if self.visits_count.nil? #si el contador es nulo guardar y asignarle 0, si no incrementar en 1
		self.update(visits_count: self.visits_count + 1)
	end

	private

	def save_category
		@categories.each do |category_id|
			HasCategory.create(category_id: category_id, article_id: self.id)
		end
	end

	def set_visits_count
		self.visits_count ||= 0
		#|| operador or con el =, si el valor es nulo, asignar 0 si no no hacer nada
	end
end
