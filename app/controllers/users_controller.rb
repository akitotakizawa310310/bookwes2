class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @users  = User.all
    @book  = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    #個人のidとデータベース上のidが結びつく。#左側が個人のユーザーID、右側がデータベース上でのID
    @thebook = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    #@userに統一、二つのアクションをだすため
    if @user.update(user_params)
    flash[:notice] = 'User was successfully updated'
    redirect_to user_path(@user)
    else
    flash[:notice] = "error"
    render :edit
    end
  end


  private
      def user_params
        params.require(:user).permit(:name, :introduction, :profile_image)
      end
end
