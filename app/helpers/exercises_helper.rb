module ExercisesHelper
	def get_exercise_str(exercise)
		str = exercise.exercise_name + ": "
		if exercise.sets
			str += exercise.sets.to_s
			if exercise.reps
				str += " x "
			end
		end
		if exercise.reps
			str += exercise.reps.to_s
		end
		if exercise.weight
			str += " x " + exercise.weight.to_s
		end
		return str
	end
end
