class CreateImageCardContents < ActiveRecord::Migration
  def change
    create_table :image_card_contents do |t|
      t.string :title
      t.text :text
      t.attachment :image

      t.timestamps
    end
  end
end
