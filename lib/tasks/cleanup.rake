namespace :cleanup do
  desc "find user statistical scores"
  task :add_dummy_usernames => :environment do
    User.all.each do |u|
      rand = Random.rand(100000)
      if u.username.nil?
        u.username = "dummy-#{rand}"
        u.save
      end
    end
  end
end