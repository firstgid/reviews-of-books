require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  before :each do
    @book = Book.first
    @review = @book.reviews.create!(:rating => 5, :comment => 'Best book', :user_id => User.first.id)
  end

  after :each do
    Review.destroy_all
  end

  describe "GET #new" do
    it "returns http success if user is logged in" do
      sign_in User.first

      get :new, :book_id => 1
      expect(response).to have_http_status(:success)
    end

    it "redirect to sign in page if user isn't logged in" do
      sign_in nil

      get :new, :book_id => 1
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #edit" do
    it "returns http success if user is logged in" do
      sign_in User.first

      get :edit, :book_id => 1, :id => @review
      expect(response).to have_http_status(:success)
    end

    it "redirect to sign in page if user isn't logged in" do
      sign_in nil

      get :edit, :book_id => 1, :id => @review
      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirect to show-book page if user is inproper" do
      sign_in User.second

      get :edit, :book_id => 1,:id => @review
      expect(response).to redirect_to(book_path(1))
    end
  end

  describe "GET #destroy" do
    it "returns http success if user is logged in" do
      sign_in User.first

      get :destroy, :book_id => 1, :id => @review
      expect(response).to have_http_status(:found)
      expect(@book.reviews.count).to eq 0
    end

    it "redirect to sign in page if user isn't logged in" do
      sign_in nil

      get :destroy, :book_id => 1, :id => @review
      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirect to show-book page if user is inproper" do
      sign_in User.second

      get :destroy, :book_id => 1,:id => @review
      expect(response).to redirect_to(book_path(1))
    end
  end

end
