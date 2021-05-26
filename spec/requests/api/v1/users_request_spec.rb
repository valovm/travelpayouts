# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do

  let(:pages) { 2 }
  before do
    create_list(:user, ENV['PAGE_PER'].to_i * pages)
  end

  describe 'GET /api/v1/users' do

    before do
      get '/api/v1/users'
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.headers['Content-Type']).to eq('application/json; charset=utf-8') }

    it { expect(json_body['users'].keys.sort).to eq(%w[current_page pages count items is_last].sort) }

    it 'Check pagination' do
      expect(json_body['users']['items'].length).to eq(ENV['PAGE_PER'].to_i)
      expect(json_body['users']['pages']).to eq(pages)
    end
  end

  describe 'GET /api/v1/users/:id' do

    let(:user) { User.last }

    before do
      get "/api/v1/users/#{user.id}"
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.headers['Content-Type']).to eq('application/json; charset=utf-8') }

    it { expect(json_body['user']['id']).to eq(user.id) }
  end


  describe 'POST /api/v1/users' do

    context 'valid' do
      let(:valid_params) { {email: Faker::Internet.email, name: Faker::Name.name} }

      before do
        post '/api/v1/users', params: {user: valid_params}
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context 'not valid' do
      let(:not_valid_params) { {email: Faker::Name.name, name: Faker::Name.name} }

      before do
        post '/api/v1/users', params: {user: not_valid_params}
      end

      it { expect(response).to have_http_status(:bad_request) }
    end


    context 'email is not uniqueness' do
      let!(:email) { Faker::Internet.email }
      let(:params) { {email: email, name: Faker::Name.name} }

      before do
        create :user, email: email
        post '/api/v1/users', params: {user: params}
      end

      it { expect(response).to have_http_status(:bad_request) }
    end

  end





end
