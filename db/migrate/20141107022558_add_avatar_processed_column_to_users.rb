class AddAvatarProcessedColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_processed, :boolean, default: false
  end
end
