class Api::CardsController < Api::ApiController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :authenticate
  before_action :get_card, only: [:edit]
  respond_to :json

  def index
    @cards = Card.all
    render json: { :cards => Rabl::Renderer.json(@cards, 'api/cards/index') , status: 200 , :count => @cards.count}
  end

  def show
    @card = Card.where(id: card_params[:id])
    if @card.count > 0
      render json: { :card => Rabl::Renderer.json(@card.first, 'api/cards/show') , status: 200}
    else
      render json: { status: 404, :errors => 'No card with this id was found'}
    end
  end

  def edit
    if @card !=[]
      if  @card.is_a?(TextContent)
        @card.update(text: update_params[:text])
      else
        @card.update(text: update_params[:text], title: update_params[:title])
      end
      if @card.save!
        @card.reload
        if  @card.is_a?(TextContent)
          render json: { :card => Rabl::Renderer.json(@card,'api/cards/text_content') , status: 204}
        else
          render json: { :card => Rabl::Renderer.json(@card,'api/cards/titled_card_content') , status: 204}
        end
      else
        render json: {status: 300, :errors => "Unable to update with the data provided"}
      end

    else
      render json: {status: 404}
    end
  end

  def create

  end

  private

  def get_card
    @card = Card.where(id: params["id"])
    if @card.count > 0
      @card = @card.first
      case @card.content_id
        when 1
         @card = TextContent.find(@card.content_id)
        when 2
          @card= TitledCardContent.find(@card.content_id)
      end
    end
    return @card
  end
  def card_params
    params.permit(:content_type_id, :content_id, :created_by, :id)
  end

  def create_params
    params.require(:card).permit(:content_type_id, :content_id)
  end

  def update_params
    params.require(:content).permit(:title, :text)
  end
end



