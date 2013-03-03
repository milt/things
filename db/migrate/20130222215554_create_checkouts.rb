class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
      t.references :user
      t.datetime :pickup_at
      t.datetime :return_at

      t.timestamps
    end
  end
end
