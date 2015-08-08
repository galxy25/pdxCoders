object @card
attributes :id ,
            :content_type_id,
            :content_id,
            :created_at,
            :updated_at,
            :created_by

node :order do |card|
  CardsPlaylist.find_by(:card_id => card.id).order
end

node :content do |card|
  case card.content_type_id
  when 1
    partial('api/cards/text_content', :object => TextContent.find(card.content_id))
  when 2
    partial('api/cards/titled_card_content', :object => TitledCardContent.find(card.content_id))
  end
end