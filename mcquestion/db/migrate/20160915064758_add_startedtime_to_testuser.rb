class AddStartedtimeToTestuser < ActiveRecord::Migration
  def change
    add_column :testusers, :startedtime, :datetime
  end
end
