class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.datetime :date
      t.datetime :start
      t.datetime :end
      t.datetime :break
      t.references :staff, index: true

      t.timestamps
    end
  end
end
