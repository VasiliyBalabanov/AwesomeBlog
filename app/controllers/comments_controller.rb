class CommentsController < ApplicationController
  def new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    @comment.user_id = session[:user_id]
    @comment.save
    redirect_to user_posts_path(@user)
  end
end
