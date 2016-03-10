module ExercisesHelper
	def get_exercise_str(exercise)
		str = exercise.exercise_name + ": "
		str += get_exercise_sets_reps_weight_string(exercise)
		return str
	end

	def get_exercise_sets_reps_weight_string(exercise)
		str = ""
		if exercise.sets
			str += exercise.sets.to_s
			if exercise.reps
				str += "x"
			end
		end
		if exercise.reps
			str += exercise.reps.to_s
		end
		if exercise.weight
			str += "x" + exercise.weight.to_s
		end
		return str
	end
end
