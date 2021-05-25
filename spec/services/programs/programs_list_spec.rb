# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Programs' do

  let!(:programs) { Programs::List.new }

  before do
    create(:program, title: 'HelloHihello')
    create(:program, title: 'Hello world')
    create(:program, title: 'Hello, world')
    create(:program, title: 'world, HELLO beautiful')
    create(:program, title: 'Hi, hello man')
    create(:program, title: "What's hell are u doing?")
    create(:program, title: 'Hel, alo man')
    create(:program, title: 'Robocop more strong then terminator')
    create(:program, title: 'Fuck ae, ladis')
    create(:program, title: 'Freedom for Anjela Davis')
  end

  describe 'Programs::List' do
    let(:result) { programs.call }
    it { expect(result.size).to eq(10) }
  end

  describe 'Programs::List with term' do
      it { expect(programs.call('hello').size).to eq(5) }
      it { expect(programs.call('Hello').size).to eq(5) }
      it { expect(programs.call('HELLO').size).to eq(5) }
      it { expect(programs.call('HELL').size).to eq(6) }
      it { expect(programs.call('FUCK').size).to eq(1) }
      it { expect(programs.call('ALOHA').size).to eq(0) }
  end
end
