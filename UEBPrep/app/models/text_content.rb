class TextContent < ActiveRecord::Base
  after_save   :create_card
  validates_uniqueness_of :text

  def to_partial_path
    'text_content'
  end

  private
    #TODO: remove magic number somehow.
    def create_card
      Card.create(content_type_id: 1, content_id: self.id)
    end
end
