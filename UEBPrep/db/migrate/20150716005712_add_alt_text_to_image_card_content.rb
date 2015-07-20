class AddAltTextToImageCardContent < ActiveRecord::Migration
  def change
    add_column :image_card_contents, :alt, :text
  end
end
