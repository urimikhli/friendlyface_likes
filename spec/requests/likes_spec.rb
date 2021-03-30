require 'rails_helper'

RSpec.describe "/likes", type: :request do
  let(:like) { build(:like) }

  before :each do
    #create a set fixure of likes so we can test the aggregation in the response
    FactoryBot.create(:like, postId:4, user: 'bob', date: Date.new(2015,1,1))
    FactoryBot.create(:like, postId:1, user: 'jane', date: Date.new(2015,1,1))
    FactoryBot.create(:like, postId:1, user: 'georg', date: Date.new(2015,1,2))
    FactoryBot.create(:like, postId:1, user: 'lane', date: Date.new(2015,1,2))
    FactoryBot.create(:like, postId:2, user: 'jane', date: Date.new(2015,1,8))
    FactoryBot.create(:like, postId:3, user: 'georg', date: Date.new(2015,1,9))
    FactoryBot.create(:like, postId:3, user: 'lane', date: Date.new(2015,1,11))
    FactoryBot.create(:like, postId:2, user: 'lane', date: Date.new(2015,1,13))
    FactoryBot.create(:like, postId:4, user: 'jane', date: Date.new(2015,1,15))
    FactoryBot.create(:like, postId:1, user: 'lane', date: Date.new(2015,1,20))
    #
    #popular
    #[{1=>4}, {2=>2}, {3=>2}, {4=>2}]
    #JASON: "[{\"1\":4},{\"2\":2},{\"3\":2},{\"4\":2}]"
    #fan
    #[{"lane"=>4}, {"jane"=>3}, {"georg"=>2}, {"bob"=>1}]
    #JSON:  "[{\"lane\":4},{\"jane\":3},{\"georg\":2},{\"bob\":1}]"
    #week
    #[{"Thursday"=>4}, {"Friday"=>3}, {"Tuesday"=>2}, {"Sunday"=>1}, {"Saturday"=>0}, {"Wednesday"=>0}, {"Monday"=>0}]
    #JSON: "[{\"Thursday\":4},{\"Friday\":3},{\"Tuesday\":2},{\"Sunday\":1},{\"Saturday\":0},{\"Wednesday\":0},{\"Monday\":0}]"
    #streaks
    # sorted on streakcount
    # [ { dates: [streakdates],
    #     streakcount: num
    #   }, ...
    # ]
    #[{\"streakcount\":3,\"dates\":[\"2015-01-02\",\"2015-01-08\",\"2015-01-09\",\"2015-01-10\"]},{\"streakcount\":2,\"dates\":[\"2015-02-08\",\"2015-02-09\",\"2015-02-10\"]}]

  end

  #index might be useful so kep around
  skip "GET /index" do
    it "renders a successful response" do
      get likes_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /popular_posts" do
    it "renders a successful response" do
      get popular_posts_likes_path, as: :json
      expect(response).to be_successful
      expect(response.body).to match(a_string_including("[{\"1\":4},{\"2\":2},{\"3\":2},{\"4\":2}]"))
    end
  end

  describe "GET /biggest_fans" do
    it "renders a successful response" do
      get biggest_fans_likes_path, as: :json
      expect(response).to be_successful
      expect(response.body).to match(a_string_including("[{\"lane\":4},{\"jane\":3},{\"georg\":2},{\"bob\":1}]"))
    end
  end

  describe "GET /popular_days" do
    it "renders a successful response" do
      get popular_days_likes_path, as: :json
      expect(response).to be_successful
      expect(response.body).to match(a_string_including("[{\"Thursday\":4},{\"Friday\":3},{\"Tuesday\":2},{\"Sunday\":1},{\"Saturday\":0},{\"Wednesday\":0},{\"Monday\":0}]"))
    end
  end

  describe "GET /like_streaks" do
    #show streak 
    before :each do
      FactoryBot.create(:like, postId:2, date: Date.new(2015,2,8))
      FactoryBot.create(:like, postId:2, date: Date.new(2015,2,9))
      FactoryBot.create(:like, postId:2, date: Date.new(2015,2,9))
      FactoryBot.create(:like, postId:2, date: Date.new(2015,2,10))
      FactoryBot.create(:like, postId:2, date: Date.new(2015,2,10))
      FactoryBot.create(:like, postId:2, date: Date.new(2015,2,10))
    end
    it "renders a successful response" do
      get like_streaks_likes_path, as: :json
      expect(response).to be_successful
      expect(response.body).to match(a_string_including("[{\"streakcount\":2,\"dates\":[\"2015-02-08\",\"2015-02-09\",\"2015-02-10\"]}]"))
    end
  end
end