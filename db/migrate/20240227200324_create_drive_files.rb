class CreateDriveFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :drive_files do |t|
      t.string :BlobId
      t.string :Blob
    end
  end
end
