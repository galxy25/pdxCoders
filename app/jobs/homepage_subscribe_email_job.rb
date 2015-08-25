class HomepageSubscribeEmailJob < ActiveJob::Base
  queue_as :default

  def perform(email_address)
    HomepageSubscribe.subscribe_email(email_address).deliver
  end
end
