# Preview all emails at http://localhost:3000/rails/mailers/booking_mailer
class BookingMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/booking_confirmation
  def booking_confirmation
    company = FactoryBot.build(:company)
    tour_name = "Mr Banana"
    date = Date.today

    BookingMailer.booking_confirmation(company, date, tour_name)
  end

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/admins_notification
  def admins_notification
    company = FactoryBot.build(:company)
    tour_name = "Mr Banana"
    date = Date.today

    BookingMailer.admins_notification(company, date, tour_name)
  end

end
