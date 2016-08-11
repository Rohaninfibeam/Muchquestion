class CreateQuestiontypes < ActiveRecord::Migration
  def change
    create_table :questiontypes do |t|
      t.string :qtype

      t.timestamps null: false
    end
  end
end
