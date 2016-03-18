class ExerciseTypesController < ApplicationController
	respond_to :json
	def create
		name = params[:exercise_type][:name]
		new_et = ExerciseType.new(:user_id => session[:user_id], :name => name)
		if new_et.save
			render json: {:status => 'created', :name => name, :id => new_et.id}
		else
			render json: {:status => 'failed'}
		end
	end

	def destroy
		if session[:user]
			et = ExerciseType.find(params[:id])
			if et.user_id == session[:user_id]
				user = User.find(session[:user_id])
				favorites_list = user.favorites
				if favorites_list
					favorites_list = favorites_list.split(",")					
					if favorites_list.include? et.name
						favorites_list -= [et.name]
					end
					favorites_list = favorites_list.join(",")
					if favorites_list == ""
						favorites_list = nil
					end
					user.favorites = favorites_list
					user.save
				end
				et.destroy
				render json: {:status => 'success'}
			else
				render json: {:status => 'failed'}
			end
		else
			render json: {:status => 'failed'}
		end
	end
end
