class AddStampsToCheckouts < ActiveRecord::Migration
  def change
    add_column :checkouts, :picked_up, :datetime
    add_column :checkouts, :returned, :datetime
  end
end
