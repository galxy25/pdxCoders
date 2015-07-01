class TitledCardContent < ActiveRecord::Base
  after_save :create_card
  validates_uniqueness_of :title, :scope => :text

  def to_partial_path
    'titled_card_content'
  end
  
  private
    #TODO: remove magic number somehow.
    def create_card
      #TODO: figure out a way to snag current user's id
      user_id = 1
      Card.create(content_type_id: 2, content_id: self.id, created_by: user_id)
    end
end
