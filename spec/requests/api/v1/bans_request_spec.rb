# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Api::V1::Users::Programs', type: :request do

  let!(:user) { create :user }
  let!(:program) { create :program }
  let!(:program2) { create :program }

  describe '/api/v1/bans' do
    let!(:path) { '/api/v1/bans' }
    let!(:params) { {ban: {program_id: program.id, user_id: user.id}} }
    let!(:params2) { {ban: {program_id: program2.id, user_id: user.id}} }

    it 'lifecycle' do
      # Ban
      post path, params: params
      expect(response).to have_http_status(:ok)
      # Ban
      post path, params: params
      expect(response).to have_http_status(400)
      # Ban
      post path, params: params2
      expect(response).to have_http_status(:ok)
      # UnBan
      delete path, params: params
      expect(response).to have_http_status(:ok)
      # UnBan
      delete path, params: params
      expect(response).to have_http_status(400)
      # Ban
      post path, params: params
      expect(response).to have_http_status(:ok)
    end
  end


end
