# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Programs::Subscription' do

  let!(:programs_service) { Programs::Subscription.new }
  let!(:user) { create :user }
  let!(:program) { create :program }

  describe 'Programs::Subscription' do
    it do
      expect { programs_service.unsubscribe(program, user) }.to raise_error BaseError
      expect(programs_service.subscribe(program, user)).to be_truthy
      expect { programs_service.subscribe(program, user) }.to raise_error BaseError
      expect(programs_service.unsubscribe(program, user)).to be_truthy
      expect { programs_service.unsubscribe(program, user) }.to raise_error BaseError
    end
  end
end
