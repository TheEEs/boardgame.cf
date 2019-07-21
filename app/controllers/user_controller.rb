class UserController < ApplicationController
  before_action :authenticate_user! , except: [:geosearch, :index]
  #load_and_authorize_resource
  before_action :set_user, except:[:geolocation,:geosearch]
  before_action :set_tags , only:[:index]
  def index
    authorize! :read, @user
    @games = @user.games
    @selected_tags = Tag.find(tags_params) rescue nil
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
    @pagy , @games = pagy(@games.order(:created_at => :desc), items: 10)
  end


  #GET user/geosearch
  def geosearch
    @result = Geocoder.search([latitude, longitude]).first
    respond_to do |format|
      format.json{
        render "geo_location"
      }
    end
  end

  #POST user/:id/follow
  def follow
    authorize! :follow, @user
    current_user.toggle_follow!(@user) if @user.id != current_user.id
    respond_to do |format|
      format.js {
        render "follow"
      }
    end
  end

  #POST user/geolocation 
  def geolocation
    if user_signed_in?
      current_user.update({
        longitude: longitude ,
        latitude: latitude
      })
      render :plain => current_user.address
    else 
      render :status => 500
    end
  end


  private 
    def set_user 
      @user = User.find(params[:id]) rescue User.find_by_name!(params[:id])
    end

    def set_tags 
      @tags = Tag.all 
    end

    def longitude 
      params[:longitude].to_f
    end
    def latitude
      params[:latitude].to_f
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


end
