class DropColumnFsaLatitudeLongitudeFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :fsa
    remove_column :users, :latitude
    remove_column :users, :longitude
    add_column    :users, :fsa_id, :integer
  end
end
