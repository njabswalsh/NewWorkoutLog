class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
		t.integer :post_id
		t.text :text

		t.timestamps
    end
  end
end
