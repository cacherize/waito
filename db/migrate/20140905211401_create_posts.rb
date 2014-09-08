class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user
      t.string :title, limit: 512
      t.text :description
      t.datetime :archived_at
      
      t.timestamps
    end
  end
end
