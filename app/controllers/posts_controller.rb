class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  skip_before_action :login_required, only: [:show]

  def index
    @posts = Post.includes(:user).order(id: "DESC").page(params[:page]).per(20)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to post_url(@post), notice: '投稿できました!'
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to post_url(@post), notice: '更新しました'
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: '削除しました'
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :explanation)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end
end
