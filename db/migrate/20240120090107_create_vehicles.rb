class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :price
      t.string :days

      t.timestamps
    end
  end
end
