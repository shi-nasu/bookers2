class BooksController < ApplicationController

  before_action :move_to_signed_in

  def new
    @books = Book.find(params[:id])
  end

  def index

    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
      if @book.user == current_user
        render "edit"
      else
        redirect_to books_path
      end
  end

  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @user = @book.user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    #createが成功した時
    if @book.update(book_params)
      flash[:notice] = 'successfully'
    redirect_to book_path(@book.id)
    #失敗した時
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  #updateが成功した時
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'successfully'
      redirect_to book_path(@book.id)
  #失敗した時
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def move_to_signed_in
    unless user_signed_in?
      #サインインしていないユーザーはログインページが表示される
      redirect_to  '/users/sign_in'
    end
  end

end
