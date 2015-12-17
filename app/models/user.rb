class User < ActiveRecord::Base
	
	has_secure_password

	has_many :posts, dependent: :destroy

	validates :email, presence: true, uniqueness: true, format: { with: /\w+@\w+.\w+/,
    				 message: "Please enter valid email" }
	validates :password, presence: true, length: {minimum: 6} 

end


