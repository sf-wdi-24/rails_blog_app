class Post < ActiveRecord::Base
  belongs_to :user
  
  validates :image, presence: true
  validates :user_id, presence: true

  mount_uploader :image, ImageUploader

end
