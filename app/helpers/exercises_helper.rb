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

	def is_exercise_type_favorite(et)
		user = User.find(session[:user_id])
		if user
			favorites_list = user.favorites
			if favorites_list
				favorites_list = favorites_list.split(",")
				if favorites_list.include? et.name
					return true
				else
					return false
				end
			end
		else
			return false
		end
		return false
	end

	def get_icon_address(et)
		if (not et.icon_address) or (et.icon_address == "")
			return "http://i.imgur.com/rtGyo8H.png"
		else
			return et.icon_address
		end
	end
end
