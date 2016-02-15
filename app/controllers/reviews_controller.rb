class ReviewsController < ApplicationController
  before_action :find_book
  before_action :find_review, :only => [:edit, :update, :destroy]
  before_action :authenticate_user!, :only => [:new, :edit, :destroy]
  before_action :check_user!, :only => [:edit, :update, :destroy]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(get_review_params)
    @review.book_id = @book.id
    @review.user_id = current_user.id

    if @review.save
      redirect_to book_url(@book)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @review.update(get_review_params)
      redirect_to book_url(@book)
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to book_url(@book)
  end

  private

    def get_review_params
      params.require(:review).permit(:rating, :comment)
    end

    def find_book
      @book = Book.find(params[:book_id])
    end

    def find_review
      @review = Review.find(params[:id])
    end

    def check_user!
      unless current_user.id == find_review.user_id
        redirect_to book_path(@book)
      end
    end
end
