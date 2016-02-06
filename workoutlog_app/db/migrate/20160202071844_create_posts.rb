class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :date
      t.text :workout
      t.text :notes

      t.timestamps
    end
  end
end
