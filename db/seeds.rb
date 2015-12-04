require 'faker'

#Create users
# User.destroy_all
# Wiki.destroy_all

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

collab_users = users.to_a
collab_wikis = wikis.to_a
10.times do
  Collaboration.create!(
    user: collab_users.shift,
    wiki: collab_wikis.shift
  )
end
  
collabs = Collaboration.all
puts "#{User.count} users created!"
puts "#{Wiki.count} wikis created!"
puts "#{collabs.count} collaborations created!"
