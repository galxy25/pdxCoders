class CreateTextContents < ActiveRecord::Migration
  def change
    create_table :text_contents do |t|
      t.string :text

      t.timestamps
    end
  end
end
