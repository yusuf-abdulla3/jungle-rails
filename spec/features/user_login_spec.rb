require 'rails_helper'

RSpec.feature "User login", type: :feature, js: true do

  before :each do
  @user = User.create! name: "John Doe", email: 'example@example.com', password: "password", password_confirmation: "password"
  end
  
  
  scenario "entering correct login info" do
    
    visit root_path
    click_on('Login')
    sleep 1
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_button 'Submit'
    sleep 1
    save_screenshot
    expect(page).to have_content 'Logout'

  end

end