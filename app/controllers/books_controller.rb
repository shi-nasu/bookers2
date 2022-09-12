class BooksController < ApplicationController
  def new
    @books = Book.find(params[:id])
  end
  
  def index
  end
  
  def edit
  end
  
  def show
  end
end
