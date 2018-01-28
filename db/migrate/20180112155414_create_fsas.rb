class CreateFsas < ActiveRecord::Migration[5.1]
  def change
    create_table :fsas do |t|
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
