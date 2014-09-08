class CreatePostTags < ActiveRecord::Migration
  def change
    create_table :post_tags do |t|
      t.belongs_to :post
      t.belongs_to :tag
      t.timestamps
    end

    add_index :post_tags, [:post_id, :tag_id], unique: true
  end
end
