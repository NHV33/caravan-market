class RemoveVehicleIdFromReviews < ActiveRecord::Migration[6.0]
  def change
    remove_column :reviews, :vehicle_id, :bigint
  end
end
