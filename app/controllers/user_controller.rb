class UserController < ApplicationController
  before_action :authenticate_user! #, except: [:index]
  #load_and_authorize_resource
  before_action :set_user
  def index
    authorize! :read, @user
    @pagy , @games = pagy(@user.games, items: 10)
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

  private 
    def set_user 
      @user = User.find(params[:id])
    end
end
