class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :name
      t.string :email
      t.datetime :day
      t.datetime :time
      t.integer :member
      t.string :content

      t.timestamps
    end
  end
end
