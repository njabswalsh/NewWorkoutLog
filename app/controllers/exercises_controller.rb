class ExercisesController < ApplicationController
	def create
		post_id = params[:exercise][:post_id]
		exercise_name = params[:exercise][:exercise_name]
		sets = params[:sets]
		reps = params[:reps]
		weight = params[:weight]
		return_to = params[:exercise][:return_to]
		exercise = Exercise.new(:post_id => post_id, :sets => sets, :reps => reps, :weight => weight, :exercise_name => exercise_name)

		if not exercise.save
			redirect_to controller: 'posts', action: 'index'
		end

		@post = Post.find(post_id)
		if not return_to == ""
			redirect_to controller: 'posts', action: 'edit', :date => @post.date.to_s, :return_to => return_to
		else
			redirect_to controller: 'posts', action: 'edit', :date => @post.date.to_s
		end
	end

	def update
		post_id = params[:exercise][:post_id]
		exercise_name = params[:exercise][:exercise_name]
		sets = params[:sets]
		reps = params[:reps]
		weight = params[:weight]
		return_to = params[:exercise][:return_to]
		
		exercise = Exercise.find(params[:exercise_id])
		exercise.sets = sets
		exercise.reps = reps
		exercise.weight = weight
		exercise.exercise_name = exercise_name

		if not exercise.save
			redirect_to controller: 'posts', action: 'index'
		end

		@post = Post.find(post_id)
		if not return_to == ""
			redirect_to controller: 'posts', action: 'edit', :date => @post.date.to_s, :return_to => return_to
		else
			redirect_to controller: 'posts', action: 'edit', :date => @post.date.to_s
		end
	end

	def destroy
		@exercise = Exercise.find_by(id: params[:id])
		date = params[:date]
		return_to = params[:return_to]
		@exercise.destroy
		if not return_to == ""
			redirect_to controller: 'posts', action: 'edit', :date => date.to_s, :return_to => return_to
		else
			redirect_to controller: 'posts', action: 'edit', :date => date.to_s
		end
	end

end
