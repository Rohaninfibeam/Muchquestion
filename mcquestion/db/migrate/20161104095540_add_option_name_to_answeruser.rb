class AddOptionNameToAnsweruser < ActiveRecord::Migration
  def change
    add_column :answerusers, :option_name, :integer
  end
end
