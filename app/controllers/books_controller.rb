class BooksController < ApplicationController

  before_action :authenticate_user!

  def index
    @books  = Book.all
    @book = Book.new
  end

  def show
    @book  = Book.new
    @books = Book.find(params[:id])

  end

  def create
  @book = Book.new(book_params)
  @book.user_id = current_user.id
  if @book.save
    flash[:notice] = "successfully"
    # 本の作成後、本の詳細ページに飛ばしている、bookpathはbookのshow
    redirect_to book_path(@book)
  else flash[:notice] = "error"
    # レンダーで戻しているため、INDEXのコントローラ内の情報を再定義する必要がある
    @books  = Book.all
    @book = Book.new
    render :index
  end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
    if @book.update(book_params)
      flash[:notice] = 'successfully'
      redirect_to book_path(@book)
    else
      flash[:notice] = "error"
      #コントローラのアクションを通さない
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      flash[:notice] = 'successfully'
      redirect_to books_path
    else
      flash[:notice] = "error"
      render :edit
      #コントローラのアクションを通さない
    end
  end

private
def book_params
  params.require(:book).permit(:title, :body)
end

end
