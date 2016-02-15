require 'rails_helper'

RSpec.feature "Reviews", type: :feature, :js => true do
  before :each do
    Capybara.exact = true

    @harryPotter = Book.first
    @secretLives = Book.second
    @benny = User.find 4
    @peter = User.find 5
  end

  after :each do
    Review.destroy_all
  end

  scenario "User can create review" do
    comment = 'very well written'

    log_in_as User.first

    find(:xpath, "//a/img[@alt='Hp chamber secrets']/..").click

    click_link 'Add Review'

    find(:xpath, "//div/img[@title='gorgeous']").click
    fill_in :review_comment, :with => comment
    click_button 'Create Review'

    expect(page.body).to have_content(comment)
    expect(@harryPotter.reviews.where(comment: comment).count).to eq 1
  end

  scenario "User can edit review" do
    @harryPotter.reviews.create!(:rating => 3, :comment => "It's decent...",
                                 :user_id => @benny.id)
    log_in_as @benny

    find(:xpath, "//a/img[@alt='Hp chamber secrets']/..").click

    click_link 'Edit'
    fill_in :review_comment, :with => 'Good book'
    find(:xpath, "//div/img[@title='good']").click
    click_button 'Update Review'

    expect(page.body).to have_content('Good book')
    expect(@harryPotter.reviews.where(comment: 'Good book').count).to eq 1
  end

  scenario "User can destroy review" do
    @secretLives.reviews.create!(:rating => 5, :comment => 'interesting, good, funny',
                                 :user_id => @peter.id)

    log_in_as @peter
    visit book_path(@secretLives)

    page.accept_confirm "Do you really want delete this Review?" do
      click_link 'Destroy'
    end

    expect(page.body).to_not have_content('interesting, good, funny')
    expect(@secretLives.reviews.count).to eq 0
  end
end
