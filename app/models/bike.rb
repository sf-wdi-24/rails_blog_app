class Bike < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true, length: { minimum: 6 }
end
