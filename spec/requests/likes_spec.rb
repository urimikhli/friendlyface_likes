require 'rails_helper'

RSpec.describe "/likes", type: :request do
  let(:like) { build(:like) }

  #index might be useful so kep around
  skip "GET /index" do
    it "renders a successful response" do
      get likes_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /popular" do
    it "renders a successful response" do
      get popular_likes_url, as: :json
      expect(response).to be_successful
    end
  end
  describe "GET /fan" do
    it "renders a successful response" do
      get fan_likes_url, as: :json
      expect(response).to be_successful
    end
  end
  describe "GET /week" do
    it "renders a successful response" do
      get week_likes_url, as: :json
      expect(response).to be_successful
    end
  end
end