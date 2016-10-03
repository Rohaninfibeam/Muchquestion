class AddOrderToTestquestion < ActiveRecord::Migration
  def change
    add_column :testquestions, :order, :integer
  end
end
