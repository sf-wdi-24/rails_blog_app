class User < ActiveRecord::Base
	
	has_secure_password

	has_many :posts, dependent: :destroy

	validates :email, presence: true, uniqueness: true
	validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
	validates :password, length: { minimum: 6 }
	
end
