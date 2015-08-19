class HomepageController < ApplicationController
  def index
  end

  def stats
    @online = User.online.count
    @active = User.active.count
    @monthly_uniques = User.monthly_uniques.count
  end

  def subscribe_email
    HomepageSubscribeEmailJob.set(wait: 10.seconds).perform_later(params[:email_address])

    respond_to do |format|
      format.html { redirect_to :root , notice: 'Your email has been sent' }
      format.json { redirect_to :root, status: :accepted }
    end
  end
end
