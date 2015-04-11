class AddDatafileToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :datafile, :string
  end
end
