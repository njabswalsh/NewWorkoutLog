module PostsHelper

	def get_post_exercises_mapping(post)
		exercises_hash = Hash.new
		post.exercises.each do |exercise|
			entries = exercises_hash[exercise.exercise_name]
			if entries
				entries.push(exercise)
			else
				entries = [exercise]
			end
			exercises_hash[exercise.exercise_name] = entries
		end
		return exercises_hash
	end

	def get_exercise_string_from_exercise_entries_array(exercise_name, exercise_entries_array)
		exercise_string = exercise_name + ": "
		sets_reps_weights_strings = Array.new
		exercise_entries_array.each do |exercise|
			sets_reps_weights_strings.push(get_exercise_sets_reps_weight_string(exercise))
		end
		exercise_string += sets_reps_weights_strings.join(", ")
		return exercise_string
	end

end
