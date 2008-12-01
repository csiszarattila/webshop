class ApplicationMailer < ActionMailer::Base
  

  def password_remember(email_address, name, new_password, sent_at = Time.now)
    subject    'Webshop jelszó visszaállítása'
    recipients email_address
    from       '<csiszar1@t-online.hu>'
    sent_on    sent_at
    
    body       :name => name, :new_password => new_password
  end

end
