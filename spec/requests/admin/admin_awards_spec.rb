require 'rails_helper'

RSpec.describe "Admin::Awards", type: :request do
  xdescribe "GET /admin_awards" do
    it "admin_awards#index" do
      get admin_awards_path
      expect(response).to have_http_status(200)
    end
  end
end
