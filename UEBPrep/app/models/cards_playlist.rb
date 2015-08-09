class CardsPlaylist < ActiveRecord::Base
  validates_uniqueness_of :card_id, :scope => :playlist_id
  belongs_to :playlist
  belongs_to :card
end