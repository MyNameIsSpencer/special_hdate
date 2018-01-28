class AddFieldsToResult < ActiveRecord::Migration[5.1]
  def change
    add_column :results, :user_id, :integer
    add_column :results, :survey_id, :integer
    add_column :results, :answers, :string, array: true, default: []
    add_column :results, :matches, :string, array: true, default: []
  end
end
