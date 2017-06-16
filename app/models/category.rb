class Category < ApplicationRecord
	validates :name, presence: true

	has_many :has_categories, dependent: :delete_all
	has_many :articles, through: :has_categories
end
