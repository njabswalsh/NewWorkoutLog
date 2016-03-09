class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
		t.integer :post_id
		t.text :text
		t.text :visibility #comma separated team ids; ie team_id_1,team_id_2,team_id_3

		t.timestamps
    end
  end
end
