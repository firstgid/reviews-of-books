require 'rails_helper'

RSpec.feature "Users", type: :feature, :js => true do
  before :each do
    Capybara.exact = true

    @brooke = {email: 'brooke@example.com', password: 'Brooke123'}
  end

  after :each do
    User.where(:email => @brooke[:email]).destroy_all
  end

  scenario "Sign up new User" do
    visit root_path

    click_link 'Sign Up'

    fill_in :user_email, :with => @brooke[:email]
    fill_in :user_password, :with => @brooke[:password]
    fill_in :user_password_confirmation, :with => @brooke[:password]
    click_button 'Sign up'

    expect(page.body).to have_content('Welcome! You have signed up successfully.')
    expect(current_path).to eq(root_path)
  end

  scenario "Sign Out User" do
    log_in_as User.first

    click_link 'Sign Out'
    expect(page.body).to have_content('Signed out successfully.')
  end
end
