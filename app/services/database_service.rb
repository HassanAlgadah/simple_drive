# frozen_string_literal: true
require 'base64'

class DatabaseService < DriveService
  def service_store_data(id, decoded_blob)
    DriveFile.create(BlobId: id, Blob: Base64.encode64(decoded_blob))
    { success:true ,data: "File Has Been Save" }
  end

  def service_get_file_data(id, meta_data)
    file = DriveFile.find_by(BlobId: id)
    { success: true, data: GetFileResponse.new(blob_id: id,blob: file.Blob,size: meta_data.Size,created_at: meta_data.createdAt) }

  end
end
