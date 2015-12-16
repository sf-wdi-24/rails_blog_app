class BikesController < ApplicationController

	def new
		@bike = Bike.new
		render :new
	end

	def index
		@bikes = Bike.all

		render :index
	end

	def create
		#create params
		bike_params = params.require(:bike).permit(:name, :description)

		#create a new bike
		bike = Bike. new(bike_params)

		# if bike saves, redirect to route that displays all bikes
		if bike.save
			redirect_to bike_path
			#redirect to /bikes
		end
	end
end
