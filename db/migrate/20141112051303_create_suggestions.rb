class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.belongs_to :user
      t.string :title
      t.text :message
      t.integer :response
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
