require 'rails_helper'

RSpec.describe "Admin::Managers", type: :request do
  describe "GET /admin_managers" do
    it "admin_managers#index" do
      get admin_managers_path
      expect(response).to have_http_status(200)
    end
  end
end
