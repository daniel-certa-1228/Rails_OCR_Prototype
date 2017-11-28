class CreateDocs < ActiveRecord::Migration[5.1]
  def change
    create_table :docs do |t|
      t.string :description, null: false
      t.datetime :date
      t.string :content
      t.attachment :avatar
      t.timestamps
    end
  end
end
