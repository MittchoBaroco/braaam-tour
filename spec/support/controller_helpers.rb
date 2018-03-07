# spec/support/controller_helpers.rb

# sign_in helper for devise access to controllers
# https://github.com/plataformatec/devise/wiki/how-to:-stub-authentication-in-controller-specs
module ControllerHelpers
  # def sign_in( user = FactoryBot.create(:manager) )
  def sign_in( user )
    if user.nil? or user.empty?
      allow(request.env['warden']).to receive(:authenticate!).
                                      and_throw(:warden, {:scope => :manager})
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end
end
