class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.text :message
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
