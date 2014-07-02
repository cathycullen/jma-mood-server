require 'action_mailer'

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.view_paths= File.dirname(__FILE__)

  class Mailer < ActionMailer::Base

    def send_password_link(user)
      @user = user
    
      ActionMailer::Base.smtp_settings = {
        :address   => ENV['DEV_ADDRESS'],
        :port      => ENV['DEV_PORT'],
        :domain    => ENV['DEV_DOMAIN'],
        :authentication => :"login",
        :user_name      => ENV['DEV_USER'],
        :password       => ENV['DEV_PASS'],
        :enable_starttls_auto => true,
      }
      
      puts "sending password reminder to: #{@user.email} from: #{ENV['DEV_FROM_ADDRESS']}"
      mail( 
        :to      =>  @user.email,
        :from    => ENV['DEV_FROM_ADDRESS'],
        :subject => "JMA Moodminder Information ",
      ) do |format|
        format.html
        format.text
      end
    end

     def send_welcome_email(user)
      @user = user
    
      ActionMailer::Base.smtp_settings = {
        :address   => ENV['DEV_ADDRESS'],
        :port      => ENV['DEV_PORT'],
        :domain    => ENV['DEV_DOMAIN'],
        :authentication => :"login",
        :user_name      => ENV['DEV_USER'],
        :password       => ENV['DEV_PASS'],
        :enable_starttls_auto => true,
      }
      
      puts "sending welcome email to: #{@user.email} from: #{ENV['DEV_FROM_ADDRESS']}"
      mail( 
        :to      =>  @user.email,
        :from    => ENV['DEV_FROM_ADDRESS'],
        :subject => "Welcome to Moodminder",
      ) do |format|
        format.html
        format.text
      end
    end
    
    def to_jma_support(name, email)
      @name = name
      @email = email
    
      ActionMailer::Base.smtp_settings = {
        :address   => ENV['DEV_ADDRESS'],
        :port      => ENV['DEV_PORT'],
        :domain    => ENV['DEV_DOMAIN'],
        :authentication => :"login",
        :user_name      => ENV['DEV_USER'],
        :password       => ENV['DEV_PASS'],
        :enable_starttls_auto => true,
      }
      puts "sending confirm to jma support team at this address:  #{ENV['JMA_SUPPORT_EMAIL']} from: #{ENV['JMA_FROM_ADDRESS']}"
      mail( 
        :to      => ENV['JMA_SUPPORT_EMAIL'],
        :from    => ENV['DEV_FROM_ADDRESS'],
        :subject => "JMA Mood Minder Stuff",
      ) do |format|
        format.html
        format.text
      end
    end
    
     def submit_test_email(name, email)
      @name = name
      @email = email
    
      begin
       ActionMailer::Base.smtp_settings = {
        :address   => ENV['JMA_ADDRESS'],
        :port      => ENV['JMA_PORT'],
        :domain    => ENV['JMA_DOMAIN'],
        :authentication => :"login",
        :user_name      => ENV['JMA_USER'],
        :password       => ENV['JMA_PASS'],
        :enable_starttls_auto => true,
      }
      puts "settings #{ActionMailer::Base.smtp_settings}"
      mail( 
        :to      => ENV['DEVELOPER_EMAIL'],
        :from    => ENV['JMA_FROM_ADDRESS'],
        :subject => "Mood Minder Thank You For Your Registering",
      ) do |format|
        format.html
        format.text
      end
      
       rescue Exception => e
      puts "rescue caught submit_test_email #{e.message}"
      puts e.backtrace
    end
    
    end
    
  def get_email (email)   
    retval = email
    if ENV['RACK_ENV'] == 'development' then
      retval = ENV['DEVELOPER_EMAIL']
    end
    puts "get_email retval #{retval}"
    retval
  end
end