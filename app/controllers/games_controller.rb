class GamesController < ApplicationController
  load_and_authorize_resource
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except:[:show,:index]
  before_action :set_menu
  before_action :set_pagy, :only => [:show, :edit, :update]
  # GET /games
  # GET /games.json
  def index
    @selected_tags = Tag.find(tags_params) rescue nil
    @tags = Tag.all.shuffle
    near_users = []
    @games = Game.all
    if filter_near_me && user_signed_in? 
      near_users_records = User.near([current_user.latitude, current_user.longitude], 20)
      begin 
        near_users += near_users_records.map{|user| [user.id, user.distance]}
      end if near_users_records.any?
    end

    unless filter_city_name.blank?
      near_users_records = User.near(filter_city_name, 20) rescue []
      begin 
        near_users += near_users_records.map{|user| [user.id, user.distance]}
      end if near_users_records.any?
    end
    #byebug
    #near_users = near_users.uniq{|user| user.first }
    if near_users.any?
      when_clauses = near_users.map do |user| 
        #byebug
        "WHEN #{user.first} THEN #{user.last}" 
      end
      if near_users.any?
        final_order_query = %Q=
          (CASE "games"."user_id"
            #{when_clauses.join(' ')}
          END)
        =
        final_order_query= final_order_query.strip
      else
        final_order_query = ""
      end

      @games = @games.where(user_id: near_users.map(&:first)).order(final_order_query)
    end

    if @selected_tags&.any?
      @games =  @games.joins(:tags).where(tags: {id: @selected_tags}).distinct#.shuffle
    end
    unless filter_game_name.blank? 
      @games = @games.where('LOWER("games"."name") LIKE ?', "%#{Game.sanitize_sql_like(filter_game_name.downcase.strip)}%")
    end
    if ["1","2"].include? sort_by_name
      case sort_by_name
      when "1"
        @games = @games.order(name: :asc)
      else 
        @games = @games.order(name: :desc)
      end
    end
    if ["1","2"].include? sort_by_created_at
      case sort_by_created_at
      when "1"
        @games = @games.order(created_at: :desc)
      else 
        @games = @games.order(created_at: :asc)
      end
    end
    if ["1","2"].include? sort_by_hardness
      case sort_by_hardness
      when "1"
        @games = @games.order(hardness: :asc)
      else 
        @games = @games.order(hardness: :desc)
      end
    end
    if ["1","2"].include? sort_by_price
      case sort_by_price
      when "1"
        @games = @games.order(price: :asc)
      else 
        @games = @games.order(price: :desc)
      end
    end
    @pagy, @games = pagy(@games.order(:created_at => :desc), items:8)
  end

  # GET /games/1
  # GET /games/1.json
  def show
   
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if (@game.user = current_user) && @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    def set_menu 
      @games_path = true
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:name, :price,:description, :playtime, :numbers_of_player, :hardness,:image, tag_ids: [])
    end

    def set_pagy
      @pagy, @articles = pagy(@game.articles.order(:updated_at => :desc), items: 4,size: [1,2,1,1])
    end

    def tags_params 
      params[:filters]&.[](:tag_ids)&.\
        select{|tag_id| !["",nil].include?(tag_id)}
    end

    def sort_by_name
      params[:filters]&.[](:sort_by_name)
    end

    def sort_by_created_at
      params[:filters]&.[](:sort_by_created_at)
    end

    def sort_by_hardness 
      params[:filters]&.[](:sort_by_hardness)
    end

    def sort_by_price
      params[:filters]&.[](:sort_by_price)
    end

    def filter_game_name
      params[:filters]&.[](:name)
    end

    def filter_near_me 
      params[:filters]&.[](:near_me) == "1"
    end

    def filter_city_name
      params[:filters]&.[](:in_city)
    end
end
