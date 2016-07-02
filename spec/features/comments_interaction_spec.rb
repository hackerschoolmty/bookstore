require 'rails_helper'

feature "Comments interaction" do

  before(:each) do
    @user = create(:user)
    @book = create(:book)
    feature_sign_in @user
  end

  scenario "Create a new comment" do
    visit book_path(@book, locale: "en")
    expect{
     fill_in "comment_description", with: Faker::Lorem.sentence 
     click_button "add_button_comment"
     sleep(1)
    }.to change(Comment, :count).by(1)
    
  end

  scenario "Display a comment" do
    visit book_path(@book, locale: "en")
    description = Faker::Lorem.sentence 
    fill_in "comment_description", with: description
     click_button "add_button_comment"
    sleep(1)
    expect(page).to have_content description
  end

  scenario "delete a comment" do
    comment = create(:comment, book: @book)
    visit book_path(@book, locale: "en")
    within "#comment_#{comment.id}" do
      click_link "Eliminar"
    end

    page.accept_alert
    sleep(1)
    expect(page).to_not have_content comment.description
  end
end