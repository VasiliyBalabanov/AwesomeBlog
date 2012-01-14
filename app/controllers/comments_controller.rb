class CommentsController < ApplicationController
  def new
  end

  def create
    @post = Post.find(params[:post_id])
    @user
    @comment = @post.comments.create(params[:comment])
    @comment.user_id = session[:user_id]
    if !@comment.save
      flash[:notice] = "Sorry, your comments need the body."
    end
    respond_to do |format|
      format.html { redirect_to user_post_path(params[:user_id], params[:post_id]) }
      format.js
    end
    #redirect_to user_post_path(params[:user_id], params[:post_id])
  end
end
