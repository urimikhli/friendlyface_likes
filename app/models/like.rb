class Like < ApplicationRecord

    def self.popular_posts
        Like.group(:postId).order(count_all: :desc).count.map { |k, v| [{k => v}] }.map{|x|x.first}
    end

    def self.biggest_fans
        Like.group(:user).order(count_all: :desc).count.map { |k, v| [{k => v}] }.map{|x|x.first}
    end
end
