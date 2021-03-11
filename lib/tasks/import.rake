require 'csv'

namespace :friendface_likes do
    task :importcsv_by_file, [:filename] => :environment do |t, args|
        file = Rails.root + args[:filename]

        csv_headers = %w(post-id user date)

        CSV.foreach(file, :headers => true) do |row|
            like = Like.new()
            like.postId = row['post-id']
            like.user = row['user']
            like.date = row['date']
            like.save
        end
    end 
end