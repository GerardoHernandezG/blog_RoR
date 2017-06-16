class User < ApplicationRecord 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :articles 
  has_many :comments 
  include PermissionsConcern 
end
