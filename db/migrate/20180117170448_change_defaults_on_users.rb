class ChangeDefaultsOnUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:users, :privacy, true )
    change_column_default(:users, :status, "offline")
  end
end
