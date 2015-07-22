class AddCreatedByToCards < ActiveRecord::Migration
  def change
    add_column :cards, :created_by, :integer
  end
end
