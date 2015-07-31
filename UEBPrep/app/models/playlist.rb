class Playlist < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :user
  has_many :cards_playlists
  has_many :cards, :through => :cards_playlists

  def add_card(card)
    cards.push(card)
    save
  end

  def remove_card(card)
    cards.delete(card)
    save
  end
end
