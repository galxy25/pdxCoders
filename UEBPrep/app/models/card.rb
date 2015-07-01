class Card < ActiveRecord::Base
  validates :content_type_id, presence: true
  validates :content_id, presence: true

  attr_accessor :content

  after_initialize :get_content
  after_find       :get_content

  private
    # I hate everything about needing to do this ...
    # something not quite right with my schema
    def get_content
      case self.content_type_id
        when 1
          @content = TextContent.find(self.content_id)
        when 2
          @content = TitledCardContent.find(self.content_id)
      end
    end
end
