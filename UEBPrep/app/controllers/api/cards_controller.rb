class Api::CardsController < Api::ApiController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :authenticate
  # skip_before_action :authenticate, only: [:create]

  respond_to :json

  def index
    @cards = Card.all
    render json: { :cards => Rabl::Renderer.json(@cards, 'api/cards/index') , status: 200 , :count => @cards.count}
  end

  def show

  end

  def edit

  end

  def create

  end

  private

  def card_params
    params.permit(:content_type_id, :content_id, :created_by)
  end

  def create_params
    params.require(:card).permit(:content_type_id, :content_id)
  end
end



