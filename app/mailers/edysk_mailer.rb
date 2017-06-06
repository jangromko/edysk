require 'mail'

class EdyskMailer

  # tego nie ruszać!
  def initialize
    options = { :address              => "smtp.gmail.com",
                :port                 => 587,
                :user_name            => 'dyskrails@gmail.com',
                :password             => 'Szkielety',
                :authentication       => 'plain',
                :enable_starttls_auto => true  }

    Mail.defaults do
      delivery_method :smtp, options
    end
  end



  # receiver – adres mailowy odbiorcy
  # subject – temat wiadomości
  # content – treść wiadomości
  def send(receiver, subject, content)
    Mail.deliver do
      to receiver
      from 'Edysk'
      subject subject
      body content
    end
  end
end