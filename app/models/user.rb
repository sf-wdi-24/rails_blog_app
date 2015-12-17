class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  has_secure_password

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 7}
  
end
