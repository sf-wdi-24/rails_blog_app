class BikesController < ApplicationController

	def index
		@bikes = Bike.all

		render :index
	end
end
