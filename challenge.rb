# challenge.rb
require_relative 'user'
require_relative 'company'
require_relative 'data_loader'
require_relative 'output_generator'

class ChallengeApp
  def initialize(users_file, companies_file, output_file)
    @users_file = users_file
    @companies_file = companies_file
    @output_file = output_file
  end

  def run
    users = DataLoader.load_users(@users_file)
    companies = DataLoader.load_companies(@companies_file)

    # Create a hash map for companies by their id
    companies_map = companies.each_with_object({}) { |company, hash| hash[company.id] = company }

    users.each do |user|
      company = companies_map[user.company_id]
      next unless company # Skip users whose company is not listed

      company.add_user(user)
    end

    OutputGenerator.generate_output(companies, @output_file)
    puts "Output successfully written to #{@output_file}"
  end
end

if __FILE__ == $0
  if ARGV.size != 3
    puts "Usage: ruby challenge.rb users.json companies.json output.txt"
    exit
  end

  users_file, companies_file, output_file = ARGV
  app = ChallengeApp.new(users_file, companies_file, output_file)
  app.run
end
