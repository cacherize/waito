class AddPublicAddressColumnToSupportTickets < ActiveRecord::Migration
  def change
    add_column :support_tickets, :public_address, :string
  end
end
