# company.rb
class Company
  attr_reader :id, :name, :top_up, :email_status, :users

  def initialize(company_data)
    @id = company_data['id']
    @name = company_data['name']
    @top_up = company_data['top_up'] || 0
    @email_status = company_data['email_status']
    @users = []
  end

  def add_user(user)
    @users << user
  end

  def top_up!
    sum = 0
    @users.select(&:active?).each do |user|
      user.top_up(@top_up)
      sum += @top_up
    end

    sum
  end

  def send_email!
    users_emailed = []
    users_not_emailed = []

    @users.select(&:active?).sort_by(&:last_name).each do |user|
      if user.send_email?(@email_status)
        users_emailed << user
      else
        users_not_emailed << user
      end
    end

    [users_emailed, users_not_emailed]
  end
end
