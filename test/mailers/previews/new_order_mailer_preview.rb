# Preview all emails at http://localhost:3000/rails/mailers/new_order_mailer
class NewOrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/new_order_mailer/index
  def index
    NewOrderMailer.index
  end

end
