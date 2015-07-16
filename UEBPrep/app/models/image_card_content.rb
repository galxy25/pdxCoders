class ImageCardContent < ActiveRecord::Base
  after_save :create_card
  validates :text, presence: true
  validates_uniqueness_of :scope => :text

  attr_accessor :created_by
  attr_reader :card

  def to_partial_path
    'image_card_content'
  end

  private
  #TODO: remove magic number somehow.
  def create_card
    @card = Card.new(content_type_id: 3, content_id: self.id, created_by: self.created_by)
    if !@card.save
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end
end
