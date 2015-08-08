class Playlist < ActiveRecord::Base
  validates :name, presence: true
  validate :user_id, presence: true

  belongs_to :user
  has_many :cards_playlists
  has_many :cards, :through => :cards_playlists

  def add_card(card)
    cards.push(card)
    save
    entry = CardsPlaylist.find_by_card_id(card.id)
    entry.order = cards.length
    entry.save
  end

  def remove_card(card)
    cards.delete(card)
    save
  end
end
