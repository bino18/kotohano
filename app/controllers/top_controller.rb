class TopController < ApplicationController
  skip_before_action :login_required

  def top
    @posts = Post.includes(:user).order(id: "DESC").limit(10)
  end

  def terms
  end

  def privacy
  end
  
end