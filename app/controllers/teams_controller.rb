class TeamsController < ApplicationController
	def index
	end

	def new
	end

	def view
		if session[:user]
			if not params[:id]
				redirect_to(:action => :index)
			end
			@team = Team.find_by(id: params[:id])
			if not @team
				redirect_to(:action => :index)
			else
				user = User.find_by(id: session[:user_id])
				if not @team.users.include? user
					flash[:error] = "You are not a member of that team!"
					redirect_to(:action => :join)
				end
			end
		end
	end

	def create
		if Team.find_by(name: params[:team_name])
			flash[:error] = "Sorry, there is already a team with that name. "
			redirect_to(:action => :new)
		elsif Team.create(params[:team_name], params[:team_password])
			team = Team.find_by(name: params[:team_name])
			user = User.find(session[:user_id])
			user.teams << team
			redirect_to(:action => :index)
		else
			flash[:error] = "There was a problem creating your new team"
			redirect_to(:action => :new)
		end
	end

	def join
	end

	def post_join
		if session[:user_id]
			user = User.find(session[:user_id])
			team = Team.find_by(name: params[:team_name])
			if team
				if user.teams.include? team
					flash[:error] = "You're already a member of " + team.name + "!"
					redirect_to(:action => :join)
				elsif team.password_valid?(params[:team_password])
					user.teams << team
					redirect_to :action => :index
				else
					flash[:error] = "Sorry, that team name and password do not match"
					redirect_to(:action => :join)
				end
			else
				flash[:error] = "Sorry, there is no team with that name"
				redirect_to(:action => :join)
			end
		else
			flash[:error] = "You must be logged in to join a team"
			redirect_to(:action => :join)
		end
	end

end
