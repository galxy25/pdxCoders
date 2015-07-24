class CreatePlaylists < ActiveRecord::Migration
  def change

    ActiveSupport.on_load :active_record do
        Foreigner.load
    end

    create_table :playlists do |t|
        t.string :name
        t.integer :user_id
    end

    create_table :cards_playlists do |t|
        t.integer :order  # Int to determine ordering of cards
        t.integer :card_id
        t.integer :playlist_id
    end

    add_foreign_key :cards_playlists, :cards
    add_foreign_key :cards_playlists, :playlists

    create_join_table :playlists, :users
  end
end
