class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  before_filter :get_user
  before_filter :get_post, :only => [:edit, :update, :destroy]
  before_filter :check_auth, :only => [:edit, :update, :destroy]
  def check_auth
    if session[:user_id] != @post.user_id
      flash[:notice] = "Sorry, you can't edit this post"
      redirect_to user_posts_path(params[:user_id])
      
   end
  end
  def get_user
    @user = User.find(params[:user_id])
  end
  def get_post
    @post = Post.find(params[:id])
  end
 def index
    @posts = @user.posts.recent.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = @user.posts.find(params[:id])
    @comments = @post.comments.all
    respond_to do |format|
      format.html # show.html.erb
      
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      
    end
  end

  # GET /posts/1/edit
  def edit
    @post = @user.posts.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = @user.posts.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to [@user, @post], notice: 'Post was successfully created.' }
       
      else
        format.html { render action: "new" }
       
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = @user.posts.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to [@user, @post], notice: 'Post was successfully updated.' }
       
      else
        format.html { render action: "edit" }
       
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = @user.posts.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to user_posts_url }
    end
  end
end
