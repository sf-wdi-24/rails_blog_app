require "rails_helper"
require "factory_girl_rails"

RSpec.describe BikesController, type: :controller do

	describe "#destroy" do
		before do 
			bike = FactoryGirl.create(:bike) 
			@bike_count = Bike.count
			delete :destroy, id: bike.id

		end

		it "should remove bike from the database" do 
			expect(Bike.count).to eq(@bikes_count - 1)
		end

		it "should redirect_to 'root_path'" do
			expect(response.status).to be(302)
			expect(response).to redirect_to(root_path)
		end
	end
end