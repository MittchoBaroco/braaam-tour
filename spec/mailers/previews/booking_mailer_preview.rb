# Preview all emails at http://localhost:3000/rails/mailers/booking_mailer
class BookingMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/creation_confirmation
  def creation_confirmation
    BookingMailerMailer.creation_confirmation
  end

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/admins_notification
  def admins_notification
    BookingMailerMailer.admins_notification
  end

end
