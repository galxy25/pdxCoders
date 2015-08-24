class CreateTitledCardContents < ActiveRecord::Migration
  def change
    create_table :titled_card_contents do |t|
      t.string :title
      t.string :text

      t.timestamps
    end
  end
end
