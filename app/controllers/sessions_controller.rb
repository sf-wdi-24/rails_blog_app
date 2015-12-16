class SessionsController < ApplicationController

	def new
		if current_user
			redirect_to '/'
		else
			render :new
		end
	end

	def create
		if current_user
			redirect_to '/'
		else
			user = User.find_by_email(params[:email])
			if user && user.authenticate(params[:password])
				session[:user_id] = user.id
				redirect_to '/'
			else
				# flash[:error] = user.errors.full_messages.join(', ')
				redirect_to '/login'
			end
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to '/login'
	end

	private

	def user_params
  	params.require(:user).permit(:email, :password)
  end

end