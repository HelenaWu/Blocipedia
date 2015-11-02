require 'faker'

#Create users
10.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'helloworld'
    )
end
users = User.all

levels = ['public', 'private']

100.times do
  Wiki.create!(
    subject: Faker::Lorem.sentence,
    level: levels.sample,
    body: Faker::Lorem.paragraph,
    user: users.sample
  )
end
wikis = Wiki.all

50.times do
  Collaboration.create!(
    user: users.sample,
    wiki: wikis.sample
  )
end
  
collabs = Collaboration.all
puts "#{users.count} users created!"
puts "#{wikis.count} wikis created!"
puts "#{collabs.count} collaborations created!"
