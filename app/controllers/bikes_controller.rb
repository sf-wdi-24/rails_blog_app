class BikesController < ApplicationController

	# add a before_filter :authorize here??  Not sure if I need to secure the whole model 

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

	def update
		# get the bike id
		bike_id = params[:id]

		bike = Bike.find_by_id(bike_id)

		bike.update_attributes(bike_params)

		redirect_to bike_path(bike)
	end

	def destroy
		bike_id = params[:id]

		bike = Bike.find_by_id(bike_id)

		bike.destroy

		redirect_to bike_path
	end

	def create
		#create params
		bike_params = params.require(:bike).permit(:name, :description)

		#create a new bike
		bike = Bike.new(bike_params)

		# if bike saves, redirect to route that displays all bikes
		if bike.save
			redirect_to bike_path(bike)
		else 
			# save error messages to flash[:error] hash
			flash[:error] = bike.errors.full_messages.join(", ")
			redirect_to new_bike_path
		end

			#redirect to /bikes
	end
end
