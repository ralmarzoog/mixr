class UserMailer < ApplicationMailer
  default from: "mixr@mixr.com"

  def new_modification(email, recipe)
    @recipe = recipe
    @link = "https://fathomless-eyrie-3707.herokuapp.com/recipes/" + recipe.id
    subject = "A new modification for #{recipe.title} was added to Mixr!"
    mail(to: email, subject: subject)
  end
end
