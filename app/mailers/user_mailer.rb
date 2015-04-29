class UserMailer < ApplicationMailer
  default from: "mixr@mixr.com"

  def new_modification(email)
    mail(to: email, subject: "New Modification for your Recipe")
  end
end
