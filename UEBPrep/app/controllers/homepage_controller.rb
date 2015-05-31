class HomepageController < ApplicationController
  def index
  end

  def subscribe_email
    # SendEmailJob.set(wait: 10.seconds).perform_later(params[:email_address])
    HomepageSubscribe.subscribe_email(params[:email_address]).deliver

    respond_to do |format|
      format.html { redirect_to :root , notice: 'Your email has been sent' }
      format.json { redirect_to :root, status: :accepted }
    end
  end
end
