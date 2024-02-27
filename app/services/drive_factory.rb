# frozen_string_literal: true

class DriveFactory
  def self.create_drive(type)
    case type
    when '1'
      AmazonService.new
    when '2'
      DatabaseService.new
    when '3'
      SystemFileService.new
    else
      raise "Unknown Drive type: #{type}"
    end
  end
end

