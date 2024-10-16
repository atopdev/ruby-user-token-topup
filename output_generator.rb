class OutputGenerator
  INDENT = "\t".freeze

  def self.format_with_indent(str, n = 0)
    "#{INDENT * n}#{str}"
  end

  def self.generate_output(companies, output_file)
    File.open(output_file, 'w') do |file|
      # Add start empty line
      file.puts "\n"

      companies.sort_by(&:id).each do |company|
        total_top_up = company.top_up!
        users_emailed, users_not_emailed = company.send_email!

        # Skip if there is no users in the company
        next if users_emailed.length + users_not_emailed.length == 0

        file.puts format_with_indent("Company Id: #{company.id}", 1)
        file.puts format_with_indent("Company Name: #{company.name}", 1)

        file.puts format_with_indent("Users Emailed:", 1)
        users_emailed.each do |user|
          file.puts format_with_indent("#{user.full_name}, #{user.email}", 2)
          file.puts format_with_indent("Previous Token Balance, #{user.tokens - company.top_up}", 3)
          file.puts format_with_indent("New Token Balance #{user.tokens}", 3)
        end

        file.puts format_with_indent("Users Not Emailed:", 1)
        users_not_emailed.each do |user|
          file.puts format_with_indent("#{user.full_name}, #{user.email}", 2)
          file.puts format_with_indent("Previous Token Balance, #{user.tokens - company.top_up}", 3)
          file.puts format_with_indent("New Token Balance #{user.tokens}", 3)
        end

        file.puts format_with_indent("Total amount of top ups for #{company.name}: #{total_top_up}", 2)
        file.puts "\n"
      end
    end
  end
end
