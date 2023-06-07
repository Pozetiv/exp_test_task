require 'rails_helper'

RSpec.describe ExperientUsers::GetService do
  before { load Rails.root.join('db', 'seeds.rb') }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:exp_price) { Experiment.find_by(name: 'price') }
  let(:exp_button) { Experiment.find_by(name: 'button_color') }
  subject { described_class.call(user: user1) }

  describe do
    context 'if present user with exp return old version' do
      let!(:user_exp1) do
        ExperientUser.create(user: user1, experiment: exp_price, current_value: exp_price.conditions.keys.first)
      end

      it do
        expect(subject.success).to eq({ exp_price.name => exp_price.conditions.keys.first})
        expect { subject }.to change { ExperientUser.count }.by(0)
      end
    end

    context 'with presented ExperientUser' do
      let(:user3) { create(:user) }
      let!(:user_exp3) do
        ExperientUser.create(user: user3, experiment: exp_price, current_value: exp_price.conditions.keys.first)
      end
      let!(:user_exp2) do
        ExperientUser.create(user: user2, experiment: exp_button, current_value: exp_button.conditions.keys.first)
      end

      it 'take next exp' do
        expect { subject }.to change { ExperientUser.count }.by(1)
        expect(subject.success.keys.first).to eq(exp_price.name)  # take exp not button, use next exp
      end
    end

    context 'clear db - first time' do
      it do
        expect { subject }.to change { ExperientUser.count }.by(1)
        expect(subject.success).to eq({ Experiment.first.name => Experiment.first.conditions.keys.first })
      end
    end

    context 'user created before exp' do
      before { user1.update(created_at: exp_price.created_at - 1.hours) }

      it { expect(subject).to eq(nil) }
    end
  end
end
