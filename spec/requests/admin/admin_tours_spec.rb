require 'rails_helper'

RSpec.describe "Admin::Tours", type: :request do
  xdescribe "GET /admin_tours" do
    it "admin_tours#index" do
      get admin_tours_path
      expect(response).to have_http_status(200)
    end
  end
end
