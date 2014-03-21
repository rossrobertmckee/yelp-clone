class NotificationMailer < ActionMailer::Base
  default from: "no-reply@nomster.herokuapp.com"

  def comment_added(comment)
    @place = comment.place
    @comment = comment
    addresses = [comment.place.user.email]
    mail(:to => addresses, :from => 'ken@my-awesome-app.com',
      :subject => 'A new comment has been added to the application')
  end
end
