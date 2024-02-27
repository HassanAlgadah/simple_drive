# frozen_string_literal: true

class SystemFileService < DriveService
  def service_store_data(id, decoded_blob)
    if Dir.glob("#{$file_path}#{id}").any?
      return { success: false, error: "the id already exists." }
    end

    File.open("#{$file_path}#{id}", 'wb') do |file|
      file.write(decoded_blob)
    end
    { success:true ,data: "File Has Been Save" }

  end

  def service_get_file_data(id, meta_data)
    path = "#{$file_path}#{id}"
    begin
      decoded_blob = File.open(path, "rb") { |file| file.read }
    rescue Errno::ENOENT => e
      { success:false ,error: "the id doesn't exist" }
    end

    blob = Base64.encode64(decoded_blob)
    meta_data = DriveMetaDatum.find_by(BlobId: id)
    { success: true, data: GetFileResponse.new(blob_id: id, blob: blob, size: meta_data.Size, created_at: meta_data.createdAt) }
  end
end
