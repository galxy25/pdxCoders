class Api::CardsController < Api::ApiController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :authenticate

  respond_to :json

  def index
    @cards = Card.all
    render json: { :cards => Rabl::Renderer.json(@cards, 'api/cards/index') , status: 200 , :count => @cards.count}
  end

  def show
    @card = Card.where(id: card_params[:id])
    if @card.count > 0
      render json: { :card => Rabl::Renderer.json(@card.first, 'api/cards/show') , status: 200, :count => @card.count}
    else
      render json: { status: 404, :errors => 'No card with this id was found'}
    end
  end

  def edit

  end

  def create

  end

  private

  def card_params
    params.permit(:content_type_id, :content_id, :created_by, :id)
  end

  def create_params
    params.require(:card).permit(:content_type_id, :content_id)
  end
end



