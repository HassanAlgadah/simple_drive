class CreateDriveMetaData < ActiveRecord::Migration[7.1]
  def change
    create_table :drive_meta_data do |t|
      t.bigint :Size
      t.datetime :createdAt
      t.string :BlobId
    end
  end
end
