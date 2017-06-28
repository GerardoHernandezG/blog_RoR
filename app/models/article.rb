class Article < ApplicationRecord

	#modulo sobre la funcionalidad de aasm independiente de la gema
	include AASM 

	belongs_to :user #con esto hacemos join entre la tabla users y articles
	has_many :comments, dependent: :delete_all
	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: { minimum: 20 }

	#CATEGORIAS
	has_many :has_categories, dependent: :delete_all
	has_many :categories, through: :has_categories 

	has_attached_file :cover, :styles => { medium: "1280x720", thumb:"800x600" },
                      :default_url => "/images/:style/missing.png",
                      :url  => ":s3_domain_url",
                      :path => "public/images/:id/:style_:basename.:extension",
                      :storage => :fog,
                      :fog_credentials => {
                         provider: 'AWS',
                         aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
                         aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
                         region: 'us-east-2'
                      },
                      fog_directory: ENV["FOG_DIRECTORY"]

	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/
	#para subir archivos que solo los usuarios esperan que se suban

	before_save :set_visits_count #para validar cuando el contador de visitas sea nulo, si no hay nulos, usar el before_create sin validacion
	after_create :save_category

	#Custom setter, método que me permite asignar un valor al atributo de un objeto
	def categories=(value)
		@categories = value
	end

	def update_visits_count
		self.save if self.visits_count.nil? 
		self.update(visits_count: self.visits_count + 1)
	end	

	scope :publicados, ->{ where(aasm_state: "published") }
	scope :ultimos, ->{ order("created_at DESC") }
	#scope :ultimos, ->{ order("created_at DESC").limit(10) }	

	aasm do
	    state :in_draft, :initial => true
	    state :published

	    event :publish do
	      transitions :from => :in_draft, :to => :published
	    end	    

	    event :unpublish do
	      transitions :from => :published, :to => :in_draft
	    end
	end
	
	private

	def save_category
		unless @categories.nil?
			@categories.each do |category_id|
				HasCategory.create(category_id: category_id, article_id: self.id)
			end
		end
		
	end

	def set_visits_count
		self.visits_count ||= 0	
	end
end
