class BooksController < ApplicationController
  def new
    @books = Book.find(params[:id])
  end
  
  def index
    @books = Book.all
    @user = current_user
  end
  
  def edit
  end
  
  def show
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body, :image)  
  end
end
