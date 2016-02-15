module FeatureHelpers
  def log_in_as(user)
    visit new_user_session_path

    fill_in :user_email, :with => user.email
    fill_in :user_password, :with => "12345qwert"
    click_button 'Log in'
  end
end
