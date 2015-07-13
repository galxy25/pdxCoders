class CardsController < ApplicationController

  before_action :authenticate!
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  # GET /cards
  def index
    @cards = Card.all
  end

  # GET /cards/1
  def show

  end

  # GET /cards/new
  def new
    @user = current_user
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards
  def create
    #binding.pry
    case card_params[:cardtype]
      when 'text'
        @content = TextContent.new(:text => card_params[:cardtext], :created_by => current_user.id)
      when 'rule'
        @content = TitledCardContent.new(:title => card_params[:cardtitle], :text => card_params[:cardtext], :created_by => current_user.id)
    end
    @content.save
    @card = @content.card

    if @card
      redirect_to @card, notice: 'Card was successfully updated.'
    else
      render :new
    end
  end

  # PATCH/PUT /cards/1
  def update
    if @card.update(card_params)
      redirect_to @card, notice: 'Card was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /cards/1
  def destroy
    @card.destroy
    redirect_to cards_url, notice: 'Card was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def card_params
      params.permit(:cardtype, :cardtitle, :cardtext)
    end

end
