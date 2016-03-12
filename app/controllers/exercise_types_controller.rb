class ExerciseTypesController < ApplicationController
	respond_to :json
	def create
		name = params[:exercise_type][:name]
		new_et = ExerciseType.new(:user_id => session[:user_id], :name => name)
		if new_et.save
			render json: {:status => 'created', :name => name}
		else
			render json: {:status => 'failed'}
		end
		
	end
end
