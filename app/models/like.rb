class Like < ApplicationRecord

    def self.popular_posts
        Like.group(:postId).order(count_all: :desc).count.map { |k, v| [{k => v}] }.map{|x|x.first}
    end

    def self.biggest_fans
        Like.group(:user).order(count_all: :desc).count.map { |k, v| [{k => v}] }.map{|x|x.first}
    end

    def self.popular_days
        days_with_likes=[]
        likes_of_the_week= { #ruby doesnt autovivify
            "Sunday"    => 0,
            "Monday"    => 0,
            "Tuesday"   => 0,
            "Wednesday" => 0,
            "Thursday"  => 0,
            "Friday"    => 0,
            "Saturday"  => 0,
        }
        sorted_days=[]

        all_days = Like.group_by_day(:date).count
        all_days.keys.map{|x|
            if (all_days[x] > 0)
                days_with_likes.push({x=>all_days[x]})
            end
        }
        days_with_likes.map do |like|
            name = like.keys.first.strftime('%A')
            likes_of_the_week[name] += like.values.first
        end

        #[{},{}]
        likes_of_the_week.keys.map{|x| 
             sorted_days.push({x=>likes_of_the_week[x]})
        }
        return sorted_days.sort_by!(&:values).reverse!
    end
end
