# Preview all emails at http://localhost:3000/rails/mailers/booking_mailer
class BookingMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/creation_confirmation
  def creation_confirmation
    company = FactoryBot.build(:company)
    tour_name = "Mr Banana"
    date = Date.today

    BookingMailer.creation_confirmation(company, date, tour_name)
  end

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/admins_notification
  def admins_notification
    company = FactoryBot.build(:company)
    tour_name = "Mr Banana"
    date = Date.today

    BookingMailer.admins_notification
  end

end
