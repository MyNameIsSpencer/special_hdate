class AddUserAndReceiverToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :user_id, :integer
    add_column :messages, :receiver_id, :integer
    add_column :messages, :body, :text
  end
end
