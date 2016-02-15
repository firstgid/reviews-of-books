require 'rails_helper'

RSpec.describe Category, type: :model do

  after :each do
    Category.where(:name => 'Health and Sport').destroy_all
  end

  describe "Category[:name]" do
    it "should not be empty" do
      category = Category.new
      expect(category).to be_invalid

      category[:name] = 'Health and Sport'
      expect(category).to be_valid
    end
  end

end
