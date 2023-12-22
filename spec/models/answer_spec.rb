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

  describe '#mark_best' do
    let(:question) { create(:question) }
    let(:answer) { create(:answer, question:) }
    let!(:best_answer) { create(:answer, question:, best: true) }

    it 'marks as best' do
      answer.mark_best
      best_answer.reload

      expect(answer).to be_best
      expect(best_answer).to_not be_best
    end
  end
end
