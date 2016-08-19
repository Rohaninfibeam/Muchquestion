class RenameOldTableToNewTable< ActiveRecord::Migration
  def change
    rename_table :answers, :userquestions
  end 
end