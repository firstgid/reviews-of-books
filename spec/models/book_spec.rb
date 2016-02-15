require 'rails_helper'

RSpec.describe Book, type: :model do
  before :each do
    @frontlines = User.first.books.new(
      :title => 'Terms Enlistment (Frontlines Book 1)',
      :author => 'Marko Kloos',
      :description => "Helvetica four dollar toast cliche, cronut franzen lo-fi.",
      :category_id => Category.first.id
    )

    expect(@frontlines).to be_valid
  end

  describe "Book[:title]" do
    it "should not be empty" do
      @frontlines[:title] = " "
      expect(@frontlines).to be_invalid
    end
  end

  describe "Book[:description]" do
    it "should has minimum 5 chars" do
      @frontlines[:description] = " "
      expect(@frontlines).to be_invalid

      @frontlines[:description] = "a" * 4
      expect(@frontlines).to be_invalid

      @frontlines[:description] = "a" * 5
      expect(@frontlines).to be_valid
    end
  end

  describe "Book[:author]" do
    it "should not be empty" do
      @frontlines[:author] = " "
      expect(@frontlines).to be_invalid
    end
  end

  describe "Book[:category_id]" do
    it "should not be empty" do
      @frontlines[:category_id] = " "
      expect(@frontlines).to be_invalid
    end
  end

  describe "Book[:user_id]" do
    it "should not be empty" do
      @frontlines[:user_id] = " "
      expect(@frontlines).to be_invalid
    end
  end

end
