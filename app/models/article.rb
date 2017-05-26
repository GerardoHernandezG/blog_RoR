class Article < ApplicationRecord
	#metodo para validar campos de formulario a la base de datos
	#uniqueness es para que no se repita el dato, presence es requerido y lenght para la lingitud de la cadena
	#se pueden agregar varios atributos en el metodo validates
	belongs_to :user #con esto hacemos join entre la tabla users y articles
	has_many :comments
	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: { minimum: 20 }
	#establecer contador de visitas igual a 0 antes de crear articulos

	#before_create :set_visits_count

	#has_attached_file :cover, styles: { medium: "1280x720", thumb:"800x600" }
	has_attached_file :cover
	#para configurar las imagenes adjuntas

	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/
	#para subir archivos que solo los usuarios esperan que se suban

	before_save :set_visits_count #para validar cuando el contador de visitas sea nulo, si no hay nulos, usar el before_create sin validacion

	#before_save, before_validation

	def update_visits_count
		self.save if self.visits_count.nil? #si el contador es nulo guardar y asignarle 0, si no incrementar en 1
		self.update(visits_count: self.visits_count + 1)
	end

	private

	def set_visits_count
		self.visits_count ||= 0
		#|| operador or con el =, si el valor es nulo, asignar 0 si no no hacer nada
	end
end
