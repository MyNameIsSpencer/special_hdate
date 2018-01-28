class ChangeUserColumnFsa < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :FSA, :fsa
  end
end
