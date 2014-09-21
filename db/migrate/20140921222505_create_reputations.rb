class CreateReputations < ActiveRecord::Migration
  def change
    create_table :reputations do |t|

      t.timestamps
    end
  end
end
