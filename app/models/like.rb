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

    def self.like_streaks
        days_with_likes=[]
        streakdays = []
        streakcount = 0
        streaks = []

        all_days = Like.group_by_day(:date).count
        all_days.keys.map{|x|
            if (all_days[x] > 0)
                days_with_likes.push({x=>all_days[x]})
            end
        }
        #puts "days_with_likes",days_with_likes
        #assumes days_with_likes is already sorted by date
        days_with_likes.map.with_index do |day, index|

            if (index == 0)
                next #skip to 2nd record
            end
            #check for more likes day over day
            #previous_day = i - 1
            if ( day.values.first > days_with_likes[index - 1].values.first )
                streakcount += 1
                streakdays.push( days_with_likes[index-1].keys.first ) if streakcount == 1
                streakdays.push( day.keys.first )
            else
                if (streakcount > 0)
                    streaks.push({
                        streakcount: streakcount,
                        dates: streakdays,
                    })
                end
               streakcount = 0
               streakdays = []
            end

        end
        #account for last record.
        if (streakcount > 0)
            streaks.push({
                streakcount: streakcount,
                dates: streakdays,
            })
        end

        #sort on streakcount
        streaks.sort_by{|x| x[:streakcount]}.reverse
    end
end
