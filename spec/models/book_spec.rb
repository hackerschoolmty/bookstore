require 'rails_helper'

describe Book do
  it "should have a name, an author, an a slug" do
    book = build(:book)
    expect(book).to be_valid
  end

  it "should be invalid without a name" do
    book = build(:book, name: nil)
    expect(book).to_not be_valid
  end

  it "should be invalid without an author" do
    book =  build(:book, author: nil)
    expect(book).to_not be_valid
  end

  it "should be invalid without a slug" do
    book = build(:book, slug: nil)
    expect(book).to_not be_valid
  end

  it "should be valid with an uniq slug" do
    book1 = create(:book, slug: "1234")
    book = build(:book, slug: "1234")
    expect(book).to_not be_valid
  end

  it "should have many comments" do
    book = create(:book_with_comments)
    expect(book.comments.count).to be > 0
  end

  it "should have many pictures" do
    book = create(:book_with_pictures)
    expect(book.pictures.count).to be > 0
  end

  describe ".by_name" do
    before(:each) do
      @rails = create(:rails_book)
      @ruby = create(:ruby_book)
      @spec = create(:spec_book)
    end

    it "returns a list of books based on the name" do
      expect(Book.by_name("r")).to eq([@rails, @ruby])
    end

    it "rejects books based on the name" do
      expect(Book.by_name("r")).not_to include(@spec) 
    end
  end  
end