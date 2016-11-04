class AddSubmittedToTestuser < ActiveRecord::Migration
  def change
    add_column :testusers, :submitted, :boolean
  end
end
