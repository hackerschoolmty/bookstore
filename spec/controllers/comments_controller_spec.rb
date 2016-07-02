require 'rails_helper' 

describe CommentsController do
  before(:each) do
    @book = create(:book)
    @user = create(:user)
  end

  describe "POST 'create'" do

    it "should create a new comment" do
      expect{
        post :create, book_id: @book, comment: attributes_for(:comment, user_id: @user.id), format: :js
      }.to change(Comment, :count).by(1) 
    end
  end
end