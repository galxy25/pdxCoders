class TitledCardContent < ActiveRecord::Base
  after_save :create_card

  def to_partial_path
    'titled_card_content'
  end
  
  private
    #TODO: remove magic number somehow.
    def create_card
      Card.create(content_type_id: 2, content_id: self.id)
    end
end
