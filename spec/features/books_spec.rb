require 'rails_helper'

RSpec.feature "Books", type: :feature, :js => true do
  before :each do
    Capybara.exact = true

    @fr_edited_title = 'Terms of Enlistment (Frontlines Book 1)'
    @frontlines = {:title => 'Terms Enlistment (Frontlines Book 1)',
                   :author => 'Marko Kloos',
                   :description => "Helvetica four dollar toast cliche, chartreuse irony viral austin disrupt celiac health goth cronut franzen lo-fi.",
                   :category_id => Category.first}

    @user_1 = User.first
  end

  after :each do
    frontlines = Book.where(:title => @frontlines[:title]).destroy_all
    frontlines = Book.where(:title => @fr_edited_title).destroy_all
  end

  scenario "Create, edit and delete the book" do
    log_in_as @user_1

    click_link 'Add Book'

    fill_in :book_title, :with => @frontlines[:title]
    fill_in :book_author, :with => @frontlines[:author]
    fill_in :book_description, :with => @frontlines[:description]
    select @frontlines[:category_id].name, :from => 'book_category_id'
    page.driver.browser.all(:xpath, '//input[@name="book[book_img]"]')[0].send_keys('/home/maciek/Pictures/terms_enlistment.jpeg')
    click_button 'Create Book'

    find(:xpath, "//a/img[@alt='Terms enlistment']/..").click

    click_link 'Edit'

    fill_in :book_title, :with => @fr_edited_title
    click_button 'Update Book'

    expect(current_path).to eq book_path(Book.last)
    expect(page.body).to have_content(@fr_edited_title)

    page.accept_confirm "Do you really want delete the Book?" do
      click_on 'Delete'
    end

    expect(current_path).to eq(root_path)
    expect(page.body).to_not have_xpath("//a/img[@alt='Terms enlistment']")
  end

end
