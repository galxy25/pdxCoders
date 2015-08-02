class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  # GET /playlists
  def index
    @playlists = Playlist.all
  end

  # GET /playlists/1
  def show  
    if (@playlist.user_id == current_user.id)
      if play_params[:display_card_id]
        # Implement this path 
      else
        @current_card = @playlist.cards.first
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

  # GET /playlists/new
  def new
    @playlist = Playlist.new(new_params)
    @playlist.user = current_user

    if @playlist.save!
      respond_to do |format|
        format.html { redirect_to user_path(current_user) }
        format.json {render json: {status: 204, :playlist => @playlist} }
      end
    else
      render json: {errors: 'Unable to create a playlist'}
    end
  end

  # GET /playlists/1/edit
  def edit
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
    if @playlist.update(playlist_params)
      redirect_to @playlist, notice: 'Playlist was successfully updated.'
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
      @playlists = Playlist.where(id: params[:id])

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
      params.permit(:display_card_id)
    end

    def new_params
      params.permit(:name)
    end
end
