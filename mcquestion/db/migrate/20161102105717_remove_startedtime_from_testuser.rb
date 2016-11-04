class RemoveStartedtimeFromTestuser < ActiveRecord::Migration
  def change
    remove_column :testusers, :startedtime, :datetime
  end
end
