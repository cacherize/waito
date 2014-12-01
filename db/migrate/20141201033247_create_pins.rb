class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|
      t.belongs_to :user
      t.belongs_to :post

      t.timestamps
    end

    add_index :pins, [:user_id, :post_id], unique: true
  end
end
