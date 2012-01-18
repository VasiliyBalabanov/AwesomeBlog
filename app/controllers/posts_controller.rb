class PostsController < ApplicationController
  before_filter :get
  before_filter :check_auth, :only => [:edit, :update]
  before_filter :check_admin_auth, :only => :destroy
  
  
def check_auth

  if @user && @user.id != @post.user_id
      flash[:notice] = "Sorry, you can't edit this post"
      redirect_to [@show_user, @post]
      
   end
end

  def check_admin_auth

    if @user.id != @post.user_id && !(@user.is_admin?)
      flash[:notice] = "Sorry, you can't edit this post"
      redirect_to [@show_user, @post]
      
   end
  end

  def get
    @user = User.find_by_auth_token(cookies[:auth_token])
    @show_user = User.find(params[:user_id])
    if params[:id]
      @post = Post.find(params[:id])
    end
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
