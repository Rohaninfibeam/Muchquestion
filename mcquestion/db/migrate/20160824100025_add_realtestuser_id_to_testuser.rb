class AddRealtestuserIdToTestuser < ActiveRecord::Migration
  def change
    add_column :testusers, :realtestuser_id, :integer
  end
end
