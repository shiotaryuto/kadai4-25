class BooksController < ApplicationController
   before_action :authenticate_user!
  def index
    @book = Book.new
    @user = current_user
    @books = Book.all

  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @books = Book.find(params[:id])
    @book =Book.new
    @user =@books.user
  end

  def edit
    @book = Book.find(params[:id])
    @user= @book.user
    redirect_to books_path unless @user==current_user
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
    @books = Book.all
    render :edit
    end
  end

  def destroy
    books = Book.find(params[:id])
    books.destroy
    redirect_to books_path
  end

   private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
