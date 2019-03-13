class UsersController < ApplicationController
  before_action :set_user, only: :show

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @message = params[:message] if params[:message]
    @message ||= false
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :password, :height, :tickets, :happiness, :nausea, :admin)
  end
end
