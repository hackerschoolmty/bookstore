require 'rails_helper'

feature "User management" do
  scenario "Create a new user" do
    visit root_path
    click_link "Sign up"
    sleep(2)
    expect{
      fill_in "user_name", with: Faker::Name.name
      fill_in "user_email", with: "cosme@hackerschool.com"
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"
      click_button "Guardar"
      sleep(2)
    }.to change(User, :count).by(1)
  end
end