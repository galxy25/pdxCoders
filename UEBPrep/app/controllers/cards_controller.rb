class CardsController < ApplicationController
  def new
    @user = current_user
    if @user.to_s == ''
      @user = "Not Logged In"
    end
    #@card = new card
  end
end
