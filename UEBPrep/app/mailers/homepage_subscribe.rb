class HomepageSubscribe < ActionMailer::Base
  default from: "info.uebprep@gmail.com"

  def subscribe_email(email_address)
    @email_address=email_address
    mail(to: email_address, subject: "Thanks for subscribing to UEB updates")
  end
end
