# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Api::V1::Programs', type: :request do

  let(:pages) { 2 }
  before do
    create_list(:program, ENV['PAGE_PER'].to_i * pages)
  end

  describe 'GET /api/v1/programs' do

    before do
      get '/api/v1/programs'
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.headers['Content-Type']).to eq('application/json; charset=utf-8') }

    it { expect(json_body['programs'].keys.sort).to eq(%w[current_page pages count items is_last].sort) }

    it 'Check pagination' do
      expect(json_body['programs']['items'].length).to eq(ENV['PAGE_PER'].to_i)
      expect(json_body['programs']['pages']).to eq(pages)
    end
  end

  xdescribe 'GET /api/v1/programs/:id' do

    let(:program) { Program.last }

    before do
      get "/api/v1/programs/#{program.id}"
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.headers['Content-Type']).to eq('application/json; charset=utf-8') }

    it { expect(json_body['program']['id']).to eq(program.id) }
  end
end
