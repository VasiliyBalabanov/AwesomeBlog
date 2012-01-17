class CommentsController < ApplicationController
  def new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    @comment.user_id = User.find_by_auth_token(cookies[:auth_token]).id
    if !@comment.save
      flash[:notice] = "Sorry, your comments need the body."
    else
      @count = @post.comments.count
    end
    respond_to do |format|
      format.html {redirect_to user_post_path(params[:user_id], params[:post_id])}
      format.js
    end
  end
end
