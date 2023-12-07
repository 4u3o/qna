# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'associations' do
    it { should belong_to :question }
    it { should belong_to :author }
  end

  describe 'validations' do
    it { should validate_presence_of :body }
  end

  describe '#is_author?' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }

    it do
      authored_resource = double(author: user)

      expect(user.is_author?(authored_resource)).to be_truthy
    end

    it do
      resource = double(author: another_user)

      expect(user.is_author?(resource)).to be_falsey
    end

    it { expect(user.is_author?(nil)).to be_falsey }
  end
end
