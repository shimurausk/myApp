class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :name
      t.string :email
      t.text :address
      t.integer :age
      t.string :post
      t.integer :hourlywage
      t.text :memo
      t.string :icon

      t.timestamps
    end
  end
end
