class User < ActiveRecord::Base

	has_secure_password

	validates :email,
		presence: true,
		uniqueness: true,
		# email: true
		format: {
			with: /@/,
			message: "not a valid format"
		}

	validates :password, length: {minimum: 6}, on: :create

end