class CreateExerciseTypes < ActiveRecord::Migration
  def change
    create_table :exercise_types do |t|
      t.text :name
      t.text :icon_address

      t.timestamps
    end
  end
end
