class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
        t.string :name

    end

    create_table :cards_playlist do |t|
        t.int :playlist_id  # Foreign key to playlists
        t.int :card_id      # Foreign key to cards
        t.int :order        # Int to determine ordering of cards
    end

    create_table :playlists_user do |t|
        t.int :playlist_id  # Fkey to playlists
        t.int :user_id      # Fkey to users
    end
  end
end
