require 'rails_helper'

describe BooksController do

  shared_examples "public access to books" do
    describe "GET 'index'" do
      before(:each) do
        @books = create_list(:book, rand(1..10))
        get :index
      end

      it "should be success" do
        expect(response).to be_success
      end

      it "should render index view" do
        expect(response).to render_template :index
      end

      it "should assigns all books as @books" do
        expect(assigns(:books)).to match_array(@books)
      end
    end

    describe "GET 'show'" do
      before(:each) do
        @book = create(:book)
        get :show, id: @book
      end

      it "should be success" do
        expect(response).to be_success
      end

      it "should render edit view" do
        expect(response).to render_template :show
      end

      it "should find the requested book" do
        expect(assigns(:book)).to eq(@book)
      end
    end
    
  end

  describe "Admin access" do

    before(:each) do
      sign_in_user_admin
    end

    it_behaves_like "public access to books"

    describe "GET 'new'" do
      before(:each) do
        get :new
      end

      it "should be success" do
        expect(response).to be_success
      end

      it "should render new view" do
        expect(response).to render_template :new
      end

      it "should build a new book" do
        expect(assigns(:book)).to be_a_new Book
      end
    end

    describe "GET 'edit'" do
      before(:each) do
        @book = create(:book)
        get :edit, id: @book
      end

      it "should be success" do
        expect(response).to be_success
      end

      it "should render edit view" do
        expect(response).to render_template :edit
      end

      it "should find the requested book" do
        expect(assigns(:book)).to eq(@book)
      end
    end

    describe "POST 'create'" do
      context "With valid params" do
          it "should create a book" do
          expect{
              post :create, book: attributes_for(:book)
            }.to change(Book, :count).by(1)
        end

        it "should redirect to book" do
          post :create, book: attributes_for(:book)
          expect(response).to redirect_to book_url(Book.last)
        end
      end

      context "With invalid params" do
        it "shoud not create a book" do
          expect {
            post :create, book: attributes_for(:book, name: nil)
          }.to change(Book, :count).by(0)
        end

        it "should render the form" do
          post :create, book: attributes_for(:book, name: nil)
          expect(response).to render_template :new
        end
      end
    end

    describe "PUT 'update'" do
      before(:each) do
        @book = create(:book)
      end

      context "With valid params" do 
        it "should update book attributes" do
          put :update, id: @book, book: { name: "new name"}
          @book.reload
          expect(@book.name).to eq("new name")
        end

        it "should redirect to book detail" do
          put :update, id: @book, book: { name: "new name"}
          expect(response).to redirect_to book_path
        end
      end

      context "With invalid params" do
        it "should not update book attributes" do
          put :update, id: @book, book: { name: nil}
          @book.reload
          expect(@book.name).to_not be_nil
        end

        it "should render edit" do
          put :update, id: @book, book: { name: nil}
          expect(response).to render_template :edit
        end
      end

      describe "DELETE 'destroy'" do
        before(:each) do
          @book = create(:book)
        end

        it "should delete the book" do
          expect{
            delete :destroy, id: @book
          }.to change(Book, :count).by(-1)
        end

        it "should redirect to books path" do
          delete :destroy, id: @book
          expect(response).to redirect_to books_path
        end
      end
    end
  end

  describe "Regular access" do
    before(:each) do
      sign_in_user_regular
    end

    it_behaves_like "public access to books"

    describe "GET 'edit" do
      it "should raise an error" do
        book = create(:book)
        expect{
          get :edit, id: book
        }.to raise_error CanCan::AccessDenied
      end
    end

    describe "GET 'new'" do
      it "should raise an error" do
        expect{
          get :new
        }.to raise_error CanCan::AccessDenied
      end
    end

    describe "POST 'create'" do
      it "should raise an error" do
        expect{
          post :create, book: attributes_for(:book)
        }.to raise_error CanCan::AccessDenied
      end
    end

    describe "PUT 'update'" do
      it "should raise an error" do
        book = create(:book)
        expect{
          put :update, id: book, book: attributes_for(:book)
        }.to raise_error CanCan::AccessDenied
      end
      
    end

    describe "DELETE 'destroy'" do
      it "should raise an error" do
        book = create(:book)
        expect{
          delete :destroy, id: book
        }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe "Guest access" do
    it_behaves_like "public access to books"

    describe "GET 'edit" do
      it "should not be_success" do
        book = create(:book)
        get :edit, id: book
        expect(response).to_not be_success
      end
    end

    describe "GET 'new" do
      it "should not be_success" do
        get :new
        expect(response).to_not be_success
      end
    end

    describe "POST 'create'" do
      it "should not be_success" do
        post :create, book: attributes_for(:book)
        expect(response).to_not be_success
      end
    end

    describe "PUT 'update'" do
      it "should not be_success" do
        book = create(:book)
        post :update, id: book, book: attributes_for(:book)
        expect(response).to_not be_success
      end
    end

    describe "DELETE 'destroy'" do
      it "should not be_success" do
        book = create(:book)
        delete :destroy, id: book
        expect(response).to_not be_success
      end
    end
  end
end