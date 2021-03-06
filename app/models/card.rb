class Card < ActiveRecord::Base
  validates :content_type_id, presence: true
  validates :content_id, presence: true
  # validates :created_by, presence: true
  # validates_uniqueness_of :content_id, :scope => :content_type_id
  
  belongs_to :user
  has_many :cards_playlists
  has_many :playlists, :through => :cards_playlists
  before_save :content_exists

  attr_accessor :content

  after_initialize :get_content
  after_find       :get_content
  before_destroy   :destroy_content

  def update(params)
    case content_type_id
      when 1
        content = TextContent.find(content_id)
        content.update(text: params[:text])
        content.save!
        self.reload
      when 2
        content = TitledCardContent.find(content_id)
        content.update(text: params[:text],
                       title: params[:title])
        content.save!
        self.reload
      when 3
        content = ImageCardContent.find(content_id)
        content.update(text: params[:text],
                       title: params[:title],
                       alt: params[:alt],
                       image: params[:uploadcardimage])
        content.save!
        self.reload
    end
  end

  private
    # I hate everything about needing to do this ...
    # something not quite right with my schema
    def get_content
      case self.content_type_id
        when 1
          @content = TextContent.find(self.content_id)
        when 2
          @content = TitledCardContent.find(self.content_id)
        when 3
          @content = ImageCardContent.find(self.content_id)
      end
    end

    def destroy_content
      content.destroy
    end

    def content_exists
      case self.content_type_id
        when 1
          if TextContent.find(self.content_id).nil?
            return false
          end
        when 2
          if TitledCardContent.find(self.content_id).nil?
            return false
          end
        when 3
          if ImageCardContent.find(self.content_id).nil?
            return false
          end
      end
    end
end
