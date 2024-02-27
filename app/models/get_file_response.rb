# frozen_string_literal: true

class GetFileResponse
  attr_accessor :blob_id, :blob, :size, :created_at

  def initialize(blob_id: nil, blob: nil, size: 0, created_at: nil)
    @blob_id = blob_id
    @blob = blob
    @size = size
    @created_at = created_at
  end

  def to_json(*options)
    { id: @blob_id, data: blob, size: @size, created_at: @created_at }.to_json(*options)
  end
end