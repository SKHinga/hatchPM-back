puts "🌱 Seeding spices..."

# Seed your database here
# 5.times do
#   User.create(
#     first_name: Faker::Name.name,
#     last_name: Faker::Name.unique.name,
#     gender: Faker::Gender.binary_type,
#     email: Faker::Internet.email,
#     password: Faker::Alphanumeric.alphanumeric(number: 10))
# end


#   rand(1..12).times do
#     # get a random user for every review
#     # https://stackoverflow.com/a/25577054
#     user = User.order('RANDOM()').first

#     Project.create(
#       project_name: Faker::Name.name,
#       project_scope: Faker::Name.unique.name,
#       deadline: Faker::Date.forward(days: 23),
#       description: Faker::Lorem.sentence,
#       progress: Faker::Boolean.boolean,
#       user_id: user.id)
#   end

#   rand(1..15).times do
#     # get a random user for every review
#     # https://stackoverflow.com/a/25577054
#     proj = Project.order('RANDOM()').first

#     Task.create(
#       task_name: Faker::Name.name,
#       check: Faker::Boolean.boolean,
#       project_id: proj.id)
#   end




puts "✅ Done seeding!"
