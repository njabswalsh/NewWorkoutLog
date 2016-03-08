module ExercisesHelper
	def get_exercise_str(exercise)
		str = exercise.exercise_name + ": " + exercise.sets.to_s + " x " + exercise.reps.to_s
		if exercise.weight
			str += " x " + exercise.weight.to_s
		end
		return str
	end
end
