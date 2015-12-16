class User < ActiveRecord::Base
  has_many :posts

  validates :name, presence: true, length: { maximum: 30 }
  validate :email, presence: true
  validates :password, presence: true, length: { minimum: 7}, 
end
