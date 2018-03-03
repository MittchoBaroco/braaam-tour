require 'rails_helper'

RSpec.describe "Sessions" do

  xit "signs user in and out" do
    user = Manager.create!(email: "user@example.org", password: "very-secret")
    user.confirm

    log_in user
    get authenticated_root_path
    expect(controller.current_user).to eq(user)

    log_out user
    get authenticated_root_path
    expect(controller.current_user).to be_nil
  end

end
