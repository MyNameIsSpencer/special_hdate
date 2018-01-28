class AddUrlsToDatabaseForPictures < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :option_a_url, :string
    add_column :questions, :option_b_url, :string
  end
end
