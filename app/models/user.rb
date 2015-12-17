class User < ActiveRecord::Base
	validates :name, :email, :password, :password_confirmation, 
						presence: true
	validates :name, :email, 
						uniqueness: true
	validates :password, 
						confirmation: true,
						length: { minimum: 6 }
	validates :email, 
						format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
	has_secure_password
	has_many :posts, dependent: :destroy
end
