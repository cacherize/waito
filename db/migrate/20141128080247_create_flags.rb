class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.belongs_to :user, allow_nil: false
      t.references :flaggable, polymorphic: true
      t.string :reason, allow_nil: false
      t.timestamps
    end

    add_index :flags, :user_id
  end
end
