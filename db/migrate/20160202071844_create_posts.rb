class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer	 :user_id
      t.datetime :date #TODO: should be .datetime
      t.text 	 :workout
      t.text 	 :notes

      t.timestamps
    end
  end
end
