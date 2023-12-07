# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#author?' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }

    it do
      authored_resource = double(author: user)

      expect(user.author?(authored_resource)).to be_truthy
    end

    it do
      resource = double(author: another_user)

      expect(user.author?(resource)).to be_falsey
    end

    it { expect(user.author?(nil)).to be_falsey }
  end
end
