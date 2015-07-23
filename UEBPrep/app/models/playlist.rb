class Playlist < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :user
  has_and_belongs_to_many :cards

  def add(card)
    cards.push(card)
    save
  end

  def remove(card)
    cards.delete(card)
    save
  end
end
