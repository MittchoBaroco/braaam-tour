class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :authenticate_manager!

   def default_url_options(options={})
     logger.debug "default_url_options is passed options: #{options.inspect}\n"
     { locale: I18n.locale }
   end

  private
    # use session to remember locale preference when user returns
    def set_locale
      I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
      session[:locale] = I18n.locale
      Rails.application.routes.default_url_options[:locale]= I18n.locale
    end
    # or without adding locale to session
    # def set_locale
    #   I18n.locale = params[:locale] || I18n.default_locale
    #   Rails.application.routes.default_url_options[:locale]= I18n.locale
    # end

end
