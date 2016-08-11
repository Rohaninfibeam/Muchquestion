class AddTypeToTests < ActiveRecord::Migration
  def change
    add_column :tests, :type, :string
  end
end
