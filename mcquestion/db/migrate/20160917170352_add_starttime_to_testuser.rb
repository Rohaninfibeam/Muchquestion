class AddStarttimeToTestuser < ActiveRecord::Migration
  def change
    add_column :testusers, :starttime, :datetime
  end
end
