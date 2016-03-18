# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ExerciseType.where(:user_id => nil).destroy_all


top_exercise_type_list = [
	["Squats", "http://i.imgur.com/sIr0Fv3.png"],
	["Bench Press", "http://i.imgur.com/9DT8rk1.png"],
	["Deadlift", "http://i.imgur.com/SHGDQWT.png"],
	["Overhead Press", "http://i.imgur.com/hYindY2.png"],
	["Pullups", "http://i.imgur.com/HQsJVOE.png"]
]

top_exercise_type_list.each do |name, icon_address|
	ExerciseType.create(name: name, icon_address: icon_address)
end

exercise_type_list = [
	["Front Squats", "http://i.imgur.com/ajezY1g.png"],
	["Single Leg Deadlifts", "http://i.imgur.com/c5NPvZY.png"],
	["Bicep Curls", "http://i.imgur.com/FjtH79d.png"],
	["Barbell Rows", "http://i.imgur.com/o2q5UJr.png"],
	["Power Cleans", "http://i.imgur.com/WMvADss.png"],
	["Jerk", "http://i.imgur.com/v4IAOb8.png"],
	["Clean and Jerk", "http://i.imgur.com/aVe2OpC.png"],
	["Tricep Pushdowns", "http://i.imgur.com/UcVt6KF.png"],
	["Dumbbell Rows", "http://i.imgur.com/hY002ZX.png"],
	["Lat Pulldowns", "http://i.imgur.com/7j5vkTD.png"],
	["Dumbbell Flies", "http://i.imgur.com/OsEjkpW.png"],
	["Chinups", "http://i.imgur.com/O0m3hcM.png"],
	["Calf Raises", "http://i.imgur.com/Cog3PXz.png"],
	["Shoulder Press", "http://i.imgur.com/iYHd8hF.png"],
	["Lateral Raises", "http://i.imgur.com/dU3x245.png"],
	["Bent-Over Dumbbell Flies", "http://i.imgur.com/A46lgZ4.png"],
	["Dumbbell Bench", "http://i.imgur.com/ktZQmfV.png"],
	["Dips", "http://i.imgur.com/ErHByNH.png"],
	["Hamstring Ball Curls", "http://i.imgur.com/ak1MWXd.png"],
	["Assisted Dips", "http://i.imgur.com/p545BJM.png"],
	["Dumbbell Front Raise", "http://i.imgur.com/IemB1ug.png"],

	["Assisted Pullups", ""],
	["Kettlebell Swings", ""],
	["Internal Shoulder Rotation", ""],
	["External Shoulder Rotation", ""],
	["Russian Twists", ""],
	["Split Squats", ""]
]
exercise_type_list = exercise_type_list.sort_by { |e| e[0] }
exercise_type_list.each do |name, icon_address|
	ExerciseType.create(name: name, icon_address: icon_address)
end

puts "Filled ExerciseType Table."
