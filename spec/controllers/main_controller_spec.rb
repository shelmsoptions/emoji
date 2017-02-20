require 'rails_helper'

RSpec.describe MainController, type: :controller do

  describe "GET #get_api" do
    it "returns http success" do
      get :get_api
      expect(response).to have_http_status(:success)
    end
  end

end
