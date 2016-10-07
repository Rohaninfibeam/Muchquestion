class AddColumnsToTestUpload < ActiveRecord::Migration
  def change
    add_column :test_uploads, :path, :string
    add_column :test_uploads, :external_file_name, :string
    add_column :test_uploads, :fname, :string
  end
end
