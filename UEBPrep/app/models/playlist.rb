class Playlist < ActiveRecord::Base
  validates :name, presence: true
  validate :user_id, presence: true

  belongs_to :user
  has_and_belongs_to_many :cards

  def add_card(card)
    cards.push(card)
    save
  end

  def remove_card(card)
    cards.delete(card)
    save
  end
end
