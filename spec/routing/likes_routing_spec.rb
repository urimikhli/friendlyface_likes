require "rails_helper"

RSpec.describe LikesController, type: :routing do
  describe "routing" do

    it "routes to #popular" do
      expect(get: "/likes/popular").to route_to("likes#popular")
    end

    it "routes to fan" do
      expect(get: "/likes/fan").to route_to("likes#fan")
    end

    it "routes to week" do
      expect(get: "/likes/week").to route_to("likes#week")
    end
  end
end
