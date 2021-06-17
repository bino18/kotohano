class TopController < ApplicationController
  skip_before_action :login_required, only: [:top]

  def top
    @posts = Post.all
  end
end
