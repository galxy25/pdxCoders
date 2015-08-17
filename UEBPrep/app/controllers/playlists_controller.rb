class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy, :add_card]

  # GET /playlists
  def index
    @playlists = Playlist.all
  end

  # GET /playlists/1
  def show
  end

  # GET /playlists/new
  def new
    @playlist = Playlist.new
  end

  # GET /playlists/1/edit
  def edit
  end

  # POST /playlists
  def create
    #binding.pry
    @playlist = Playlist.new(playlist_params)
    @playlist.user_id = current_user.id
    if @playlist.save
      if params[:ajax]
        render nothing: true
      else
        redirect_to @playlist, notice: 'Playlist was successfully created.'
      end
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

  # POST?? /playlists/1/add_card/1
  def add_card
    @playlist.add_card(Card.find(params[:card_id]))
    render :nothing => true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def playlist_params
      params.require(:playlist).permit(:name, :ajax)
    end
end
