# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Removing current entities if any..."
Article.destroy_all
Tag.destroy_all

puts
puts "Filling the database with tags..."

[:foo, :bar, :baz].each do |tag|
  print "#{ tag } "
  Tag.create(:name => tag)
end

puts
puts "Filling the database with articles..."

1.upto(1000) do |i|
  print "#{ i }"
  article = Article.new(:title => Faker::Lorem.word, :content => Faker::Lorem.paragraph)
  Tag.all.each do |tag|
    article.tags << tag if rand(2) == 0
  end
  print "(#{ article.tags.map(&:name).join(',') }) "
  article.save
end


puts
puts "Completed"
