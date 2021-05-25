# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Api::V1::Users::Programs', type: :request do

  let!(:user) { create :user }
  let!(:program) { create :program }
  let!(:program2) { create :program }


  describe '/api/v1/users/:user_id/programs' do
    let!(:path) { "/api/v1/users/#{user.id}/programs" }
    let!(:params) { { subscribe: { program_id: program.id } } }
    let!(:params2) { { subscribe: { program_id: program2.id } } }

    it 'lifecycle' do
      # List
      get path
      expect(json_body['programs']['items'].length).to eq(0)
      # Subscribe
      post path, params: params
      expect(response).to have_http_status(:ok)
      # Subscribe
      post path, params: params
      expect(response).to have_http_status(400)
      # Subscribe
      post path, params: params2
      expect(response).to have_http_status(:ok)
      # Unsubscribe
      delete "#{path}/#{program.id}"
      expect(response).to have_http_status(:ok)
      # Unsubscribe
      delete "#{path}/#{program.id}"
      expect(response).to have_http_status(400)
      # Subscribe
      post path, params: params
      expect(response).to have_http_status(:ok)
      # List
      get path
      expect(json_body['programs']['items'].length).to eq(2)
    end
  end


end
