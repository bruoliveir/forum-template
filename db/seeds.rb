# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_discussion(discussion, parent)
  d = Discussion.create(:title => discussion['title'], :body => discussion['body'], :parent => parent)
  discussion['children'].each do |discussion|
    create_discussion(discussion, d)
  end unless discussion['children'].nil?
end

[
  # L1
  { 'title' => 'Thread 1', 'body' => 'Hello, this is root thread n. 1.', 'children' => [
    # L2
    { 'title' => 'Comment 1', 'body' => 'Hello, this is comment 1 on root thread n. 1.', 'children' => [
      # L3
      { 'title' => 'Comment 2', 'body' => 'Hello, this is comment 2 as a reply to comment 1 on root thread n. 1.' },
      { 'title' => 'Comment 3', 'body' => 'Hello, this is comment 3 as a reply to comment 1 on root thread n. 1.', 'children' => [
        # L4
        { 'title' => 'Comment 4', 'body' => 'Hello, this is comment 4 as a reply to comment 3 on comment n. 1.' }
      ]},
      # L3
      { 'title' => 'Comment 5', 'body' => 'Hello, this is comment 5 as a reply to comment 1 on root thread n. 1.' }
    ]},
    # L2
    { 'title' => 'Comment 6', 'body' => 'Hello, this is comment 6 on root thread n. 1.' }
  ]},
  # L1
  { 'title' => 'Thread 2', 'body' => 'Hello, this is root thread n. 2.', 'children' => [
    # L2
    { 'title' => 'Comment 1', 'body' => 'Hello, this is comment 1 on root thread n. 2.' },
    { 'title' => 'Comment 2', 'body' => 'Hello, this is comment 2 on root thread n. 2.' }
  ]}
].each do |discussion|
  create_discussion(discussion, nil)
end
