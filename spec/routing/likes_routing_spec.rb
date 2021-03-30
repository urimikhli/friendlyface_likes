require "rails_helper"

RSpec.describe LikesController, type: :routing do
  describe "routing" do

    it "routes to popular posts" do
      expect(get: "/likes/popular_posts").to route_to("likes#popular_posts")
    end

    it "routes to biggest fan" do
      expect(get: "/likes/biggest_fans").to route_to("likes#biggest_fans")
    end

    it "routes to popular_days" do
      expect(get: "/likes/popular_days").to route_to("likes#popular_days")
    end

    it "routes to like_streaks" do
      expect(get: "/likes/like_streaks").to route_to("likes#like_streaks")
    end
  end
end
