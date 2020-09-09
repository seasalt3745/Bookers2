class BooksController < ApplicationController

  def top
  end

  before_action :authenticate_user!
  
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
  	  render 'index'
  	end
  end

  def show
  	@book = Book.find(params[:id])
  end

  def edit
  	@book = Book.find(params[:id])
    if @book.user!=current_user
      redirect_to user_path(current_user)
    end
  end

  def update
  	@book = Book.find(params[:id])
  	 if @book.update(book_params)
  	 	flash[:notice] = "Book was successfully updated."
  	    redirect_to book_path(@book.id)
  	 else
  	 	render 'edit'
  	 end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path
  end


private

  def book_params
  	params.require(:book).permit(:title,:body)
  end


end
