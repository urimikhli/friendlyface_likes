require 'rails_helper'

RSpec.describe Like, type: :model do

  describe "Like responds to popular_posts, biggest_fans, popular_days methods" do
    it "should respond to popular_posts method" do
      expect(Like).to respond_to(:popular_posts)
    end
    
    it "should respond to biggest_fans method" do
      expect(Like).to respond_to(:biggest_fans)
    end

    pending "should respond to popular_days method" do
      expect(Like).to respond_to(:popular_days)
    end


  end
end
