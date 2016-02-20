require 'rails_helper'

RSpec.describe AdminController, type: :controller do

  describe "GET #admin_panel" do
    it "returns http success" do
      get :admin_panel
      expect(response).to have_http_status(:success)
    end
  end

end
