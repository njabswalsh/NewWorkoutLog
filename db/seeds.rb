# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
exercise_type_list = [
	["Squats", ""],
	["Bench Press", ""],
	["Overhead Press", ""],
	["Deadlift", ""],
	["Front Squats", ""],
	["Single Leg Deadlifts", ""],
	["Bicep Curls", ""],
	["Barbell Rows", ""],
	["Power Clean", ""],
	["Jerk", ""],
	["Clean and Jerk", ""],
	["Tricep Pushdowns", ""],
	["Dumbell Rows", ""],
	["Pullups", ""],
	["Lat Pulldowns", ""],
	["Dumbell Flies", ""],
	["Chinups", ""],
	["Calf Raises", ""],
	["Shoulder Press", ""],
	["Lateral Raises", ""],
	["Bent-Over Dumbell Flies", ""]
]

exercise_type_list.each do |name, icon_address|
	ExerciseType.create(name: name, icon_address: icon_address)
end
