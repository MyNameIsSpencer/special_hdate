class AddIncomeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column    :users, :income, :integer, default: nil
  end
end
