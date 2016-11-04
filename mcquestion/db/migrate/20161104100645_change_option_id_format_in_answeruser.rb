class ChangeOptionIdFormatInAnsweruser < ActiveRecord::Migration
  def up
    change_column :answerusers, :option_id, :boolean
  end

  def down
    change_column :answerusers, :option_id, :integer
  end
end
