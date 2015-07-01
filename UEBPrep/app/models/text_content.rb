class TextContent < ActiveRecord::Base
  after_save   :create_card
  validates_uniqueness_of :text

  def to_partial_path
    'text_content'
  end

  private
    #TODO: remove magic number somehow.
    def create_card
      #TODO: figure out how to snag the current user's id.
      user_id = 1
      Card.create(content_type_id: 1, content_id: self.id, created_by: user_id)
    end
end
