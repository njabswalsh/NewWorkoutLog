class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer	 :user_id
      t.date     :date
      t.text 	 :workout
      t.text 	 :notes

      t.timestamps
    end
  end
end
