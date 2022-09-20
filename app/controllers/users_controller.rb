class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post_image = @user.post_images
    @books = Book.all
    @book = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def index
    @users = User.all
    @books = Book.all
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction)  
  end
end
