class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :articles #en esta relacion un usuario puede tener muchos articulo
  has_many :comments #relacionar un usuario con varios comentarios
end
