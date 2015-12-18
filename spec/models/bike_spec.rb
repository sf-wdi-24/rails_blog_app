require 'rails_helper'

RSpec.describe Bike, type: :model do

  before do
  bike_params = Hash.new
  bike_params[:name] = FFaker::Lorem.word
  bike_params[:description] = FFaker::Lorem.word
 
  @bike = Bike.create(bike_params)

  end

  describe "#name" do
  	it "The bike has a name" do
  		expect(@bike.name).to eq("#{@bike.name}")
  end
	end

	 describe "#description" do
  	it "The bike has a description" do
  		expect(@bike.description).to eq("#{@bike.description}")
  end
	end
end
