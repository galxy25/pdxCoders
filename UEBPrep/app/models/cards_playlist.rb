class CardsPlaylist < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :card
end