class Post < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true, length: {minimum: 5}
  validates :body, presence: true, length: {minimum: 10}
  validates :image, presence: true
  validates :user_id, presence: true

  mount_uploader :image, ImageUploader

end
