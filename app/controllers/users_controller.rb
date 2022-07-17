class UsersController < ApplicationController
   before_action :authenticate_user!
  def new
    @user = User.new
  end

  def create
    @user = User.new(book_params)
    @user.user_id = current_user.id
    @user.save
    @users = User.all
    redirect_to user_path(current_user)
  end

  def index
    @book = Book.new
    @users =User.all
    @user = current_user
  end

  def show
    @book = Book.new
    @users = User.all
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
     @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user)
    else
      @users = User.all
      render :edit
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy(user_params)
    redirect_to '/users'
  end

   private

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end
end