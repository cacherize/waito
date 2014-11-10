class CreateSupportTickets < ActiveRecord::Migration
  def change
    create_table :support_tickets do |t|
      t.string :email
      t.integer :user_id
      t.string :reason
      t.text :message
      t.datetime :resolved_at
      t.text :response
      t.datetime :archived_at

      t.timestamps
    end
  end
end
