class User < ActiveRecord::Base
	# has_secure_password
	validates :email, presence: true, uniqueness: true
	validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
	validates :password, presence: true, length: { minimum: 6 }
	
end
