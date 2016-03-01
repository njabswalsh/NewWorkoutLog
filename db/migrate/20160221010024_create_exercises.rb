class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
    	t.integer :post_id
    	t.text		:exercise_name
    	t.integer :sets
    	t.integer :reps
    	t.integer :weight

      t.timestamps
    end
  end
end
