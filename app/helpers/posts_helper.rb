module PostsHelper

	def get_post_exercises_mapping(post)
		exercises_hash = Hash.new
		post.exercises.sort { |a,b| a.id <=> b.id }.each do |exercise|
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
		exercise_string = ""
		sets_reps_weights_strings = Array.new
		exercise_entries_array.each do |exercise|
			sets_reps_weights_strings.push(get_exercise_sets_reps_weight_string(exercise))
		end
		exercise_string += sets_reps_weights_strings.join(", ")
		if not exercise_string == ""
			exercise_string = ": " + exercise_string
		end
		exercise_string = exercise_name + exercise_string
		return exercise_string
	end

	def get_post_html_for_wolt(post)
		post_html = ""
		# Excercises
		exercises_mapping = get_post_exercises_mapping(post)
		exercises_mapping.each do |exercise_name, exercise_entries_array|
			if post_html != ""
				post_html += "<br>"
			end
			post_html += get_exercise_string_from_exercise_entries_array(exercise_name, exercise_entries_array)
		end
		# Notes
		post.notes.sort { |a,b| a.id <=> b.id }.each do |note|
			if post_html != ""
				post_html += "<br>"
			end
			post_html += note.text
		end
		return post_html
	end
end
