class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :content_type_id
      t.integer :content_id

      t.timestamps
    end
  end
end
