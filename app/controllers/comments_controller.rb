class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    if @comment.save
      redirect_back(fallback_location: post_path(@post))
    else
      redirect_back(fallback_location: post_path(@post))
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: post_path(@post))
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :evaluation).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
