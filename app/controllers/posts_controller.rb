class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  before_filter :get_user
  before_filter :get_show_user, :only => [:index, :show, :edit, :destroy]
  before_filter :get_post, :only => [:edit, :update, :destroy]
  before_filter :check_auth, :only => [:edit, :update]
  before_filter :check_admin_auth, :only => :destroy
  
  
def check_auth
#  user_id_by_cookie
  if @user.id != @post.user_id
      flash[:notice] = "Sorry, you can't edit this post"
      redirect_to [@user, @post]
      
   end
end

  def check_admin_auth
   # user_id_by_cookie
    if @user.id != @post.user_id && @user.id > 1
      flash[:notice] = "Sorry, you can't edit this post"
      redirect_to [@user, @post]
      
   end
  end

  def get_user
    @user = User.find_by_auth_token(cookies[:auth_token])
  end

  def get_post
    @post = Post.find(params[:id])
  end
  
  def get_show_user
    @show_user = User.find(params[:user_id])
  end

  def index
    @posts = @show_user.posts.recent.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  
  def show
    @show_user = User.find(params[:user_id])
    @post = @show_user.posts.find(params[:id])
    @comments = @post.comments.all
    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      
    end
  end


  def edit
  
    @post = @show_user.posts.find(params[:id])
  end

 
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


  def destroy
   
    @post = @show_user.posts.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to user_posts_url }
    end
  end
end
