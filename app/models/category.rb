class Category < ApplicationRecord
	validates :name, presence: true

	has_many :has_categories
	has_many :articles, through: :has_categories
	#Categories - Has_Categories - Articles (relación muchos a muchos)
end
