require 'net/http'
require 'uri'
require 'base64'
require 'openssl'

class AmazonService < DriveService
  def service_store_data(id, decoded_blob)
    begin
      bucket = ENV['BUCKET']
      object_key = id
      access_key_id = ENV['ACCESS_KEY']
      secret_access_key = ENV['SECRET_ACCESS_KEY']
      endpoint = ENV['DIGITALOCEAN_ENDPOINT']
      content_type = "application/octet-stream"

      uri = URI("https://#{bucket}.#{endpoint}/#{CGI.escape(object_key)}")

      date = Time.now.utc.strftime("%a, %d %b %Y %H:%M:%S GMT")

      string_to_sign = "PUT\n\n#{content_type}\n#{date}\n/#{bucket}/#{CGI.escape(object_key)}"
      signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), secret_access_key, string_to_sign)).strip

      request = Net::HTTP::Put.new(uri)
      request['Date'] = date
      request['Authorization'] = "AWS #{access_key_id}:#{signature}"
      request['Content-Type'] = content_type
      request.body = decoded_blob
      request.content_length = decoded_blob.bytesize

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
      case response
      when Net::HTTPSuccess then
        puts "File Has Been Save"
        return { success:true ,data: "File Has Been Save" }
      else
        raise "Failed to download file: #{response.code} #{response.message}"
      end
      puts response.code
      puts response.body
    rescue => e
      puts e.message
    end
  end
  def service_get_file_data(id, meta_data)
    bucket = ENV['BUCKET']
    object_key = id
    access_key_id = ENV['ACCESS_KEY']
    secret_access_key = ENV['SECRET_ACCESS_KEY']
    endpoint = ENV['DIGITALOCEAN_ENDPOINT']

    date = Time.now.utc.strftime("%a, %d %b %Y %H:%M:%S GMT")

    canonical_string = "GET\n\n\n#{date}\n/#{bucket}/#{CGI.escape(object_key)}"

    signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), secret_access_key, canonical_string)).strip

    auth_header = "AWS #{access_key_id}:#{signature}"

    uri = URI("https://#{bucket}.#{endpoint}/#{CGI.escape(object_key)}")

    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Get.new uri
      request['Date'] = date
      request['Authorization'] = auth_header
      response = http.request request

      case response
      when Net::HTTPSuccess then
        blob = Base64.encode64(response.body)
        meta_data = DriveMetaDatum.find_by(BlobId: id)
        { success: true, data: GetFileResponse.new(blob_id: id,blob: blob.Blob,size: meta_data.Size,created_at: meta_data.createdAt) }
      else
        raise "Failed to get file: #{response.code} #{response.message}"
      end
    end
  end
end

