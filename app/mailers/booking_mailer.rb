class BookingMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.creation_confirmation.subject
  #
  def booking_confirmation(compagny, date, tour_name)
    @company_name = compagny.name
    @company_email = compagny.email
    @booked_date = date
    @tour_name = tour_name

    mail to: @company_email.to_s, subject: "Confirmation de reservation pour #{tour_name}"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.admins_notification.subject
  #
  def admins_notification(compagny, date, tour_name)
    @company_name = compagny.name
    @company_email = compagny.email
    @booked_date = date
    @tour_name = tour_name

    mail to: "jd.zaccariotto@gmail.com", subject: "Notification de reservation pour #{tour_name}"
  end
end
