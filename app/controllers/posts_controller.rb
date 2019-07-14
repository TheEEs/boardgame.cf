class PostsController < ApplicationController
  load_and_authorize_resource #except: [:like]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_menu
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_pagy, only:[:index, :create]

  #post /posts/1/like
  def like 
    authorize! :like, @post
    @post = Post.find(params[:id])
    current_user.toggle_like!(@post)
    respond_to do |format| 
      format.js {
        render "like"
      }
    end
  end

  # GET /posts
  # GET /posts.json
  def index
    @feeling = true
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if (@post.user = current_user) && @post.save
        format.html { 
          if @post.parent_id == 0
            redirect_to posts_path, notice: 'Post was successfully created.' 
          else
            redirect_to post_path(@post.parent_id), notice: 'Comment was successfully created.' 
          end
        }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :index }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if (@post.user = current_user) &&  @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { 
        if @post.parent_id != 0 then
          redirect_to post_path(@post.parent_id), notice: 'Comment was successfully deleted.'
        else 
          redirect_to posts_path, notice: "Post was successfully deleted"
        end
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :parent_id, :image, :sharable_type, :sharable_id)
    end

    def set_menu
      @home_path = true
    end

    def set_pagy 
      if user_signed_in? 
        who_im_following = current_user.followees(User).map{|user| user.id }.join(',')
        query_builder = %Q= 
          CASE 
            WHEN "posts"."user_id" IN (#{who_im_following}) THEN 1
            ELSE 0
          END DESC
        =
        #@pagy, @posts = pagy(Post.where(user: who_im_following).or(Post.where(user: current_user)).order(:updated_at => :desc), items: 10,size: [1,2,1,1])
        @pagy, @posts = pagy(Post.where(parent_id: 0).order(query_builder).order(:updated_at => :desc), items: 10,size: [1,2,1,1])
      else 
        @pagy, @posts = pagy(Post.where(:parent_id => 0).order(:updated_at => :desc), items: 10,size: [1,2,1,1])
      end
      @post = Post.new
    end
end
