class CreateTestUploads < ActiveRecord::Migration
  def change
    create_table :test_uploads do |t|
      t.string :filename

      t.timestamps null: false
    end
  end
end
