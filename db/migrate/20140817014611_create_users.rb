class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :auth_token
      t.string :password_digest
      t.datetime :invitation_sent_at
      t.boolean :activated, default: false
      t.boolean :private, default: false
      t.datetime :password_reset_sent_at
      t.string :password_reset_token
      t.boolean :exec, default: false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
