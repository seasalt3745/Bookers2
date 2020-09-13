class BooksController < ApplicationController

  before_action :authenticate_user!, only: [:index,:create,:edit,:update,:destroy,:show]
  before_action :user_check, only: [:edit, :update]

  def top
  end

  def index
  	@book = Book.new
  	@books = Book.page(params[:page]).reverse_order
  	@user = User.find(current_user.id)
  end

  def create
  	@books = Book.page(params[:page]).reverse_order
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
  	if @book.save
  	   flash[:notice] = "Book was successfully created."
  	   redirect_to book_path(@book.id)
  	else
  		# flash[:alert] = 'error'
			# <% if flash[:alert] %>
			# <p><%= flash[:alert] %></p>
			# <% end %>
      @books = Book.page(params[:page]).reverse_order
      @user = User.find(current_user.id)
  	  render 'users/show'
  	end
  end

  def show
    @user = User.find(current_user.id)
    @book = Book.new
    @booker = Book.find(params[:id])
  end

  def edit
  	@book = Book.find(params[:id])
    if @book.user != current_user
      flash[:notice] = "error."
      redirect_to books_path
    end
  end

  def update
  	@book = Book.find(params[:id])
  	 if @book.update(book_params)
  	 	flash[:notice] = "Book was successfully updated."
  	  redirect_to book_path(@book.id)
  	 else
      # @book = Book.find(params[:id])
  	 	render 'edit'
  	 end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to user_path(book.user.id)
  end


private

  def book_params
  	params.require(:book).permit(:title,:body,:user_id)
  end

  def user_check
    book = Book.find(params[:id])
    if current_user.id != book.user_id
      redirect_to books_path
    end
  end


end
