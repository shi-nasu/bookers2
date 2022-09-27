class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def index
    @newbook = Book.new
    @user = current_user
    @users = User.all
    @books = Book.all
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end
  
  #updateが成功した時
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = '1 error prohibited this obj from being saved:'
      redirect_to user_path(@user.id)
  #失敗した時
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction)  
  end
end
