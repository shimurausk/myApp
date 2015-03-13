class AddStaffIdToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :staff_id, :integer
  end
end
