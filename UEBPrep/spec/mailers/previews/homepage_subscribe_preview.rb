# Preview all emails at http://localhost:3000/rails/mailers/homepage_subscribe
class HomepageSubscribePreview < ActionMailer::Preview
  def homepage_subscribe_preview
    HomepageSubscribe.subscribe_email("test@test")
  end
end
