include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :image_card_content do
    title 'title'
    text 'content'
    image { fixture_file_upload(File.join(Rails.root,'app','assets','images','your_image_here.png'), 'image/png') }
    created_by 1
  end
end
