require "faker"

puts "Destroy Likes"
Like.destroy_all
puts "Destroy Tweets"
Tweet.destroy_all
puts "Destroy Users"
User.destroy_all

puts "Seeding User"
User.destroy_all
User.create(username: "admin", name: "Admin", email: "admin@mail.com", password: "supersecret", role: "admin")
users = User.create([
  {username: "user1", name: "User1",email: "user1@mail.com", password: "letmein"},
  {username: "user2", name: "User2",email: "user2@mail.com", password: "letmein"},
  {username: "user3", name: "User3",email: "user3@mail.com", password: "letmein"},
  {username: "user4", name: "User4",email: "user4@mail.com", password: "letmein"}])
cover_url = Faker::Avatar.unique.image(slug: "my-own-slug", size: "50x50", format: "bmp", set: "set1", bgset: "bg1")
users.each_with_index do |user, i|
  user.avatar.attach(io: URI.open(cover_url), filename: "company#{i}.jpg")
end

puts "Seeding Tweet"

User.all.each do |user|
  rand(1..4).times do
    Tweet.create(body: Faker::Lorem.sentence(word_count: 20), user: user)
  end
end

puts "Seeding RetWeedin"

Tweet.all.each do |tweet| 
  rand(1..4).times  do
      tweet.retweets.create(body: Faker::Lorem.sentence(word_count: 20), user: User.all.sample)
  end
end

puts "Seeding Like"

Tweet.all.each do |tweet|
  tweet.likes.create(tweet:tweet , user: User.all.sample)
end
