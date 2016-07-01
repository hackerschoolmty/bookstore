class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :image
      t.integer :picturable_id
      t.string :picturable_type

      t.timestamps null: false
    end
  end
end
