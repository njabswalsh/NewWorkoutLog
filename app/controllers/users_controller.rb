class UsersController < ApplicationController
	def home
	end

	def login
	end

	def post_login
		@user = User.find_by(login: params[:user_login].downcase)
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

	def add_favorite
		user = User.find(session[:user_id])
		et = ExerciseType.find(params[:id])
		if user.favorites
			favorites_list = user.favorites + "," + et.name
		else
			favorites_list = et.name
		end
		user.favorites = favorites_list


		if user.save
			render json: {:status => 'favorite_added', :favorites => favorites_list, :id => user.id}
		else
			render json: {:status => 'failed'}
		end
	end

	def delete_favorite
		user = User.find(session[:user_id])
		et = ExerciseType.find(params[:id])
		if user.favorites
			favorites_list = user.favorites.split(",")
			if favorites_list.include? et.name
				favorites_list -= [et.name]
				favorites_list = favorites_list.join(",")
			end

		else
			favorites_list = et.name
			#puts "UH OHHHH"
		end
		if favorites_list == ""
			favorites_list = nil
		end
		user.favorites = favorites_list


		if user.save
			#render json: {:status => 'favorite_added', :favorites => favorites, :id => user.id}
			render json: {:status => 'favorite_deleted', :favorites => favorites_list, :id => user.id}
		else
			render json: {:status => 'failed'}
		end
	end


	def create
		params[:login] = params[:login].downcase
		if User.find_by(login: params[:login])
			flash[:error] = "Sorry, but that username is already taken."
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
