class NotificationMailer < ActionMailer::Base
  default from: "no-reply@my-awesome-app.com"

  def place_added(place)
    @place = place
    addresses = User.admin.collect {|a| a.email }
    mail(:to => addresses, :from => 'ken@my-awesome-app.com',
      :subject => 'A new place has been added to the application')
  end
end
