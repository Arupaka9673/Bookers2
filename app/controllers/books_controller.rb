class BooksController < ApplicationController
    before_action :is_matching_login_user, only: [:edit, :update]
    
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    @user = current_user
    if @book.save
      flash[:notice] = "You have created book successfully." 
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end
  
  def index
    @book = Book.new  # 投稿一覧画面から新規投稿を行うために必要となる
    @books = Book.all # 投稿作品のすべてを表示するために必要となる
    @user = current_user # ログインしているユーザー情報を受け取る
    @post_images = Book.page(params[:page]) #ページネーション用変数
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @post_comment = PostComment.new
    @user = current_user
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      flash[:notice] = "You have updated book successfully." 
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to "/books"
  end
  
  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
    
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end
end
