class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
      current_user.view_counts.create(book_id: @book.id)
    end
  end

  def index
    if params[:sort] == "favorite DESC"
      @books = Book.includes(:favorited_books).sort_by {|x|
        x.favorited_books.includes(:favorites).size
      }.reverse
    else (params[:sort]) == "created_at DESC" || (params[:sort]) == "rate DESC"
         @books = Book.all.order(params[:sort])
    end
    @book = Book.new
    # to = Time.current.at_end_of_day
    # from = (to - 6.day).at_beginning_of_day
    # @books = Book.includes(:favorited_books).sort_by {|x|
    #     x.favorited_books.includes(:favorites).where(created_at: from...to).size
    #   }.reverse
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list = params[:book][:tag_name].split(",")
    if @book.save
      @book.save_tags(tag_list)
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render "index"
    end
  end

  def edit
  end

  def update
    tag_list = params[:book][:tag_name].split(",")
    if @book.update(book_params)
      @book.save_tags(tag_list)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body, :rate)
    end

    def ensure_correct_user
      @book = Book.find(params[:id])
      unless @book.user == current_user
        redirect_to books_path
      end
    end
end
