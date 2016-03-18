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

	def update
		name = params[:exercise_type][:name]
		et = ExerciseType.new(:user_id => session[:user_id], :name => name)

		et = ExerciseType.find(params[:exercise_id])

		if et.save
			render json: {:status => 'updated', :name => name, :id => et.id}
		else
			render json: {:status => 'failed'}
		end
	end

	def destroy
		if session[:user]
			et = ExerciseType.find(params[:id])
			if et.user_id == session[:user_id]
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
