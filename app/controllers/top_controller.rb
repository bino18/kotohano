class TopController < ApplicationController
  skip_before_action :login_required, only: [:top]

  def top
    @posts = Post.includes(:user).order(id: "DESC").limit(10)
  end
end
