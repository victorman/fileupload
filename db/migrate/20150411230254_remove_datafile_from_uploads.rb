class RemoveDatafileFromUploads < ActiveRecord::Migration
  def change
    remove_column :uploads, :datafile
  end
end
