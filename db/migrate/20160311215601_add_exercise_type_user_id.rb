class AddExerciseTypeUserId < ActiveRecord::Migration
  def change
  	add_column :exercise_types, :user_id, :integer
  end
end
