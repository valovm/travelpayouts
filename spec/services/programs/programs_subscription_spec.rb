# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Programs::Subscriptions' do

  let!(:programs_service) { Programs::Subscriptions.new(program, user) }
  let!(:user) { create :user }
  let!(:program) { create :program }

  describe 'Programs::Subscription' do
    it do
      expect(program.count_of_users).to eq(0)
      expect { programs_service.unsubscribe }.to raise_error BaseError
      expect(programs_service.subscribe).to be_truthy
      expect(program.count_of_users).to eq(1)
      expect { programs_service.subscribe }.to raise_error BaseError
      expect(programs_service.unsubscribe).to be_truthy
      expect(program.count_of_users).to eq(0)
      expect { programs_service.unsubscribe }.to raise_error BaseError
      expect(program.count_of_users).to eq(0)
    end
  end
end
