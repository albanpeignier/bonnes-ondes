class UserNotifier < ActionMailer::Base

  default_url_options[:host] = 'bonnes-ondes.fr'
#  ActionMailer::Base.smtp_settings[:address] = "electronet.org"
#  ActionMailer::Base.smtp_settings[:user_name] = "flow@electronet.org@electronet.org"
#  ActionMailer::Base.smtp_settings[:password] = "xxxxxxxxx"
#  ActionMailer::Base.smtp_settings[:authentication] = :plain
#  ActionMailer::Base.delivery_method = :smtp
  

  def new_password(user, new_password)
    setup_email(user)
    @subject += "[AudioBank] Votre mot de passe"
    @body[:new_password] = new_password
  end

  def signup_notification(user)
    setup_email(user)
    @subject    += 'Activation de votre compte Bonnes-Ondes'
    @body[:url]  = url_for(:controller => 'account', :action => 'activate', :code => user.activation_code)
  end

  def activation(user)
    setup_email(user)
    @subject    += 'Bienvenue'
    @body[:url]  = url_for(:controller => 'account', :action => 'login')
  end

  protected
  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "Bonnes-Ondes <root@tryphon.org>"
    @subject     = "[Bonnes Ondes] "
    @sent_on     = Time.now
    @body[:user] = user
  end
end
