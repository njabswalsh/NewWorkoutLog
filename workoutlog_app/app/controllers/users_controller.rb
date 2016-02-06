class UsersController < ApplicationController
	def home
	end

	def login
	end

	def post_login
		@user = User.find_by(login: params[:user_login])
		if @user
			if @user.password_valid?(params[:user_password])	
				session[:user] = @user
				session[:user_name] = @user.first_name
				session[:user_id] = @user.id
				redirect_to("/")
			else
				flash[:error] = "Sorry, that username and password do not match"
				redirect_to(:action => :login)
			end
		else
			flash[:error] = "Sorry, there is no user with that login"
			redirect_to(:action => :login)
		end
	end

	def new
	end

	def create
		if User.find_by(login: params[:login])
			flash[:error] = "Sorry, but that username is already taken."
			redirect_to(:action => :new)
		elsif params[:password_1] != params[:password_2]
			flash[:error] = "The passwords that you typed do not match."
			redirect_to(:action => :new)
		elsif User.create(params[:first_name], params[:last_name], params[:login], params[:password_1])
			flash[:message] = "Account created!"
			@user = User.find_by(login: params[:login])
			session[:user] = @user
			session[:user_name] = @user.first_name
			session[:user_id] = @user.id
			redirect_to(:action => :home)
		else
			flash[:error] = "There was a problem creating your account"
			redirect_to(:action => :new)
		end
	end

	def logout
		reset_session
		redirect_to(:action => :login)
	end
end
