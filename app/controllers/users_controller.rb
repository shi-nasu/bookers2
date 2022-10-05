class UsersController < ApplicationController

  before_action :move_to_signed_in

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
        render "edit"
    else
        redirect_to user_path(current_user)
    end
  end

  def index
    @book = Book.new
    @user = current_user
    @users = User.all
    @books = Book.all
  end

  #updateが成功した時
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'successfully'
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

  def move_to_signed_in
    unless user_signed_in?
      #サインインしていないユーザーはログインページが表示される
      redirect_to  '/users/sign_in'
    end
  end

end
