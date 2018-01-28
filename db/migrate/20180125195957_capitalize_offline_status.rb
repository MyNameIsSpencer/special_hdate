class CapitalizeOfflineStatus < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:users, :status, "Offline")
  end
end
