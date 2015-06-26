class Card < ActiveRecord::Base
  validates :content_type_id, presence: true
  validates :content_id, presence: true
end
