class UsersController < ApplicationController


    before_action :authenticate_user!

  def index
    @user = User.find(current_user.id)
    @users = User.page(params[:page]).reverse_order
    @book = Book.new
  end

  def show
  	@user = User.find(params[:id])
  	@book = Book.new
  	@books = @user.books.page(params[:page]).reverse_order
  end

  def edit
  	@user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated."
      redirect_to user_path(current_user)
    else
      @user = User.find(params[:id])
      flash[:notice] = "error"
      render 'edit'
    end
  end


  private

  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
