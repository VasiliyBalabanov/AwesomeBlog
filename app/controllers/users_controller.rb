class UsersController < ApplicationController
 def new
  @user = User.new
end

def index
   @users = User.all

    respond_to do |format|
      format.html # index.html.erb
    end
end

def create
  @user = User.new(params[:user])
  if @user.save
    @user.posts.create(title: "Welcome", body: "Start writing right now!")
    redirect_to user_posts_url(@user), :notice => "Signed up!"
  else
    render "new"
  end
end
end
