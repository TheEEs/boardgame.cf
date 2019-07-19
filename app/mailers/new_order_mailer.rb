class NewOrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.new_order_mailer.index.subject
  #
  def index
    @greeting = "Bạn có một order mới"

    mail to: params[:email], subject: "Bạn có một order mới"
  end
end
