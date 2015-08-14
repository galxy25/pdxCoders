class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy, :cards, :remove_card_playlist]


  # GET /playlists
  def index
    @playlists = Playlist.all
  end

  # GET /playlists/1
  def show
    if (@playlist.user_id == current_user.id)
      if params[:play_params] && play_params[:display_card_id]
        @current_index = @playlist.cards.find_index { |card|  card.id == play_params["display_card_id"].to_i }

        case play_params[:direction]
          when "Back" 
              @current_index = previous_card_index(@current_index, @playlist.cards.count)
          when "Forward"
              @current_index = next_card_index(@current_index, @playlist.cards.count)
        end
        @current_card = @playlist.cards[@current_index]
  
        respond_to do |format|
          format.html 
          format.json { render json: {:playlist => @playlist, :current_card => @current_card} }
        end
      else
        @current_card = @playlist.cards.first
        @current_index = 0
        respond_to do |format|
          format.html 
          format.json { render json: {:playlist => @playlist, :current_card => @current_card} }
        end
      end
    else
      respond_to do |format|
        flash[:alert] = 'You are not authorized to view that playlist.'
        format.html { redirect_to user_path(current_user) }
        format.json { render json: {status: 403} }
      end
    end
  end

  # GET /playlists/1/cards
  def cards
    respond_to do |format|
      format.html
      format.json { render json: { :card => Rabl::Renderer.json(@playlist.cards, 'playlists/card_with_order') , status: 200} }
    end
  end

  # GET /playlists/new
  def new
    @playlist = Playlist.new(new_params)
    @playlist.user = current_user

    if @playlist.save!
      respond_to do |format|
        format.html { redirect_to profile_path }
        format.json {render json: {status: 204, :playlist => @playlist} }
      end
    else
      render json: {errors: 'Unable to create a playlist'}
    end
  end

  # GET /playlists/1/edit
  def edit
    @playlists = Playlist.all

  end

  def remove_card_playlist
    evicted_card = Card.find(remove_params[:to_remove].to_i)
    @playlist.remove_card(evicted_card)
    @playlist.save!
    @playlist.reload
    respond_to do |format|
      format.html { redirect_to playlist_path(@playlist) }
      format.json {render json: {status: 204} }
    end
  end
  # POST /playlists
  def create
    @playlist = Playlist.new(playlist_params)

    if @playlist.save
      redirect_to @playlist, notice: 'Playlist was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /playlists/1
  def update
    if @playlist.update(:name => params[:name])
      params[:cards].each do |entry|
        card_order = JSON.parse(entry)
        card_playlist_entry = CardsPlaylist.find_by(:playlist_id => @playlist.id, :card_id => card_order['id'])
        card_playlist_entry.update(:order => card_order['order'])
      end
      render :nothing => true
    else
      render :edit
    end
  end

  # DELETE /playlists/1
  def destroy
    @playlist.destroy
    redirect_to playlists_url, notice: 'Playlist was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlists = Playlist.where(id: params[:id].to_i)

      if @playlists.empty? 
        respond_to do |format|
          format.html { redirect_to user_path(current_user) }
          format.json {render json: {status: 404, :error => 'Unable to find a playlist with id: #{params[:id]}'} }
        end
      else
        @playlist = @playlists.first
      end

    end

    # Only allow a trusted parameter "white list" through.
    def playlist_params
      params[:playlist]
    end

    def play_params
      params.require(:play_params).permit(:display_card_id, :direction)
    end

    def new_params
      params.permit(:name)
    end

    def remove_params
      params.permit(:to_remove, :id)
    end

    def next_card_index(index, playlist_count)
      if index == playlist_count - 1
        index = 0
      else
        index = index + 1
      end
    end

    def previous_card_index(index, playlist_count)
      if index == 0 
        index = playlist_count - 1
      else
        index = index - 1 
      end
    end
end
