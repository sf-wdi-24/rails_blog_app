class User < ActiveRecord::Base
	
	has_secure_password

	validates :password, length: {minimum: 6}, on: :create
	validates :email, presence: true, uniqueness: true,
		format: {
			with: /@/,
			message: "Please input valid email format"

		}
end