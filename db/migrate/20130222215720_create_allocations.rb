class CreateAllocations < ActiveRecord::Migration
  def change
    create_table :allocations do |t|
      t.references :checkout
      t.references :thing
      t.datetime :pickup_at
      t.datetime :return_at
      t.datetime :picked_up
      t.datetime :returned

      t.timestamps
    end
    add_index :allocations, :thing_id
  end
end
