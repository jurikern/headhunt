if Rails.env.development? || Rails.env.test?
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.default_url_options[:host] = 'localhost:3000'
elsif Rails.env.production?
  ActionMailer::Base.raise_delivery_errors = false
  ActionMailer::Base.default_url_options[:host] = 'headhunt.ee'
end

ActionMailer::Base.perform_deliveries = true

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = 
{
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "headhunt.development@gmail.com",
  :password             => "headhunt696",
  :authentication       => "plain",
  :enable_starttls_auto => true  
}