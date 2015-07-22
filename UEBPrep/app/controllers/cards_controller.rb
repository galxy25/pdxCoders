class CardsController < ApplicationController

  before_action :authenticate!
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate!, only: [:show]

  # GET /cards
  def index

    @cards = Card.order(:id).page params[:page]
    respond_to do |format|
      format.html
      format.json { render json: @cards }
    end

    # @cards = Card.order(:id).page params[:page]

  end

  # GET /cards/1
  def show
    unless session.blank?
      @current_user = current_user
    end

    @card = Card.find(params["id"].to_i)
    respond_to do |format|
      format.html
      format.json { render json: @card }
    end
  end

  # GET /cards/new
  def new
    @user = current_user
  end

  # GET /cards/1/edit
  def edit
    @card = Card.find(params[:id])
  end

  # POST /cards
  def create
    case card_params[:cardtype]
      when 'text'
        @content = TextContent.new(:text => card_params[:cardtext],
                                   :created_by => current_user.id)
      when 'rule'
        @content = TitledCardContent.new(:title => card_params[:cardtitle],
                                         :text => card_params[:cardtext],
                                         :created_by => current_user.id)
      when 'image'
        @content = ImageCardContent.new(:title => card_params[:cardtitle],
                                        :text => card_params[:cardtext],
                                        :image => card_params[:uploadcardimage],
                                        :created_by => current_user.id,
                                        :alt => card_params[:cardimagealt])
    end

    binding.pry
    @content.save
    @card = @content.card

    if @card
      respond_to do |format|
        format.html { redirect_to @card, notice: 'Card was successfully created' }
        format.json { render json: @card, status: 200 }
      end
    else
      respond_to do |format|
        format.html render :new
        format.json { render json: {errors: 'Unable to create your card',  status: 422} }
      end
    end
  end

  # PATCH/PUT /cards/1
  def update
    if @card.update(card_params)
      respond_to do |format|
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { render json: @card, status: 200 }
      end
    else
      respond_to do |format|
        format.html render :edit
        format.json { render json: {errors: 'Unable to update your card',  status: 422} }
      end
    end
  end

  # DELETE /cards/1
  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.'}
      format.json status: 204
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def card_params
      params.permit(:cardtype, :cardtitle, :cardtext, :uploadcardimage, :cardimagealt )
    end

    def update_params
      params.permit(:cardtype, :title , :text , :uploadcardimage, :alt )
    end
end
