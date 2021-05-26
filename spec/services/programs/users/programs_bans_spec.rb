# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Programs::Users::Bans' do

  let!(:bans_service) { Programs::Users::Bans.new(program, user) }
  let!(:user) { create :user }
  let!(:program) { create :program }

  describe 'Programs::Users::Subscription' do
    it do
      expect { bans_service.out_ban }.to raise_error BaseError
      expect(bans_service.in_ban).to be_truthy
      expect(bans_service.out_ban).to be_truthy
      expect { bans_service.out_ban }.to raise_error BaseError
      expect(bans_service.in_ban).to be_truthy
      expect { bans_service.in_ban }.to raise_error BaseError
    end
  end
end
