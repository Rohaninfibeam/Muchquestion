class AddOrderToOption < ActiveRecord::Migration
  def change
    add_column :options, :order, :integer
  end
end
