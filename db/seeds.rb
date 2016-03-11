# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ExerciseType.delete_all


top_exercise_type_list = [
	["Squats", ""],
	["Bench Press", ""],
	["Deadlift", ""],
	["Overhead Press", ""],
	["Pullups", ""]
]

top_exercise_type_list.each do |name, icon_address|
	ExerciseType.create(name: name, icon_address: icon_address)
end

exercise_type_list = [
	["Front Squats", ""],
	["Single Leg Deadlifts", ""],
	["Bicep Curls", ""],
	["Barbell Rows", ""],
	["Power Clean", ""],
	["Jerk", ""],
	["Clean and Jerk", ""],
	["Tricep Pushdowns", ""],
	["Dumbbell Rows", ""],
	["Lat Pulldowns", ""],
	["Dumbbell Flies", ""],
	["Chinups", ""],
	["Calf Raises", ""],
	["Shoulder Press", ""],
	["Lateral Raises", ""],
	["Bent-Over Dumbbell Flies", ""],
	["Dumbbell Bench", ""],
	["Dips", ""],
	["Hamstring Ball Curls", ""],
	["Assisted Dips", ""]
]
exercise_type_list = exercise_type_list.sort_by { |e| e[0] }
puts exercise_type_list.to_s
exercise_type_list.each do |name, icon_address|
	ExerciseType.create(name: name, icon_address: icon_address)
end
