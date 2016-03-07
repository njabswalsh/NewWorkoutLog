class ExercisesController < ApplicationController
	def create
		post_id = params[:exercise][:post_id]
		exercise_name = params[:exercise][:exercise_name]
		sets = params[:sets]
		reps = params[:reps]
		weight = params[:weight]
		exercise = Exercise.new(:post_id => post_id, :sets => sets, :reps => reps, :weight => weight, :exercise_name => exercise_name)


		if params[:date]
			@date = Date.parse(params[:date])
		else
			@date = Date.today
			params[:date] = @date
		end

		if not exercise.save
			redirect_to controller: 'posts', action: 'index', date: @date
		end
		redirect_to controller: 'posts', action: 'edit', date: @date
	end
end
