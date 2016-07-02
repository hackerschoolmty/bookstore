class AuthorEmailToBook < ActiveRecord::Migration
  def change
    add_column :books, :author_email, :string
  end
end
