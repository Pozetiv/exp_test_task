require 'rails_helper'

RSpec.describe 'Api/v1/ExperientUsers', type: :request do
  before { load Rails.root.join('db', 'seeds.rb') }

  describe '#create' do
    it do
      post '/api/v1/experient_users', headers: { 'Device-Token': SecureRandom.uuid }

      expect(response).to have_http_status(:ok)
      expect(JSON(response.body)).not_to eq({})
    end
  end
end
