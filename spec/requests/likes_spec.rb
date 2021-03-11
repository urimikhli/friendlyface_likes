require 'rails_helper'

RSpec.describe "/likes", type: :request do
  let(:like) { build(:like) }

  before :each do
    #create a set fixure of likes so we can test the aggregation in the response
    FactoryBot.create(:like, postId:4, user: 'bob')
    FactoryBot.create(:like, postId:1, user: 'jane')
    FactoryBot.create(:like, postId:2, user: 'jane')
    FactoryBot.create(:like, postId:4, user: 'jane')
    FactoryBot.create(:like, postId:1, user: 'georg')
    FactoryBot.create(:like, postId:3, user: 'georg')
    FactoryBot.create(:like, postId:1, user: 'lane')
    FactoryBot.create(:like, postId:2, user: 'lane')
    FactoryBot.create(:like, postId:3, user: 'lane')
    FactoryBot.create(:like, postId:1, user: 'lane')
    #
    #popular
    #[{1=>4}, {2=>2}, {3=>2}, {4=>2}]
    #JASON: "[{\"1\":4},{\"2\":2},{\"3\":2},{\"4\":2}]"
    #fan
    #[{"lane"=>4}, {"jane"=>3}, {"georg"=>2}, {"bob"=>1}]
    #JSON:  "[{\"lane\":4},{\"jane\":3},{\"georg\":2},{\"bob\":1}]"
  end

  #index might be useful so kep around
  skip "GET /index" do
    it "renders a successful response" do
      get likes_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /popular" do
    it "renders a successful response" do
      get popular_likes_path, as: :json
      expect(response).to be_successful
      expect(response.body).to match(a_string_including("[{\"1\":4},{\"2\":2},{\"3\":2},{\"4\":2}]"))
    end
  end

  describe "GET /fan" do
    it "renders a successful response" do
      get fan_likes_path, as: :json
      expect(response).to be_successful
      expect(response.body).to match(a_string_including("[{\"lane\":4},{\"jane\":3},{\"georg\":2},{\"bob\":1}]"))
    end
  end

  pending "GET /week" do
    skip "renders a successful response" do
      get week_likes_path, as: :json
      expect(response).to be_successful
      expect(response.body).to match(a_string_including("TODO"))
    end
  end
end