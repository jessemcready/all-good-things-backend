# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# create_table "comments", force: :cascade do |t|
#   t.integer "user_id"
#   t.integer "post_id"
#   t.text "content"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end
#
# create_table "likes", force: :cascade do |t|
#   t.integer "user_id"
#   t.integer "post_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end
#
# create_table "posts", force: :cascade do |t|
#   t.integer "user_id"
#   t.text "content"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end
#
# create_table "relationships", force: :cascade do |t|
#   t.integer "follower_id"
#   t.integer "followee_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end
#
# create_table "users", force: :cascade do |t|
#   t.string "name"
#   t.string "email"
#   t.string "password"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

puts 'creating users'
User.create(name: "Jesse McReady", email: 'jessemcready@gmail.com', password: 'jesse1')
User.create(name: "Bobby Flay", email: 'bflay@gmail.com', password: 'bobbyburgers')
puts 'done creating users'

puts 'lets make a relationship'
Relationship.create(follower_id: User.first.id, followee_id: User.last.id)
puts 'done with relationship'

puts 'making post'
Post.create(user_id: User.first.id, content: "This is the seed post")
puts 'high quality post here'

puts 'liking post'
Like.create(user_id: User.last.id, post_id: Post.first.id)
puts 'done liking'

puts 'leaving comment'
Comment.create(user_id: User.last.id, post_id: Post.first.id, content: 'damn that was  really solid post')
puts 'left that shit'
