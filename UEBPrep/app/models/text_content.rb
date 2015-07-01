class TextContent < ActiveRecord::Base
  after_save   :create_card

  def to_partial_path
    'text_content'
  end

  private
    def create_card
      Card.create(content_type_id: 1, content_id: self.id)
    end
end
