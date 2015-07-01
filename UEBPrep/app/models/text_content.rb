class TextContent < ActiveRecord::Base
  def to_partial_path
    'text_content'
  end
end
