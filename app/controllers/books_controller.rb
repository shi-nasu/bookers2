class BooksController < ApplicationController
  def new
    @books = Book.find(params[:id])
  end
  
  def index
    
    @books = Book.all
    @user = current_user
    @newbook = Book.new
  end
  
  def edit
    @book = Book.find(params[:id])
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
    redirect_to book_path(@book.id)
  end
  
  #updateが成功した時
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = '1 error prohibited this obj from being saved:'
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
    params.require(:book).permit(:title, :body, :image)  
  end
end
