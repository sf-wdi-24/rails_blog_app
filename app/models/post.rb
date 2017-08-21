class Post < ActiveRecord::Base

	validates :title, presence: true, length: {minimum: 3}, format: { with: /dino/i,
    				 message: "Please use the word dinosaurs" }
	validates :content, presence: true, length: {minimum: 10}, format: { with: /dino/i,
    				 message: "Please use the word dinosaurs" }

	belongs_to :user

end
