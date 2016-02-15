require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @review = Review.new(:rating => 5, :comment => "best book ever!!!",
                             :book_id => 404, :user_id => 404)

    expect(@review).to be_valid
  end

  describe "Review[:rating]" do
    it "should not be empty and has value between 1 and 5" do
      @review[:rating] = ' '
      expect(@review).to be_invalid

      @review[:rating] = 0
      expect(@review).to be_invalid

      @review[:rating] = 6
      expect(@review).to be_invalid
    end
  end

  describe "Review[:comment]" do
    it "should not be empty" do
      @review[:comment] = ' '
      expect(@review).to be_invalid
    end
  end

  describe "Review[:book_id]" do
    it "should not be empty, be a number" do
      @review[:book_id] = ' '
      expect(@review).to be_invalid

      @review[:book_id] = 'xgegfvfw'
      expect(@review).to be_invalid
    end
  end

  describe "Review[:user_id]" do
    it "should not be empty, be a number" do
      @review[:user_id] = ' '
      expect(@review).to be_invalid

      @review[:user_id] = 'xgegfvfw'
      expect(@review).to be_invalid
    end
  end

end
