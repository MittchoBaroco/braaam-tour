class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # set_locale MUST be before authentication to work unauthenticated
  before_action :set_locale
  before_action :authenticate_manager!

   def default_url_options(options={})
     logger.debug "default_url_options is passed options: #{options.inspect}\n"
     { locale: I18n.locale }
   end

  protected

   def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [
         :name,
         :company_address_line1,
         :company_address_line2,
         :company_country,
         :company_npa,
         :company_city,
         :reference_person_full_name
       ]
     )
   end

  private
    # use session to remember locale preference when user returns
    def set_locale
      I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
      session[:locale] = I18n.locale
      # http://www.xyzpub.com/en/ruby-on-rails/3.2/i18n_mehrsprachige_rails_applikation.html
      Rails.application.routes.default_url_options[:locale]= I18n.locale
    end
    # or without adding locale to session
    # def set_locale
    #   I18n.locale = params[:locale] || I18n.default_locale
    #   Rails.application.routes.default_url_options[:locale]= I18n.locale
    # end

end
