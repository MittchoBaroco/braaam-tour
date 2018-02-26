require 'rails_helper'

RSpec.describe "Tours", type: :request do
  describe "GET /tours" do
    it "tours#index" do
      get tours_path
      expect(response).to have_http_status(200)
    end
  end
end
