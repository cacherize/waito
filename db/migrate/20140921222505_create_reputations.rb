class CreateReputations < ActiveRecord::Migration
  def change
    create_table :reputations do |t|
      t.belongs_to :user
      t.references :reputable, polymorphic: true
      t.float :value, default: 0

      t.timestamps
    end
  end
end
