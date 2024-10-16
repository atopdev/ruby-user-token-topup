class User
  attr_reader :id, :first_name, :last_name, :email, :company_id, :tokens

  def initialize(user_data)
    @id = user_data['id']
    @first_name = user_data['first_name']
    @last_name = user_data['last_name']
    @company_id = user_data['company_id']
    @email = user_data['email']
    @email_status = user_data['email_status']
    @active_status = user_data['active_status']
    @tokens = user_data['tokens'] || 0
  end

  def full_name
    "#{last_name}, #{first_name}"
  end

  def active?
    @active_status
  end

  def top_up(tokens)
    @tokens += tokens
  end

  def send_email?(company_email_status)
    @email_status && company_email_status
  end
end
