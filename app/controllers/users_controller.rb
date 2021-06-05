class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_url(@user), notice: "#{@user.name}を登録しました"
      session[:user_id] = @user.id
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)

    redirect_to user_url(@user), notice: "#{@user.name}を更新しました"
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to new_user_url, notice: '削除しました'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end
end
