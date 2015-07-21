class Playlist < ActiveRecord::Base
    validates :name, presence: true

    belongs_to :user
    has_many :cards, through: :cards_playlists
end
