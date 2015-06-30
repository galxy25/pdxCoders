class ContentController < ApplicationController

  def index

  end

  def show
    redirect_to content_type_path, :id => content_params[:content_id]
  end

  def new

  end

  def create

  end

  private

  def content_params
    params.permit(:content_type_id, :content_id)
  end

  def content_type_path
    case content_params[:content_type_id]
      when '1'
        return 'text_content_path'
    end
  end
end