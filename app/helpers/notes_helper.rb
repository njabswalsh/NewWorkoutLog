module NotesHelper
	def get_visibility_string(notes_visibility)
		if notes_visibility.include? -1
			return "Everyone"
		elsif notes_visibility.empty?
			return "Only Me"
		else
			ret = ""
			notes_visibility.each do |team_id| 
				team = Team.find(team_id)
				if not ret == ""
					ret += ", "
				end
				ret += team.name
			end
		end
		return ret
	end
end
