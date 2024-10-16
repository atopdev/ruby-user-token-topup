require 'json'

class DataLoader
  def self.load_users(file_path)
    data = load_json(file_path)
    data.map { |user_data| User.new(user_data) }
  end

  def self.load_companies(file_path)
    data = load_json(file_path)
    data.map { |company_data| Company.new(company_data) }
  end

  private

  def self.load_json(file_path)
    JSON.parse(File.read(file_path))
  rescue Errno::ENOENT
    puts "Error: File not found - #{file_path}"
    exit
  rescue JSON::ParserError
    puts "Error: Invalid JSON format in #{file_path}"
    exit
  end
end
