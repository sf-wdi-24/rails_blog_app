class Post < ActiveRecord::Base
	validates :title, :content, 
						presence: true
	validates :title, 
						length: { minimum: 3 }
	validates :content, 
						length: { minimum: 10 }

	belongs_to :user
end
