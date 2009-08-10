Given /An user "([^\"]*)" exists with password "([^\"]*)"/i do |login, password|
  @user = Factory.create(:user, 
    :login => login,
    :password => password,
    :password_confirmation => password)
end

Given /An user "([^\"]*)" exists with email "([^\"]*)"/i do |login, email|
  @user = Factory.create(:user, 
    :login => login,
    :email => email)
end

Given /I am logged in/i do
  @user = Factory.create(:user)
  visit "/compte/login"
  fill_in "login", :with => @user.login
  fill_in "password", :with => @user.password
  click_button "Log in"
end

