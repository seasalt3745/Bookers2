class UsersController < ApplicationController


    before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
  	@book = Book.new
  	@books = Book.page(params[:page]).reverse_order

  end

  def edit
  	@user = User.find(params[:id])
    if @user!=current_user
      redirect_to user_path(current_user)
    end
  end

  def update
  	@user = User.find(params[:id])
  	@user.update(user_params)
  	redirect_to user_path(current_user)
  end


  private

  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
