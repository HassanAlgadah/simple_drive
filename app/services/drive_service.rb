# frozen_string_literal: true

class DriveService
  def store_data(id, blob)
    # save metadata
    if DriveMetaDatum.exists?(BlobId: id)
      { success: false, error: "the id does exists already." }

    else
      begin
        decoded_blob = Base64.decode64(blob)
        result = service_store_data(id, decoded_blob)

        DriveMetaDatum.create(Size: decoded_blob.bytesize, createdAt: DateTime.now,BlobId:id )
        result
      rescue => e
        { success: false, error: "Error occurred: Base64 can't be decoded" }
      end
    end
  end


  def get_file_data(id)
    meta_data = DriveMetaDatum.find_by(BlobId: id)
    if meta_data.nil?
      { success: false, error: "The ID does not exist." }
    else
      service_get_file_data(id, meta_data)
    end
  end

  protected
  def service_store_data(id, decoded_blob)
    raise 'not implemented'
  end

  protected
  def service_get_file_data(id, meta_data)
    raise 'not implemented'
  end
end

