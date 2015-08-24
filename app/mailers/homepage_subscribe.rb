class HomepageSubscribe < ActionMailer::Base
  default from: "info.uebprep@gmail.com"

  def subscribe_email(email_address)
    @email_address=email_address
    # mg_client = Mailgun::Client.new ENV['mailgun_api_key']
    # message_params = {:from    => ENV['gmail_username'],
    #                   :to      => @email_address,
    #                   :subject => 'Thanks for subscribing for updates',
    #                   :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    # mg_client.send_message ENV['mailgun_domain'], message_params
    mail to: @email_address, subject: "Thanks for subscribing for updates"
  end
end
