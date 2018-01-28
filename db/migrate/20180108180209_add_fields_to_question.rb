class AddFieldsToQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :survey_id, :integer
    add_column :questions, :option_a, :string
    add_column :questions, :option_b, :string
  end
end
