class ImageCardContent < ActiveRecord::Base
  has_attached_file :image, styles: {small: "64x64", med: "100x100", large: "200x200"}
  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png)
  after_save :create_card
  validates :text, presence: true

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
