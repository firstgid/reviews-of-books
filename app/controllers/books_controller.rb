class BooksController < ApplicationController
  before_action :find_book, :only => [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :only => [:new, :edit, :destroy]
  before_action :check_user!, :only => [:edit, :destroy]

  def index
    if params.has_key?(:category)
      @category_id = Category.find_by(:name => params[:category]).id
      @books = Book.where(:category_id => @category_id).order('created_at DESC')
    else
      @books = Book.all.order('created_at DESC')
    end
  end

  def show
    if @book.reviews.blank?
      @average_review = 0
    else
      @average_review = @book.reviews.average(:rating).round(2)
    end
  end

  def new
    @book = current_user.books.build
    @categories = Category.all.map{|c| [c.name, c.id]}
  end

  def create
    @book = current_user.books.build(get_params)

    if @book.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @categories = Category.all.map{|c| [c.name, c.id]}
  end

  def update
    if @book.update(get_params)
      redirect_to book_url(@book)
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_to root_url
  end

  private

    def get_params
      params.require(:book).permit(:title, :description, :author, :category_id,
                                  :book_img)
    end

    def find_book
      @book = Book.find(params[:id])
    end

    def check_user!
      unless current_user.id == @book.user_id
        redirect_to book_path(@book)
      end
    end
end
