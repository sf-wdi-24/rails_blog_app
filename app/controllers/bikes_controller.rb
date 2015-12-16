class BikesController < ApplicationController

	def new
		@bike = Bike.new
		render :new
	end

	def show
		bike_id = params[:id]

		@bike = Bike.find_by_id(bike_id)

		render :show
	end

	def index
		@bikes = Bike.all

		render :index
	end
	def edit
		bike_id = params[:id]
		#get bike id and save it
		@bike = Bike.find_by_id(bike_id)
		#render the edit view
		render :edit
	end

	def create
		#create params
		bike_params = params.require(:bike).permit(:name, :description)

		#create a new bike
		bike = Bike.new(bike_params)

		# if bike saves, redirect to route that displays all bikes
		if bike.save
			redirect_to bike_path(bike)

			#redirect to /bikes
		end
	end
end
