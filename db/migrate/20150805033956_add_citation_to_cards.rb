class AddCitationToCards < ActiveRecord::Migration
  def change
    add_column :cards, :citation, :string
  end
end
