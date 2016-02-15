require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, :id => 1
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success if user is sign in" do
      sign_in User.first

      get :new
      expect(response).to have_http_status(:success)
    end

    it "redirect to sign in page if user is not logged in" do
      sign_in nil

      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #edit" do
    it "returns http success if proper user is sign in" do
      sign_in User.first

      get :edit, :id => 1
      expect(response).to have_http_status(:success)
    end

    it "redirect to sign in page if user is not logged in" do
      sign_in nil

      get :edit, :id => 1
      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirect to show-book page if user is inproper" do
      sign_in User.second

      get :edit, :id => 1
      expect(response).to redirect_to(book_path(1))
    end
  end

  describe "Get #destroy" do
    before :each do
      @book_sec = User.second.books.create!(
        :title => "Terms of Enlistment (Frontlines Book 1)",
        :author => 'Marko Kloos',
        :category_id => Category.find_by(name: "Science Fiction & Fantasy").id,
        :description => "Helvetica four dollar toast cliche, chartreuse irony viral.",
        :book_img => File.new('/home/maciek/Pictures/terms_enlistment.jpeg', 'r'))
    end

    after :each do
      Book.where(:title => "Terms of Enlistment (Frontlines Book 1)").destroy_all
    end

    it "returns http success if proper user is sign in" do
      sign_in User.first

      get :destroy, :id => @book_sec
      expect(response).to have_http_status(:found)
    end

    it"redirect to sign in page if user is not logged in" do
      sign_in nil

      get :destroy, :id => @book_sec
      expect(response).to redirect_to(new_user_session_path)
    end
  end

end
