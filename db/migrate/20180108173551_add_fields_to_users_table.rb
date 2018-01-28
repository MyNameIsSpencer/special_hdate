class AddFieldsToUsersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :FSA, :string, default: nil
    add_column :users, :gender, :string, default: "undefined"
    add_column :users, :orientation, :string, default: "undefined"
    add_column :users, :looking_for, :string, default: "undefined"
    add_column :users, :phone, :integer
    add_column :users, :privacy, :boolean, default: false
  end
end
