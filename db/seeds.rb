require "open-uri"

InstaPost.delete_all
FavouriteInstaPost.delete_all
TwitterPost.delete_all
FavouriteTwitterPost.delete_all
InstaProfile.delete_all
FavouriteInstaProfile.delete_all
TwitterProfile.delete_all
FavouriteTwitterProfile.delete_all
FavouriteList.delete_all
List.delete_all
User.delete_all

p "Database cleared"
p "................................"

# Create a user
user = User.new(
  username: "demo",
  email: "demo@lewagon.com",
  password: "123456"
)

if user.valid?
  user.save
  puts "User #{user.username} saved succesfully."
else
  puts "User #{user.username} failed to save."
  puts "Errors: #{user.errors.messages}"
end

# Create 2 lists
list1 = List.new(
  user: user,
  name: "Writing"
)

if list1.valid?
  list1.save
  puts "List #{list1.name} saved succesfully."
else
  puts "List #{list1.name} failed to save."
  puts "Errors: #{list1.errors.messages}"
end

list2 = List.new(
  user: user,
  name: "Food"
)

if list2.valid?
  list2.save
  puts "List #{list2.name} saved succesfully."
else
  puts "List #{list2.name} failed to save."
  puts "Errors: #{list2.errors.messages}"
end

# Creating 3 Insta profiles
insta_profile_data = [
  {
    username: "BurgerRater",
    list: List.find_by(name: "Food"),
    profile_picture_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpn5-3rIz4yS0icubE8vMeTIao-C7YN6dipQ&usqp=CAU"
  },

  {
    username: "ChefRamsay",
    list: List.find_by(name: "Food"),
    profile_picture_url: "https://pbs.twimg.com/profile_images/1448696882746695683/Jp2_LEBL_400x400.jpg"
  },

  {
    username: "StephenKing",
    list: List.find_by(name: "Writing"),
    profile_picture_url: "https://images.gr-assets.com/authors/1362814142p8/3389.jpg"
  },

]

insta_profile_data.each do |profile|
  new_profile = InstaProfile.new(
    username: profile[:username],
    list: profile[:list],
    profile_picture_url: profile[:profile_picture_url],
  )

  if new_profile.valid?
    new_profile.save
    puts "New profile #{new_profile.username} saved succesfully."
    new_profile.photo.attach(io: URI.open(new_profile.profile_picture_url), filename: "seed-content.png", content_type: "image/png")
    puts new_profile.photo.attached? ? "Image attached" : "Image Failed to attach"
  else
    puts "Profile #{new_profile.username} failed to save."
    puts "Errors: #{new_profile.errors.messages}"
  end
end

# Creating insta posts per profile
insta_posts_data = [
  {
    caption: "A delicious burger 😍! A perfect burger!

    Possibly the best burger I've ever tasted! 🤤

    7/10",
    media_url: "https://media-cdn.tripadvisor.com/media/photo-s/1a/e7/61/92/20200209-130439-largejpg.jpg",
    insta_profile: InstaProfile.find_by(username: "BurgerRater")
  },
  {
    caption: "This burger literally saved my marraige.  Didn't taste too good though.  3/10",
    media_url: "https://www.umami.site/wp-content/uploads/2018/10/blended-mushroom-beef-burger-recipe.jpg",
    insta_profile: InstaProfile.find_by(username: "BurgerRater")
  },
  {
    caption: "A perfect pot roast.  Look at that.",
    media_url: "https://therecipecritic.com/wp-content/uploads/2020/09/potroast-500x500.jpg",
    insta_profile: InstaProfile.find_by(username: "ChefRamsay")
  },
  {
    caption: "The perfect sushi rolls from gracademy!! Filled with all the good stuff - salmon, avocado and a hearty helping of soy sauce!",
    media_url: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/recipe-image-legacy-id-837452_11-fbff219.jpg",
    insta_profile: InstaProfile.find_by(username: "ChefRamsay")
  },
  {
    caption: "CITY OF DREAMS, by Don Winslow: It's a crime classic. Winslow's best book, by far. You won't put it down. I think it's published next month.",
    media_url: "https://i.harperapps.com/covers/9780062851239/y648.jpg",
    insta_profile: InstaProfile.find_by(username: "StephenKing")
  },
  {
    caption: "THE CURATOR, by Owen King: On sale today. The unabridged audio is read by Marin Ireland. It's a bravura performance.",
    media_url: "https://is1-ssl.mzstatic.com/image/thumb/Publication112/v4/d6/ca/a3/d6caa3ea-9da8-13b3-cac6-bf6d99b5deae/9781982196820.jpg/1200x630wz.png",
    insta_profile: InstaProfile.find_by(username: "StephenKing")
  },

]

insta_posts_data.each do |post|
  new_post = InstaPost.new(
    caption: post[:caption],
    media_url: post[:media_url],
    timestamp: rand(1600000000..1678447387).to_s,
    insta_profile: post[:insta_profile]
  )

  if new_post.valid?
    new_post.save
    puts "New post (#{new_post.id}) saved."
    new_post.photo.attach(io: URI.open(new_post.media_url), filename: "seed-post-image.png", content_type: "image/png")
    puts new_post.photo.attached? ? "Image attached" : "Image Failed to attach"
  else
    puts "Post failed to save for #{post.insta_profile}."
    puts "Errors: #{new_post.errors.messages}"
  end
end

puts "----------------------------------------------"
puts "TWITTER"
puts "----------------------------------------------"

twitter_profile_data = [
  {
    username: "PatrickRothfuss",
    list: List.find_by(name: "Writing"),
    profile_picture_url: "https://assets.wired.com/photos/w_660/wp-content/uploads/2014/10/rothfuss-inline.jpg"
  },

  {
    username: "neilhimself",
    list: List.find_by(name: "Writing"),
    profile_picture_url: "https://literature.britishcouncil.org/assets/Uploads/writers/_resampled/FillWyI2ODAiLCI2ODAiXQ/Neil-Gaiman-c-Kimberley-Butler-web.jpg"
  },
]


twitter_profile_data.each do |profile|
  new_profile = TwitterProfile.new(
    username: profile[:username],
    list: profile[:list],
    profile_picture_url: profile[:profile_picture_url]
  )

  if new_profile.valid?
    new_profile.save
    puts "New twitter #{new_profile.username} saved succesfully."
    new_profile.photo.attach(io: URI.open(new_profile.profile_picture_url), filename: "seed-content.png", content_type: "image/png")
    puts new_profile.photo.attached? ? "Image attached" : "Image Failed to attach"
  else
    puts "Profile #{new_profile.username} failed to save."
    puts "Errors: #{new_profile.errors.messages}"
  end
end



twit_posts_data = [
  {
    caption: "What a fabulous list to be on! it's an honour to be nominated. https://twitter.com/deloftheendless/status/1633396274559844353",
    media_url: "none",
    twitter_profile: TwitterProfile.find_by(username: "neilhimself")
  },

  {
    caption: "Whenever you start to question your own artistic choices, just remember: Picasso drew a butt.",
    media_url: "https://i.pinimg.com/originals/64/c5/ea/64c5ea82d82f916a9b6b2984961236a7.jpg",
    twitter_profile: TwitterProfile.find_by(username: "PatrickRothfuss")
  },

  {
    caption: "Was surprised (flattered) to be mentioned here. Then dug up the thread it mentioned because I didn't remember posting  anything inspirational.

    Sharing to show that simply being open about your struggle can sometimes be enough to help another person:

    https://twitter.com/PatrickRothfuss/status/1525268593457479681",
    media_url: "none",
    twitter_profile: TwitterProfile.find_by(username: "PatrickRothfuss")
  }
]

twit_posts_data.each do |post|
  new_post = TwitterPost.new(
    caption: post[:caption],
    media_url: post[:media_url],
    timestamp: rand(1600000000..1678447387).to_s,
    twitter_profile: post[:twitter_profile]
  )

  if new_post.valid?
    new_post.save
    puts "New tweet (#{new_post.id}) saved."
    unless new_post.media_url == "none"
      new_post.photo.attach(io: URI.open(new_post.media_url), filename: "seed-tweet-image.png", content_type: "image/png")
      puts new_post.photo.attached? ? "Image attached" : "Image Failed to attach"
    end
  else
    puts "Tweet failed to save for #{post.twitter_profile}."
    puts "Errors: #{new_post.errors.messages}"
  end
end
