class AddBlockArrayToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :blocks, :integer, array: true, default: []
  end
end
